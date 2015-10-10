import QtQuick 2.5
import QtQuick.Controls 1.2

Rectangle {
    id: captureList
    property string title
    property bool backButtonBarVisible: true

    Button {
        text: threadController.schedulerRunning
        onClicked: {
            captureList.Stack.view.push(
                        {item: Qt.resolvedUrl("qrc:/SideMenus/CommonMenu/PleaseWait.qml"), replace: true});
            if (threadController.schedulerRunning)
                threadController.stopScheduler();
            else
                threadController.startScheduler(schedulerConfig);
        }
    }
}
