import QtQuick 2.5
import QtQuick.Controls 1.2
import QtWebSockets 1.0
import "CoverView"
import "SpectrumView"
import "SideMenus/ContextMenu"
import "SideMenus/StationMenu"

Rectangle {
    id: mainWindow
    property bool backButtonBarVisible: false

    Component.onCompleted: {
        threadController.startScheduler(schedulerConfig);
        //todo move to CaptureList
        //console.log(threadController.getDevices());
    }

    //temporary
    Timer {
        interval: 500; running: true; repeat: true
        onTriggered: {
            //\u2713 - check mark
            //console.log(hostInfo.addresses());
            //console.log(threadController.getDevices());
        }
    }

    WSServer {
    }

    /*
    WebSocketServer {
        id: server
        port: 8080
        listen: true
        onClientConnected: {
            webSocket.onTextMessageReceived.connect(function(message) {
                //webSocket.sendTextMessage("Hello client from server!");
                var newModel = [
                            {"station_title": "1", "kbps": "1", "station_id": "1", "sub_channel_id": "1"},
                            {"station_title": "2", "kbps": "2", "station_id": "2", "sub_channel_id": "2"},
                            {"station_title": "3", "kbps": "3", "station_id": "3", "sub_channel_id": "3"},
                            {"station_title": "4", "kbps": "4", "station_id": "4", "sub_channel_id": "4"},
                            {"station_title": "5", "kbps": "5", "station_id": "5", "sub_channel_id": "5"}
                        ];
                var parsed = JSON.parse(message);
                var msg = {};
                msg.$id = parsed.$id;
                msg.$type = parsed.$type;
                msg.$data = newModel;
                webSocket.sendTextMessage(JSON.stringify(msg));
            });
            console.log("ACK");
        }
        onErrorStringChanged: {
            console.log("NACK");
        }
    }
    */

    FocusScope {
        id: mainView
        width: mainWindow.width
        height: mainWindow.height
        focus: true
        state: "showCoverView"

        CoverView {
            id: coverView
        }

        SpectrumView {
            id: spectrumView
        }

        Rectangle {
            id: shade
            anchors.fill: parent
            color: "black"
            opacity: 0
        }

        states: [
            State {
                name: "showCoverView"

                PropertyChanges {
                    target: coverView
                    width: parent.width; height: parent.height
                    z: 0
                }

                PropertyChanges {
                    target: spectrumView
                    width: 60; height: 60
                    x: 30; y: 30; z: 1
                }
            },

            State {
                name: "showSpectrumView"

                PropertyChanges {
                    target: coverView
                    width: 60; height: 60
                    x: 30; y: 30; z: 1
                }

                PropertyChanges {
                    target: spectrumView
                    width: parent.width; height: parent.height
                    z: 0
                }
            }
        ]
    }

    Image {
        id: leftArrow
        source: "qrc:/images/navigation_previous_item.png"
        rotation: 180
        anchors.verticalCenter: contextMenu.verticalCenter
        anchors.left: contextMenu.right
        anchors.leftMargin: 10

        MouseArea {
            anchors.fill: parent
            onClicked: mainWindow.state = (mainWindow.state == "contextMenuOpened" ? "sideMenusClosed" : "contextMenuOpened")
        }
    }

    Image {
        id: rightArrow
        source: "qrc:/images/navigation_previous_item.png"
        rotation: 0
        anchors.verticalCenter: stationList.verticalCenter
        anchors.right: stationList.left

        MouseArea {
            anchors.fill: parent
            onClicked: mainWindow.state = (mainWindow.state == "stationListOpened" ? "sideMenusClosed" : "stationListOpened")
        }
    }

    ContextMenu {
        id: contextMenu;
        x: -250;
        width: 250;
        height: parent.height
    }

    StationList {
        id: stationList
        x: parent.width
        width: 250
        height: parent.height
    }

    states: [
        State {
            name: "sideMenusClosed"
            PropertyChanges { target: contextMenu; x: -250 }
            PropertyChanges { target: stationList; x: parent.width }
            PropertyChanges { target: mainView; x: 0 }
            PropertyChanges { target: shade; opacity: 0 }
        },

        State {
            name: "contextMenuOpened"
            PropertyChanges { target: contextMenu; x: 0 }
            PropertyChanges { target: stationList; x: parent.width + 250 }
            PropertyChanges { target: mainView; x: 250 }
            PropertyChanges { target: shade; opacity: 0.35 }
            PropertyChanges { target: leftArrow; rotation: 0 }
            PropertyChanges { target: shade; z: 2 }
        },

        State {
            name: "stationListOpened"
            PropertyChanges { target: contextMenu; x: -500 }
            PropertyChanges { target: stationList; x: parent.width - 250 }
            PropertyChanges { target: mainView; x: -250 }
            PropertyChanges { target: shade; opacity: 0.35 }
            PropertyChanges { target: rightArrow; rotation: 180 }
            PropertyChanges { target: shade; z: 2 }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x, opacity"; duration: 200; easing.type: Easing.OutQuint }
    }
}
