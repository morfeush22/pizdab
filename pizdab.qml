import QtQuick 2.5
import QtQuick.Window 2.2
import "CoverView"
import "SpectrumView"
import "SideMenus/CommonMenu"
import "SideMenus/StationMenu"

Window {
    id: root
    visible: true

    width: 800; height: 640
    color: "#3E606F"

    Rectangle {
        anchors.fill: parent

        id: mainWindow


        FocusScope {
            id: mainView

            width: root.width; height: root.height
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
                    PropertyChanges {
                        target: spectrumView
                        width: 30; height: 30
                        x: 20; y: 20; z: 1
                    }

                    name: "showCoverView"
                    PropertyChanges {
                        target: coverView
                        width: parent.width; height: parent.height
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
                    }
                }
            ]
        }

        Image {
            id: leftArrow
            source: "SideMenus/images/arrow.png"
            rotation: 90
            anchors.verticalCenter: contextMenu.verticalCenter
            anchors.left: contextMenu.right
            anchors.leftMargin: 10

            MouseArea {
                anchors.fill: parent
                onClicked: mainWindow.state = "contextMenuOpen"
            }
        }

        Image {
            id: rightArrow
            source: "SideMenus/images/arrow.png"
            rotation: 270
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right

            MouseArea {
                anchors.fill: parent
                onClicked: console.log("clicked right")
            }
        }

        MenuList {
            id: contextMenu;
            x: -130;
            width: 125; height: parent.height
        }

        states: State {
            name: "contextMenuOpen"
            PropertyChanges { target: contextMenu; x: 0; open: true }
            PropertyChanges { target: mainView; x: 125 }
            PropertyChanges { target: shade; opacity: 0.25 }
        }
    }
}
