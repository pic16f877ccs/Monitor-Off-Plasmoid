import QtQuick 2.1
import QtQuick.Controls 2.0
import org.kde.plasma.configuration 2.0

Item { 
    property alias cfg_delayConfig: setDelay.currentValue
    
    Column {
        spacing: 15
        ComboBox {
            id: setDelay
            textRole: "text"
            valueRole: "value"
            model: [
                { value: " 1", text: "1 s" },
                { value: " 2", text: "2 s" },
                { value: " 3", text: "3 s" }
            ]
                     
            Component.onCompleted: {
                currentIndex= indexOfValue(plasmoid.configuration.delayConfig)                
            }
        }
    }
}
