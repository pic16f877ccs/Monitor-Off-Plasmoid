import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: mainButton
        readonly property bool vertical: (plasmoid.formFactor == PlasmaCore.Types.Vertical)
        readonly property bool horizontal: (plasmoid.formFactor == PlasmaCore.Types.Horizontal)
        property real iconSizeConfig: vertical ? width + plasmoid.configuration.iconSizeConfig : height + plasmoid.configuration.iconSizeConfig
        property real delayConfig: plasmoid.configuration.delayConfig * 1000
        anchors.centerIn: parent
        Layout.fillHeight: horizontal
        Layout.fillWidth: vertical

    Timer {
        id: monitor_control_delay
        function setTimeout(callback , delayTime) {
            monitor_control_delay.interval = delayTime;
            monitor_control_delay.repeat = false;
            monitor_control_delay.triggered.connect(callback);
            monitor_control_delay.triggered.connect(function release() {
                monitor_control_delay.triggered.disconnect(callback);
                monitor_control_delay.triggered.disconnect(release);
            });
            monitor_control_delay.start();
        }
    }
    
    Timer {
        id: timer
        interval: 300
        repeat: false
        running: false

        onTriggered: {        
            monitor.implicitWidth = mainButton.iconSizeConfig
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
        implicitHeight: implicitWidth

        PlasmaCore.SvgItem {
            id: panel
            svg: img
            elementId: "monitor-panel"
            anchors.centerIn: parent
            anchors.fill: parent
            smooth: true
            opacity: 0.25
        }

        
        Connections {
            target: mainButton
            onIconSizeConfigChanged: {
               monitor.implicitWidth = mainButton.iconSizeConfig
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
           
            onClicked: monitor_control_delay.setTimeout(function() {
                shCommand.connectSource("dbus-send --session --type=method_call --dest=org.kde.kglobalaccel\
                /component/org_kde_powerdevil org.kde.kglobalaccel.Component.invokeShortcut string:'Turn Off Screen'") },
                mainButton.delayConfig); 

            onPressed: {
                monitor.implicitWidth = Math.round(mainButton.iconSizeConfig * 0.75)
                timer.start();
            }
        }

        Component.onCompleted: {
            monitor.implicitWidth = mainButton.iconSizeConfig
        }
    }
}

