import QtQuick 2.15
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.configuration 2.0

ConfigModel {
    
    ConfigCategory {
        name: i18n("Delay")
        icon: "chronometer"
        source: "config/ConfigDelay.qml"
    }
    ConfigCategory {
        name: i18n("Appearance")
        icon: "preferences-desktop-color"
        source: "config/ConfigAppearance.qml"
    }
}
