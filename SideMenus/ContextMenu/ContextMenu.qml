import QtQuick 2.5
import "./Subelements"

Row {
    id: contextMenu;

    Rectangle {
        id: context
        width: contextMenu.width
        height: contextMenu.height
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
            width: parent.width
            height: parent.height
            model: contextMenuNavListModel
            delegate: contextMenuNavListDelegate
        }

        Rectangle {
            id: contextMenuExitApp
            width: parent.width
            height: 60
            y: contextMenuNavList.contentHeight
            color: "#4D4A48"

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 12
                color: mouseArea.containsMouse ? "#FF6426" : "#D9D9D9"
                text: "<b>Exit</b>"
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: Qt.quit()
            }

            Rectangle {
                width: parent.width
                anchors.top: contextMenuExitApp.bottom
                height: 2
                color: mouseArea.containsMouse ? "#FF6426" : "#403E3C"
            }
        }
    }

    Rectangle {
        width: 1
        height: contextMenu.height
        color: "#403E3C"
    }
}
