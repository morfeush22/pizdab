import QtQuick 2.5
import QtQuick.Controls 1.2
import "CoverView"
import "SpectrumView"
import "SideMenus/CommonMenu"
import "SideMenus/StationMenu"

Rectangle {
    id: mainWindow

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
            onClicked: mainWindow.state = (mainWindow.state == "contextMenuOpen" ? "sideMenusClosed" : "contextMenuOpen")
        }
    }

    Image {
        id: rightArrow
        source: "images/arrow.png"
        rotation: 270
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right

        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("clicked right");
                console.log(mainWindow.Stack.index);
            }
        }
    }

    ListView {
        id: contextMenu;
        x: -130;
        width: 125;
        height: parent.height
        model: commonMenuModel
        delegate: Item {
            height: 50
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

    states: [
        State {
            name: "sideMenusClosed"
            PropertyChanges { target: contextMenu; x: -130 }
            PropertyChanges { target: mainView; x: 0 }
            PropertyChanges { target: shade; opacity: 0 }
        },

        State {
            name: "contextMenuOpen"
            PropertyChanges { target: contextMenu; x: 0 }
            PropertyChanges { target: mainView; x: 125 }
            PropertyChanges { target: shade; opacity: 0.25 }
        }
    ]

    transitions: Transition {
        NumberAnimation { properties: "x,opacity"; duration: 100; easing.type: Easing.OutQuint }
    }
}
