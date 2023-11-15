import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import org.kde.plasma.configuration 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3

Item {
    id: configAppearence
    property alias cfg_iconSizeConfig: slidSlidAppearance.sliderValueAt
    property alias cfg_iconShapeConfig: cirSqrIcon.checked

    ColumnLayout {
        spacing: 16 * units.devicePixelRatio
        anchors.left: parent.left
        anchors.right: parent.right
        SliderSlider {
            id: slidSlidAppearance
            sliderFrom: -8
            sliderTo: 8
            sliderStep: 2
            sliderText: "Icon size scaling"

            Component.onCompleted: {
                slidSlidAppearance.sliderValue = plasmoid.configuration.iconSizeConfig
            }
        }

        Rectangle {
            id: checkBoxRec
            Layout.fillWidth: true
            height: units.devicePixelRatio * 50
            border.width: units.devicePixelRatio
            border.color: PlasmaCore.ColorScope.highlightColor
            radius: units.devicePixelRatio
            color: PlasmaCore.ColorScope.backgroundColor

            PlasmaComponents3.CheckBox {
                id: cirSqrIcon
                text: i18n("Square icon")
                checked: true
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: checkBoxRec.left
                anchors.leftMargin: 16 * units.devicePixelRatio
            }
        }
    }
}
