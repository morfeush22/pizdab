import QtQuick 2.5
import "Subelements"

Rectangle {
    id: stationList
    x: parent.width
    width: 125
    height: parent.height

    ListModel {
        id: stationListNavListModel
        dynamicRoles: true
    }

    StationListNavListDelegate {
        id: stationListNavListDelegate
    }

    ListView {
        id: stationListNavList
        width: parent.width
        height: parent.height
        model: stationListNavListModel
        delegate: stationListNavListDelegate
    }

    Connections {
        target: mainWindow.state === "stationListOpened" ? null : threadController
        onStationListChanged: {
            var newModel = [];
            for (var i = 0; i < threadController.stationList.length; i++) {
                newModel.push(
                            {"station_title": threadController.stationList[i].stationName,
                            "kbps": threadController.stationList[i].audioKbps,
                            "station_id": threadController.stationList[i].stationId,
                            "sub_channel_id": threadController.stationList[i].subChannelId})
            }
            stationListNavList.model.clear();
            stationListNavList.model.append(newModel);
        }
    }
}
