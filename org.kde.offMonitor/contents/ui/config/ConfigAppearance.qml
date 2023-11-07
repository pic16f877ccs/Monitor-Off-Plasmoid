import QtQuick 2.15
import org.kde.plasma.configuration 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: configAppearence
    property alias cfg_iconSizeConfig: slidSlidAppearance.sliderValueAt
    anchors.fill: parent

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
}
