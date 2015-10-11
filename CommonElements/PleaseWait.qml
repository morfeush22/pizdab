import QtQuick 2.5
import QtQuick.Controls 1.2

Rectangle {
    id: pleaseWait
    property bool backButtonBarVisible: false

    Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        text: {
            "pleaseWait"
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
