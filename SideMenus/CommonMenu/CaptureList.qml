import QtQuick 2.5
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2

Rectangle {
    id: captureList
    property string title
    property bool backButtonBarVisible: true

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            schedulerConfig.inputFilename = fileDialog.fileUrl;
            //console.log("You chose: " + schedulerConfig.inputFilename);
            captureList.Stack.view.push(
                        {item: Qt.resolvedUrl("qrc:/SideMenus/CommonMenu/PleaseWait.qml"), replace: true});
            if (threadController.schedulerRunning)
                threadController.stopScheduler();
            else
                threadController.startScheduler(schedulerConfig);
        }
        onRejected: {
            console.log("Canceled")
        }
    }

    Button {
        text: threadController.schedulerRunning
        onClicked: {
            fileDialog.visible = true;
            /*
            captureList.Stack.view.push(
                        {item: Qt.resolvedUrl("qrc:/SideMenus/CommonMenu/PleaseWait.qml"), replace: true});
            if (threadController.schedulerRunning)
                threadController.stopScheduler();
            else
                threadController.startScheduler(schedulerConfig);
            */
        }
    }
}

