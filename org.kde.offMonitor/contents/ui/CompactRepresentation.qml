import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: mainButton
    
    Timer {
        id: timer
        interval: 100
        repeat: false
        running: false

        onTriggered: {        
        monitor.implicitWidth= iconSizeValue
        }
    }
    
    PlasmaCore.DataSource {
        id:shCommand
        engine: "executable"
        connectedSources: []
        onNewData: disconnectSource(sourceName)
    }
    
    PlasmaCore.Svg {
        id: img
        imagePath: plasmoid.file("images", "offMonitor.svgz")
    }
    
    PlasmaCore.SvgItem {
        id: monitor
        svg: img
        elementId: "monitor-monitor"  
        anchors.centerIn: parent
        smooth: true
        implicitWidth: iconSizeValue 
        implicitHeight: implicitWidth

        PlasmaCore.SvgItem {
            id: panel
            svg: img
            elementId: "monitor-panel"
            anchors.fill: parent
            smooth: true
            opacity: 0.25
        }

        MouseArea {
            id: mouseArea1
            anchors.fill: parent
            
            onClicked: {
                shCommand.connectSource("sleep " + delayValue + " && xset dpms force off");
            }
            
            onReleased: {
                timer.start();
                monitor.implicitWidth= Math.round(iconSizeValue* 0.75 )
            }
        }
    }
}

