import QtQuick 2.5
import "Subelements"

Rectangle {
    id: contextMenu;
    x: -130;
    width: 125;
    height: parent.height

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
        width: parent.width
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
