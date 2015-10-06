import QtQuick 2.5
import QtQuick.Controls 1.2
import SDRDAB 1.0
import "CoverView"
import "SpectrumView"
import "SideMenus/CommonMenu"
import "SideMenus/StationMenu"

Rectangle {
    id: mainWindow

    // ========temporary========
    QSchedulerConfig {
        id: mainConfig
    }

    Component.onCompleted: {
        threadController.startScheduler(mainConfig);
    }
    // =========================

    ListModel {
        id: commonMenuModel
        ListElement {
            title: "About"
            url: "qrc:/SideMenus/CommonMenu/About.qml"
        }
        ListElement {
            title: "Capture List"
            url: "qrc:/SideMenus/CommonMenu/CaptureList.qml"
        }
        ListElement {
            title: "Options"
            url: "qrc:/SideMenus/CommonMenu/OptionsList.qml"
        }
    }

    ListModel {
        id: stationListModel
        dynamicRoles: true
    }

    FocusScope {
        id: mainView
        width: root.width
        height: root.height
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
                    width: 30; height: 30
                    x: 20; y: 20; z: 1
                }
            },

            State {
                name: "showSpectrumView"

                PropertyChanges {
                    target: coverView
                    width: 30; height: 30
                    x: 20; y: 20; z: 1
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
        source: "images/arrow.png"
        rotation: 90
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
        source: "images/arrow.png"
        rotation: 270
        anchors.verticalCenter: stationList.verticalCenter
        anchors.right: stationList.left

        MouseArea {
            anchors.fill: parent
            onClicked: mainWindow.state = (mainWindow.state == "stationListOpened" ? "sideMenusClosed" : "stationListOpened")
        }
    }

    ListView {
        id: contextMenu;
        x: -130;
        width: 125;
        height: parent.height
        model: commonMenuModel
        delegate: Item {
            height: 20
            width: parent.width

            Rectangle {
                Text { text: title }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    mainWindow.Stack.view.push(
                               {item: Qt.resolvedUrl(url), properties: {title: title}});
                    mainWindow.state = "sideMenusClosed"
                }
            }
        }
    }

    ListView {
        id: stationList
        x: parent.width
        width: 125
        height: parent.height
        model: stationListModel
        delegate: Item {
            height: 20
            width: parent.width

            Rectangle {
                Text { text:
                        if (station_id == threadController.userFICExtraData.currentStationId)
                            station_title ? station_title + " (current)" : ""
                        else
                            station_title ? station_title : ""
                }
            }

            MouseArea {
                anchors.fill: parent
                onClicked: {
                    mainWindow.state = "sideMenusClosed"
                    threadController.changeStation(sub_channel_id);
                }
            }
        }

        Connections {
            target: mainWindow.state == "stationListOpened" ? null : threadController
            onStationListChanged: {
                var newModel = [];
                for (var i = 0; i < threadController.stationList.length; i++) {
                    newModel.push(
                                {"station_title": threadController.stationList[i].stationName,
                                "kbps": threadController.stationList[i].audioKbps,
                                "station_id": threadController.stationList[i].stationId,
                                "sub_channel_id": threadController.stationList[i].subChannelId})
                }
                stationListModel.clear()
                stationListModel.append(newModel);
            }
        }
    }

    states: [
        State {
            name: "sideMenusClosed"
            PropertyChanges { target: contextMenu; x: -130 }
            PropertyChanges { target: stationList; x: parent.width }
            PropertyChanges { target: mainView; x: 0 }
            PropertyChanges { target: shade; opacity: 0 }
        },

        State {
            name: "contextMenuOpened"
            PropertyChanges { target: contextMenu; x: 0 }
            PropertyChanges { target: stationList; x: parent.width + 125 }
            PropertyChanges { target: mainView; x: 125 }
            PropertyChanges { target: shade; opacity: 0.25 }
        },

        State {
            name: "stationListOpened"
            PropertyChanges { target: contextMenu; x: -255 }
            PropertyChanges { target: stationList; x: parent.width - 130 }
            PropertyChanges { target: mainView; x: -125 }
            PropertyChanges { target: shade; opacity: 0.25 }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x,opacity"; duration: 200; easing.type: Easing.OutQuint }
    }
}
