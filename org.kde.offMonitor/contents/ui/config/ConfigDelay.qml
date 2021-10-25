import QtQuick 2.0
import QtQuick.Controls 2.0
import org.kde.plasma.configuration 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: configDelay
    property real cfg_delayConfig
    anchors.fill: parent

    SliderSlider {
        id: slidSlidDelay
        sliderFrom: 0
        sliderTo: 10
        sliderStep: 1.0
        sliderText: "Change off delay"
        onSliderValueAtChanged: configDelay.cfg_delayConfig = slidSlidDelay.sliderValueAt

        Component.onCompleted: slidSlidDelay.sliderValue = plasmoid.configuration.delayConfig
    }
}
