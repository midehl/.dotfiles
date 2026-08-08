#!/bin/sh
# Install a boot service that disarms spurious ACPI wakeup sources on atlas:
#   RP12 - PCIe root port of the RTX 4090 dGPU
#   XHCI - USB 3 controller (also covers Bluetooth)
#   ASUP1207 touchpad - i2c-hid device on the INTC1083 GPIO (IRQ 14); glitchy
#     (kernel "touch jump" bugs) and was fully waking the machine from s2idle
#     every 15-90 min with the lid open (2026-08-08).
# RP12/XHCI fired GPE 6E every ~50s, waking the SoC during s2idle (battery
# drain, suspend-abort loop). See vault note "atlas sleep config" (2026-08-07).
# Trade-off: USB/Bluetooth keyboards and the touchpad cannot wake the machine;
# lid and power button still do. Undo: systemctl disable disarm-wakeup-sources;
# rm the unit.
set -eu

[ "$(id -u)" -eq 0 ] || { echo "run with sudo" >&2; exit 1; }

cat > /etc/systemd/system/disarm-wakeup-sources.service <<'EOF'
[Unit]
Description=Disarm RP12 (dGPU port), XHCI (USB) and touchpad wakeup sources

[Service]
Type=oneshot
ExecStart=/bin/sh -c 'for d in RP12 XHCI; do grep -q "^$d.*enabled" /proc/acpi/wakeup && echo $d > /proc/acpi/wakeup || true; done'
ExecStart=/bin/sh -c 'echo disabled > /sys/bus/i2c/devices/i2c-ASUP1207:00/power/wakeup || true'

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable disarm-wakeup-sources.service
systemctl start disarm-wakeup-sources.service

echo "Current state (RP12 and XHCI should be disabled):"
grep -E "^(RP12|XHCI)" /proc/acpi/wakeup
echo "Touchpad wakeup (should be disabled):"
cat /sys/bus/i2c/devices/i2c-ASUP1207:00/power/wakeup
