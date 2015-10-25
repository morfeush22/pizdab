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

        Column {
            spacing: 5

            Item {
                height: 50
                width: 300

                Text {
                    id: labelTextDevice
                    anchors.fill: parent
                    color: "#21201F"
                    font.pixelSize: height/1.5
                    text: "Start from device"
                }
            }
        }
    }
}
