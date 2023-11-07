import QtQuick 2.15
import QtQuick.Controls 2.0
import org.kde.plasma.configuration 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: configDelay
    property alias cfg_delayConfig: slidSlidDelay.sliderValueAt
    anchors.fill: parent

    SliderSlider {
        id: slidSlidDelay
        sliderFrom: 0
        sliderTo: 10
        sliderStep: 1.0
        sliderText: "Change delay"

        Component.onCompleted: slidSlidDelay.sliderValue = plasmoid.configuration.delayConfig
    }
}
