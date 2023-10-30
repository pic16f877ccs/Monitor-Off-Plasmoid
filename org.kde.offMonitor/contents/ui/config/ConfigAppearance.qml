import QtQuick 2.0
import QtQuick.Controls 2.0
import org.kde.plasma.configuration 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: configAppearence
    property alias cfg_iconSizeConfig: slidSlidAppearance.sliderValueAt
    anchors.fill: parent

    SliderSlider {
        id: slidSlidAppearance
        sliderFrom: 16
        sliderTo: 36
        sliderStep: 2.0
        sliderText: "Change icon size"

        Component.onCompleted: {
            slidSlidAppearance.sliderValue = plasmoid.configuration.iconSizeConfig
        }
    }
}

