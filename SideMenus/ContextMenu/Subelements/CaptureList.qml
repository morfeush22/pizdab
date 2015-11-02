import QtQuick 2.5
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2

Rectangle {
    id: captureList

    property bool backButtonBarVisible: true
    property string title

    color: "#D9D9D9"

    FileDialog {
        id: fileDialog
        folder: shortcuts.home
        title: "Please choose a file"

        onAccepted: {
            schedulerConfig.inputFilename = fileDialog.fileUrl;
            schedulerConfig.dataSource = 0;
            captureList.Stack.view.push(
                        {item: Qt.resolvedUrl("qrc:/CommonElements/PleaseWait.qml"), replace: true});
            if (threadController.schedulerRunning)
                threadController.stopScheduler();
            else
                threadController.startScheduler(schedulerConfig);
        }
    }

    Column {
        id: file
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 30
        anchors.topMargin: 50
        spacing: 5

        Item {
            id: labelFile
            height: 50
            width: 300

            Text {
                id: labelTextFile
                anchors.fill: parent
                color: "#21201F"
                font.pixelSize: height/1.5
                text: "Start from file"
            }
        }

        ButtonDelegate {
            text: "Open file"

            onClicked: {
                fileDialog.visible = true;
            }
        }
    }

    DevicesContainer {
        id: device
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: file.bottom
        anchors.leftMargin: 30
        anchors.topMargin: 50
        width: parent.width
    }
}
