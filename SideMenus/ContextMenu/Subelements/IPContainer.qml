import QtQuick 2.5

Column {
    id: ipContainer

    ListModel {
        id: addressesListModel
        dynamicRoles: true
    }

    Component {
        id: addressesListDelegate

        Text {
            font.pixelSize: 12
            text: address
        }
    }

    Component.onCompleted: {
        var newModel = [];
        var addresses = hostInfo.addresses();

        for (var i = 0; i < addresses.length; i++) {
            newModel.push({"address": addresses[i]});
        }

        addressesList.model.clear();
        addressesList.model.append(newModel);
    }

    Text {
        id: label
        color: "#21201F"
        font.pixelSize: height/1.5
        height: 25
        width: 300
        text: "IP addresses"
    }

    ListView {
        id: addressesList
        clip: true
        delegate: addressesListDelegate
        height: parent.height - label.height - 20
        width: 300
        model: addressesListModel
    }
}
