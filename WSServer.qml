import QtQuick 2.5
import QtWebSockets 1.0

Item {
    id: server
    property var wsData: []
    property var slData: []
    /*
    property var slData: [
        {"station_title": "1", "kbps": "1", "station_id": "1", "sub_channel_id": "1", "current_station": true},
        {"station_title": "2", "kbps": "2", "station_id": "2", "sub_channel_id": "2", "current_station": false},
        {"station_title": "3", "kbps": "3", "station_id": "3", "sub_channel_id": "3", "current_station": false},
        {"station_title": "4", "kbps": "4", "station_id": "4", "sub_channel_id": "4", "current_station": false},
        {"station_title": "5", "kbps": "5", "station_id": "5", "sub_channel_id": "5", "current_station": false}
    ];
    */

    WebSocketServer {
        port: 8080
        listen: true
        onClientConnected: {
            wsData.push(webSocket);
            //console.log(webSocket);
            webSocket.onTextMessageReceived.connect(function(message) {
                var parsedMessage = JSON.parse(message);
                var response = {};

                switch(parsedMessage.$type) {
                case "set":
                    threadController.changeStation(parsedMessage.$data);
                    response.$type = parsedMessage.$type;
                    response.$data = slData;
                    break;
                default:
                    response.$type = "err";
                    response.$data = {};
                }

                webSocket.sendTextMessage(JSON.stringify(response));
            });
            webSocket.onStatusChanged.connect(function(status) {
                if (status === WebSocket.Closed) {
                    //console.log("del");
                    //console.log(webSocket);
                    var index = wsData.indexOf(webSocket);
                    if (index > -1)
                        wsData.splice(index, 1);
                    //delete wsData[webSocket];
                    //console.log(wsData.length);
                }

            }.bind(this));
            webSocket.sendTextMessage(JSON.stringify({"$type": "init", "$data": slData}));
        }
        onErrorStringChanged: {
            console.log(errorString);
        }
    }

    Connections {
        target: threadController
        onStationListChanged: {
            var stationList = [];

            for (var i = 0; i < threadController.stationList.length; i++) {
                var currentStation = false;
                if (threadController.stationList[i].stationId === threadController.userFICExtraData.currentStationId)
                    currentStation = true;

                stationList.push(
                            {"station_title": threadController.stationList[i].stationName,
                            "kbps": threadController.stationList[i].audioKbps,
                            "station_id": threadController.stationList[i].stationId,
                            "sub_channel_id": threadController.stationList[i].subChannelId,
                            "current_station": currentStation});
            }
            slData = stationList;
            var response = {
                "$type": "up",
                "$data": slData
            };

            for (i = 0; i < wsData.length; i++) {
                wsData[i].sendTextMessage(JSON.stringify(response));
            }
        }
    }
}
