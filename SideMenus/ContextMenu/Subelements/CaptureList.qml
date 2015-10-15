import QtQuick 2.5
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2

Rectangle {
    id: captureList
    property string title
    property bool backButtonBarVisible: true
    color: "#D9D9D9"

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            schedulerConfig.inputFilename = fileDialog.fileUrl;
            captureList.Stack.view.push(
                        {item: Qt.resolvedUrl("qrc:/CommonElements/PleaseWait.qml"), replace: true});
            if (threadController.schedulerRunning)
                threadController.stopScheduler();
            else
                threadController.startScheduler(schedulerConfig);
        }
    }

    Column {
        anchors.fill: parent
        anchors.margins: 30
        spacing: 70

        Column {
            spacing: 5

            Item {
                width: 300
                height: 50

                Text {
                    id: labelText
                    anchors.fill: parent
                    text: "Start from file"
                    font.pixelSize: height/1.5
                    color: "#21201F"
                }

                /*
                Rectangle {
                    x: labelText.x - 10
                    y: labelText.y + labelText.contentHeight
                    width: 300
                    height: 3
                    color: "#FF6426"
                }
                */
            }

            ButtonDelegate {
                text: "Open file"
                onClicked: {
                    fileDialog.visible = true;
                }

            }
        }

        Column {
            Text {
                width: 300
                height: 50
                text: "Start from device"
                font.pixelSize: height/1.5
                color: "#21201F"
            }
        }

    }
    /*
    Button {
        text: threadController.schedulerRunning
        onClicked: {
            fileDialog.visible = true;
        }
    }
    */
}
