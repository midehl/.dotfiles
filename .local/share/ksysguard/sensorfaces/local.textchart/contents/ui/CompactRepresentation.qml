/*
    Icon + value compact view for the local.textchart hybrid face.
    Based on org.kde.ksysguard.textonly (LGPL-2.0-or-later).
*/

import QtQuick
import QtQuick.Controls as QQC2
import QtQuick.Layouts

import org.kde.kirigami as Kirigami

import org.kde.ksysguard.sensors as Sensors
import org.kde.ksysguard.faces as Faces
import org.kde.ksysguard.formatter as Formatter

Faces.CompactSensorFace {
    id: root

    function iconFor(sensorId) {
        if (sensorId.indexOf("cpu/") === 0) return Qt.resolvedUrl("../icons/cpu-icon.svg");
        if (sensorId.indexOf("gpu/") === 0) return Qt.resolvedUrl("../icons/gpu-icon.svg");
        if (sensorId.indexOf("memory/swap") === 0) return "drive-harddisk-symbolic";
        if (sensorId.indexOf("memory/") === 0) return Qt.resolvedUrl("../icons/ram-memory-icon.svg");
        if (sensorId.indexOf("download") !== -1) return "arrow-down-symbolic";
        if (sensorId.indexOf("upload") !== -1) return "arrow-up-symbolic";
        return "dialog-information";
    }

    Layout.minimumWidth: horizontalFormFactor ? Math.max(contentItem.implicitWidth, defaultMinimumSize) : defaultMinimumSize
    Layout.preferredWidth: horizontalFormFactor ? contentItem.implicitWidth : -1
    Layout.maximumWidth: horizontalFormFactor ? Math.max(contentItem.implicitWidth, defaultMinimumSize) : -1

    contentItem: RowLayout {
        spacing: Kirigami.Units.smallSpacing

        Repeater {
            model: root.controller.highPrioritySensorIds

            RowLayout {
                spacing: Math.round(Kirigami.Units.smallSpacing / 2)

                Kirigami.Icon {
                    source: root.iconFor(modelData)
                    Layout.preferredWidth: Kirigami.Units.iconSizes.small
                    Layout.preferredHeight: Kirigami.Units.iconSizes.small
                    Layout.alignment: Qt.AlignVCenter
                }

                QQC2.Label {
                    id: valueLabel
                    readonly property bool isNet: modelData.indexOf("network/") === 0

                    text: isNet ? ((sensor.value || 0) / 1e6).toFixed(1) + " MB/s" : sensor.formattedValue
                    Layout.preferredWidth: isNet ? netMetrics.width : Formatter.Formatter.maximumLength(sensor.unit, font)
                    Layout.alignment: Qt.AlignVCenter

                    TextMetrics {
                        id: netMetrics
                        font: valueLabel.font
                        text: "888.8 MB/s"
                    }

                    Sensors.Sensor {
                        id: sensor
                        sensorId: modelData
                        updateRateLimit: root.controller.updateRateLimit
                    }
                }
            }
        }
    }
}
