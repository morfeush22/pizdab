import QtQuick 2.5
import QtWebSockets 1.0

Item {
    id: server
    property var slData: []
    property var wsData: []  

    WebSocketServer {
        listen: true
        port: 8080

        onClientConnected: {
            wsData.push(webSocket);

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
                    var index = wsData.indexOf(webSocket);
                    if (index > -1)
                        wsData.splice(index, 1);
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

    function closeConnections() {
        for (var i = 0; i < wsData.length; i++) {
            wsData[i].active = false;
        }
    }
}
