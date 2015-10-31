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

    Column {
        id: device
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: file.bottom
        anchors.leftMargin: 30
        anchors.topMargin: 50
        spacing: 5
        width: parent.width

        ListModel {
            id: devicesListModel
            dynamicRoles: true
        }

        Component {
            id: devicesListDelegate

            CheckboxDelegate {
                onClicked: {
                    schedulerConfig.dongleNr = index + 1;
                    schedulerConfig.dataSource = 1;
                    captureList.Stack.view.push(
                                {item: Qt.resolvedUrl("qrc:/CommonElements/PleaseWait.qml"), replace: true});
                    if (threadController.schedulerRunning)
                        threadController.stopScheduler();
                    else
                        threadController.startScheduler(schedulerConfig);
                }
            }
        }

        Component.onCompleted: {
            var newModel = [];
            var devices = threadController.getDevices();
            for (var i = 0; i < devices.length; i++) {
                newModel.push({"name": devices[i]});
            }

            devicesList.model.clear();
            devicesList.model.append(newModel);
        }

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
            delegate: devicesListDelegate
            height: parent.height - labelDevice.height - 20
            model: devicesListModel
            spacing: 10
            width: parent.width
            clip: true
        }
    }
}
