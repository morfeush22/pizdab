import QtQuick 2.5
import "Subelements"

Row {
    id: contextMenu;

    Rectangle {
        id: context
        width: contextMenu.width
        height: contextMenu.height

        ListModel {
            id: contextMenuNavListModel
            ListElement {
                title: "About"
                url: "qrc:/SideMenus/ContextMenu/Subelements/About.qml"
            }
            ListElement {
                title: "Capture List"
                url: "qrc:/SideMenus/ContextMenu/Subelements/CaptureList.qml"
            }
            ListElement {
                title: "Options"
                url: "qrc:/SideMenus/ContextMenu/Subelements/OptionsList.qml"
            }
        }

        ContextMenuNavListDelegate {
            id: contextMenuNavListDelegate
        }

        ListView {
            id: contextMenuNavList
            width: parent.width
            height: parent.height - contextMenuExitApp.height
            model: contextMenuNavListModel
            delegate: contextMenuNavListDelegate
        }

        Item {
            id: contextMenuExitApp
            width: contextMenu.width
            height: 20
            anchors.top: contextMenuNavList.bottom

            Text {
                text: "Exit"
            }

            MouseArea {
                anchors.fill: parent
                onClicked: Qt.quit()
            }
        }
    }

    Rectangle {
        width: 2
        height: contextMenu.height
        color: "#403F69"
    }
}
