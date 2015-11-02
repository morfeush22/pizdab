import QtQuick 2.5
import QtQuick.Controls 1.2
import "./Subelements"

Row {
    id: contextMenu;

    Rectangle {
        id: context
        height: contextMenu.height
        width: contextMenu.width
        color: "#D9D9D9"

        ContextMenuNavListModel {
            id: contextMenuNavListModel
        }

        Component {
            id: contextMenuNavListDelegate

            ContextMenuNavListDelegate {
                text: title

                onClicked: {
                    mainWindow.Stack.view.push(
                               {item: Qt.resolvedUrl(url), properties: {title: title}});
                    mainWindow.state = "sideMenusClosed"
                }
            }
        }

        ListView {
            id: contextMenuNavList
            height: parent.height
            width: parent.width
            model: contextMenuNavListModel
            delegate: contextMenuNavListDelegate
        }

        ContextMenuNavListDelegate {
            id: contextMenuExitApp
            text: "Exit"
            y: contextMenuNavList.contentHeight

            onClicked: {
                wsServer.closeConnections();
                Qt.quit()
            }
        }
    }

    Rectangle {
        height: contextMenu.height
        width: 1
        color: "#403E3C"
    }
}
