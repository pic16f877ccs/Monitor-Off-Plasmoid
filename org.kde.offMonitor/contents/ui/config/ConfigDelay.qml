import QtQuick 2.0
import QtQuick.Controls 2.0
import org.kde.plasma.configuration 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: configDelay
    width: childrenRect.width
    height: childrenRect.height
    property var cfg_delayConfig
 
    Column {
        id: columnConfig
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 15
      
        Rectangle {
            id: sliderDelay
            anchors.horizontalCenter: parent.horizontalCenter
            width: columnConfig.width
            height: 96* units.devicePixelRatio
            border.width: 2
            border.color: PlasmaCore.ColorScope.highlightColor
            radius: 3
            color: PlasmaCore.ColorScope.backgroundColor
            Slider {
                id: control
                from: 0
                value: cfg_delayConfig
                to: 10
                anchors.verticalCenter: sliderDelay.verticalCenter
                anchors.horizontalCenter: sliderDelay.horizontalCenter
                stepSize: 1.0
                snapMode: Slider.SnapAlways
                background: Rectangle {
                    id: backgroundRect
                    x: control.leftPadding
                    y: control.topPadding + control.availableHeight / 2 - height / 2
                    implicitWidth: sliderDelay.width-20
                    implicitHeight: units.devicePixelRatio * 5
                    width: control.availableWidth
                    height: implicitHeight
                    radius: implicitHeight / 2
                    color: "#bdbebf"

                    Rectangle {
                        width: control.visualPosition * parent.width
                        height: parent.height
                        color: "#21be2b"
                        radius: backgroundRect.implicitHeight/ 2
                    }
                }

                handle: Rectangle {
                    id: handleRect
                    x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
                    y: control.topPadding + control.availableHeight / 2 - height / 2
                    implicitWidth: units.devicePixelRatio * 18
                    implicitHeight: implicitWidth
                    radius: implicitWidth / 2
                    color: control.pressed ? "#f0f0f0" : "#f6f6f6"
                    border.color: "#bdbebf"
                }
            
                onMoved: {
                    cfg_delayConfig=valueAt(position)
                }
                
            }
            Row {
                anchors.horizontalCenter: sliderDelay.horizontalCenter
                anchors.bottom: sliderDelay.bottom
                anchors.bottomMargin: 48
                spacing: backgroundRect.implicitWidth / 10-7.5
                Repeater{
                    id:sliderRepeater
                    model: 11
                    Rectangle{
                        width: 4
                        height: 20
                        color: PlasmaCore.ColorScope.highlightColor
                    }
                }
            }
            Row {
                anchors.horizontalCenter: sliderDelay.horizontalCenter
                anchors.bottom: sliderDelay.bottom
                anchors.bottomMargin: 16
                spacing: backgroundRect.implicitWidth / 10-14
                Repeater{
                    id:textRepeater
                    model: 11
                    Rectangle{
                        id: labelRect
                        width: 10
                        height: 10
                        color: 'transparent'

                        Label {
                            anchors.centerIn: labelRect
                            text: index
                            color: PlasmaCore.ColorScope.textColor
                        }
                    }
                }
            }
        }
    }
}
