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
    }

    WSServer {
        id: wsServer
    }

    FocusScope {
        id: mainView
        height: mainWindow.height
        width: mainWindow.width
        focus: true
        state: "showCoverView"

        CoverView {
            id: coverView
        }

        SpectrumView {
            id: spectrumView
        }

        Rectangle {
            anchors.fill: parent
            color: "black"
            id: shade 
            opacity: 0
        }

        states: [
            State {
                name: "showCoverView"

                PropertyChanges {
                    target: coverView
                    height: parent.height
                    width: parent.width;
                    z: 0
                }

                PropertyChanges {
                    target: spectrumView
                    height: 60
                    width: 60;
                    x: 30; y: 30; z: 1
                }
            },

            State {
                name: "showSpectrumView"

                PropertyChanges {
                    target: coverView
                    height: 60
                    width: 60;
                    x: 30; y: 30; z: 1
                }

                PropertyChanges {
                    target: spectrumView
                    height: parent.height
                    width: parent.width;
                    z: 0
                }
            }
        ]
    }

    Image {
        id: leftArrow
        anchors.left: contextMenu.right
        anchors.leftMargin: 10
        anchors.verticalCenter: contextMenu.verticalCenter
        rotation: 180
        source: "qrc:/images/navigation_previous_item.png"

        MouseArea {
            anchors.fill: parent
            onClicked: mainWindow.state = (mainWindow.state == "contextMenuOpened" ? "sideMenusClosed" : "contextMenuOpened")
        }
    }

    Image {
        id: rightArrow
        anchors.right: stationList.left
        anchors.rightMargin: 10
        anchors.verticalCenter: stationList.verticalCenter
        rotation: 0
        source: "qrc:/images/navigation_previous_item.png"

        MouseArea {
            anchors.fill: parent
            onClicked: mainWindow.state = (mainWindow.state == "stationListOpened" ? "sideMenusClosed" : "stationListOpened")
        }
    }

    ContextMenu {
        id: contextMenu;
        height: parent.height
        width: 250;
        x: -250;
    }

    StationList {
        id: stationList
        height: parent.height
        width: 250
        x: parent.width
    }

    states: [
        State {
            name: "sideMenusClosed"
            PropertyChanges { target: contextMenu; x: -250 }
            PropertyChanges { target: mainView; x: 0 }
            PropertyChanges { target: shade; opacity: 0 }
            PropertyChanges { target: stationList; x: parent.width }
        },

        State {
            name: "contextMenuOpened"
            PropertyChanges { target: contextMenu; x: 0 }
            PropertyChanges { target: leftArrow; rotation: 0 }
            PropertyChanges { target: mainView; x: 250 }
            PropertyChanges { target: shade; opacity: 0.35 }
            PropertyChanges { target: shade; z: 2 }
            PropertyChanges { target: stationList; x: parent.width + 250 }
        },

        State {
            name: "stationListOpened"
            PropertyChanges { target: contextMenu; x: -500 }
            PropertyChanges { target: mainView; x: -250 }
            PropertyChanges { target: rightArrow; rotation: 180 }
            PropertyChanges { target: shade; opacity: 0.35 }
            PropertyChanges { target: shade; z: 2 }
            PropertyChanges { target: stationList; x: parent.width - 250 }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x, opacity"; duration: 200; easing.type: Easing.OutQuint }
    }
}
