import QtQuick 2.5
import "./Subelements"

Row {
    id: stationList

    Rectangle {
        color: "#403E3C"
        height: stationList.height
        width: 1
    }

    Rectangle {
        id: context
        color: "#D9D9D9"
        height: stationList.height
        width: stationList.width

        ListModel {
            id: stationListNavListModel
            dynamicRoles: true
        }

        StationListNavListDelegate {
            id: stationListNavListDelegate
        }

        ListView {
            id: stationListNavList
            delegate: stationListNavListDelegate
            height: parent.height
            width: parent.width
            model: stationListNavListModel 
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
}
