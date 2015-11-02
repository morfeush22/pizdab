import QtQuick 2.5
import QtQuick.Controls 1.2

Rectangle {
    id: pleaseWait

    property bool backButtonBarVisible: false

    color: "#D9D9D9"

    Image {
        id: loadingAnimation
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        smooth: true
        source: "qrc:/images/loading.png"

        NumberAnimation on rotation {
            from: 0
            to: 360
            duration: 900
            loops: Animation.Infinite
            running: loadingAnimation.visible === true
        }
    }

    Connections {
        target: threadController
        onSchedulerRunningChanged: {
            if (threadController.schedulerRunning)
                pleaseWait.Stack.view.pop();
            else
                threadController.startScheduler(schedulerConfig);
        }
    }
}
