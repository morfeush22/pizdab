import QtQuick 2.5
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2

Rectangle {
    id: captureList
    property bool backButtonBarVisible: true
    property string title
    color: "#D9D9D9"
    //
    property var tab: ["b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l"]

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

    //Column {
    //    id: container
    //    anchors.fill: parent
    //    anchors.margins: 30
    //    spacing: 70

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

        Column {
            id: device
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.top: file.bottom
            anchors.leftMargin: 30
            anchors.topMargin: 50
            spacing: 5
            width: parent.width

            Item {
                id: labelDevice
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

            ListView {
                id: devicesList
                delegate: CheckboxDelegate {}
                model: tab
                height: parent.height - labelDevice.height - 20
                spacing: 10
                width: parent.width
                clip: true
            }
        }
    //}
}
