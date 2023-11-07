import QtQuick 2.15
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {
    id: mainButton
    readonly property bool vertical: (plasmoid.formFactor == PlasmaCore.Types.Vertical)
    property real delayConfig: plasmoid.configuration.delayConfig * 1000
    property real iconSizeConfig: vertical ?
         mainButton.width + plasmoid.configuration.iconSizeConfig :
         mainButton.height + plasmoid.configuration.iconSizeConfig;

    property double anySide: inPanel ? undefined : mainButton.height + mainButton.width
    readonly property bool inPanel: [
        PlasmaCore.Types.TopEdge,
        PlasmaCore.Types.RightEdge,
        PlasmaCore.Types.BottomEdge,
        PlasmaCore.Types.LeftEdge
    ].includes(Plasmoid.location);

    anchors.centerIn: parent

    onAnySideChanged: { 
        buttonIcon.width = mainButton.height;
        buttonIcon.height = mainButton.width;
        buttonIcon.width = mainButton.height >= mainButton.width ? mainButton.width :
             mainButton.height;
        buttonIcon.height = mainButton.height <= mainButton.width ? mainButton.height :
             mainButton.width;
    }

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
            buttonIcon.height = mainButton.iconSizeConfig
            buttonIcon.width = mainButton.iconSizeConfig
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
        id: buttonIcon
        svg: img
        elementId: "monitor-monitor"  
        anchors.centerIn: parent
        smooth: true

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
            enabled: inPanel
            target: mainButton
            onIconSizeConfigChanged: {
                buttonIcon.height = mainButton.iconSizeConfig
                buttonIcon.width = mainButton.iconSizeConfig
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
                buttonIcon.width = Math.round(mainButton.iconSizeConfig * 0.75)
                buttonIcon.height = Math.round(mainButton.iconSizeConfig * 0.75)
                timer.start();
            }
        }

        Component.onCompleted: {
            buttonIcon.height = mainButton.iconSizeConfig
            buttonIcon.width = mainButton.iconSizeConfig
        }
    }
}
