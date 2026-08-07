// dock-migrate
// 1. When EXT transitions from absent to present, move every normal window off
//    INT onto it. Never migrates on script load.
// 2. Any window living on INT is pinned to all desktops (laptop screen acts as
//    a single static workspace). Its original desktop list is saved and
//    restored exactly when it moves off INT.
// ponytail: output names hardcoded to this machine's connectors.

const EXT = "HDMI-A-1";
const INT = "eDP-2";

function findOutput(name) {
    return workspace.screens.find(function (s) { return s.name === name; }) || null;
}

function moveTo(w, out) {
    if (typeof workspace.sendClientToScreen === "function") {
        workspace.sendClientToScreen(w, out);
    } else {
        // fallback: drop it at the target output's top-left area
        const g = out.geometry;
        w.frameGeometry = { x: g.x + 40, y: g.y + 40, width: w.width, height: w.height };
    }
}

function migrate() {
    const ext = findOutput(EXT);
    if (!ext) return;
    workspace.windowList().forEach(function (w) {
        if (w.normalWindow && w.output && w.output.name === INT) {
            moveTo(w, ext);
        }
    });
}

function updatePin(w) {
    if (!w.normalWindow) return;
    // laptop screen is a single workspace only while docked; undocked it's
    // normal virtual desktops (checked live - the cached flag can be stale
    // while windows are being evacuated during an unplug)
    if (findOutput(EXT) && w.output && w.output.name === INT) {
        if (!w.onAllDesktops) {
            w._dockDesktops = w.desktops.slice(); // remember original desktops
            w.onAllDesktops = true;
        }
    } else if (w._dockDesktops) {
        // restore the exact desktop list, dropping desktops deleted meanwhile
        let saved = w._dockDesktops.filter(function (d) {
            return workspace.desktops.indexOf(d) !== -1;
        });
        w.desktops = saved.length > 0 ? saved : [workspace.currentDesktop];
        w._dockDesktops = null;
    }
}

function track(w) {
    if (!w.normalWindow) return;
    w.outputChanged.connect(function () { updatePin(w); });
    updatePin(w);
}

let extPresent = !!findOutput(EXT);

workspace.screensChanged.connect(function () {
    const now = !!findOutput(EXT);
    if (now && !extPresent) migrate();
    extPresent = now;
    // re-evaluate pins on dock/undock: undocking restores every window's
    // saved desktops, docking pins whatever sits on the laptop screen
    workspace.windowList().forEach(updatePin);
});

workspace.windowAdded.connect(track);
workspace.windowList().forEach(track);
