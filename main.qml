import QtQuick 2.5
import SDRDAB 1.0

Loader {//Just loader, since there's only one.
    source: "./pizdab.qml"
    focus: true
    // Exception to the standard sizing, because this is primarily a desktop
    // example and it benefits from being able to see everything at once.
    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            console.log("triggered");
            console.log(threadController.stationList.length ? threadController.stationList[0].stationName : "no name");
        }
    }
    onLoaded: load()
    QSchedulerConfig {
        id: mainConfig
    }
    function load() {
        threadController.startScheduler(mainConfig);
    }
}
