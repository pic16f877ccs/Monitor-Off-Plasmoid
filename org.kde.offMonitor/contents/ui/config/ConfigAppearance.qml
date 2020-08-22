import QtQuick 2.1
import QtQuick.Controls 2.0
import org.kde.plasma.configuration 2.0

Item { 
    property alias cfg_iconSizeConfig: setIconSize.currentValue
    
    Column {
        spacing: 15
        ComboBox {
            id: setIconSize
            textRole: "text"
            valueRole: "value"
            model: [
                { value: "16", text: "Icon Seize Small" },
                { value: "22", text: "Icon Seize SmallMedium" },
                { value: "32", text: "Icon Seize Medium" }
            ]
                     
            Component.onCompleted: {
                currentIndex= indexOfValue(plasmoid.configuration.iconSizeConfig)                
            }
        }
    }
}
