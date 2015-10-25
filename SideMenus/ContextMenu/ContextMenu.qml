import QtQuick 2.5
import "./Subelements"

Row {
    id: contextMenu;

    Rectangle {
        id: context
        height: contextMenu.height
        width: contextMenu.width
        color: "#D9D9D9"

        ListModel {
            id: contextMenuNavListModel
            ListElement {
                title: "Capture List"
                url: "qrc:/SideMenus/ContextMenu/Subelements/CaptureList.qml"
            }
            ListElement {
                title: "Options"
                url: "qrc:/SideMenus/ContextMenu/Subelements/OptionsList.qml"
            }
            ListElement {
                title: "About"
                url: "qrc:/SideMenus/ContextMenu/Subelements/About.qml"
            }
        }

        ContextMenuNavListDelegate {
            id: contextMenuNavListDelegate
        }

        ListView {
            id: contextMenuNavList
            height: parent.height
            width: parent.width
            model: contextMenuNavListModel
            delegate: contextMenuNavListDelegate
        }

        Rectangle {
            id: contextMenuExitApp
            color: "#4D4A48"
            height: 60
            width: parent.width   
            y: contextMenuNavList.contentHeight     

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                color: mouseArea.containsMouse ? "#FF6426" : "#D9D9D9"
                font.pointSize: 12
                text: "Exit"
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: {
                    wsServer.closeConnections();
                    Qt.quit()
                }
            }

            Rectangle {
                anchors.top: contextMenuExitApp.bottom
                color: mouseArea.containsMouse ? "#FF6426" : "#403E3C"
                height: 2
                width: parent.width
            }
        }
    }

    Rectangle {
        height: contextMenu.height
        width: 1
        color: "#403E3C"
    }
}
