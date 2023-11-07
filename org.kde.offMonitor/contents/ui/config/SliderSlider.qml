import QtQuick 2.15
import QtQuick.Controls 2.15
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: sliderItem
    property alias sliderValueAt: sliderSlider.sliderSliderValueAt
    property alias sliderValue: sliderSlider.value
    property real sliderHeight: 120 * units.devicePixelRatio
    property real sliderFrom: 0
    property real sliderTo: 10
    property real sliderStep: 1
    property string sliderText: "Slider Text"

    height: sliderHeight
    anchors.horizontalCenter: parent.horizontalCenter
    anchors.left: parent.left
    anchors.right: parent.right

    Rectangle {
        id: sliderRec
        width: parent.width
        height: parent.height
        border.width: units.devicePixelRatio
        border.color: PlasmaCore.ColorScope.highlightColor
        radius: units.devicePixelRatio
        color: PlasmaCore.ColorScope.backgroundColor
        Text {
            anchors.top: parent.top
            anchors.topMargin: 12 * units.devicePixelRatio
            anchors.horizontalCenter: sliderRec.horizontalCenter
            text: sliderItem.sliderText
            font.pixelSize: 24 * units.devicePixelRatio
            color: PlasmaCore.ColorScope.textColor
        }

        Slider {
            id: sliderSlider
            property real sliderSliderValueAt
            from: sliderItem.sliderFrom
            to: sliderItem.sliderTo
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
            width: parent.width - handleRect.width * 2
            height: handleRect.width * 2
            stepSize: sliderItem.sliderStep
            snapMode: Slider.SnapAlways

            background: Rectangle {
                id: backgroundRect
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                height: 5 * units.devicePixelRatio
                radius: height / 2
                color: Qt.darker(PlasmaCore.ColorScope.highlightedTextColor, 1.5)

                Rectangle {
                    id: variableRec
                    width: sliderSlider.visualPosition * parent.width
                    height: parent.height
                    radius: backgroundRect.radius
                    color: PlasmaCore.ColorScope.highlightColor
                }
            }

            handle: Rectangle {
                id: handleRect
                x: sliderSlider.visualPosition * sliderSlider.width - handleRect.radius
                anchors.verticalCenter: parent.verticalCenter
                width: 18 * units.devicePixelRatio
                height: width
                radius: width / 2
                border.width: units.devicePixelRatio
                border.color: PlasmaCore.ColorScope.highlightColor
                color: sliderSlider.pressed ? Qt.darker(PlasmaCore.ColorScope.highlightColor, 0.75) : PlasmaCore.ColorScope.backgroundColor
            }

            onMoved: {
                sliderSlider.sliderSliderValueAt = sliderSlider.valueAt(sliderSlider.position)
            }
        }

        Row {
            id: scalaRow
            property real scalaRecWidth: units.devicePixelRatio * 2
            anchors.horizontalCenter: sliderRec.horizontalCenter
            anchors.top: sliderSlider.bottom
            anchors.topMargin: units.devicePixelRatio
            width: sliderSlider.width
            spacing: (scalaRow.width - scalaRepeater.model * scalaRecWidth) / ((sliderSlider.to - sliderSlider.from) / sliderSlider.stepSize)

            Repeater{
                id:scalaRepeater
                model: ((sliderSlider.to - sliderSlider.from) / sliderSlider.stepSize) + 1
                Rectangle {
                    id: scalaRec
                    width: scalaRow.scalaRecWidth
                    height: units.devicePixelRatio * 10
                    color: PlasmaCore.ColorScope.highlightColor

                    Label {
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.top: parent.bottom
                        anchors.topMargin: units.devicePixelRatio * 8
                        text: (index * sliderSlider.stepSize) + sliderSlider.from
                        color: PlasmaCore.ColorScope.textColor
                    }
                }
            }
        }
    }
}
