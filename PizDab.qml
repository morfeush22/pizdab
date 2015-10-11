import QtQuick 2.5
import QtQuick.Controls 1.2
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

    ContextMenu {
        id: contextMenu;
    }

    StationList {
        id: stationList
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
        NumberAnimation { properties: "x, opacity"; duration: 200; easing.type: Easing.OutQuint }
    }
}
