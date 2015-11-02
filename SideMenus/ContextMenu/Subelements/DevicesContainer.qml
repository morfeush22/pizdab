import QtQuick 2.5
import QtQuick.Controls 1.2

Column {
    id: devicesContainer
    spacing: 5

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
