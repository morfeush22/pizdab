import QtQuick 2.5
import QtQuick.Controls 1.2

Component {
    id: menuDelegate

    Column {
        id: listElement
        width: parent.width

        Rectangle {
            width: parent.width
            height: 50
            color: "#0A073E"

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 12
                color: "#FFFFFF"
                text: "<b>" + title + "</b>"
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

        Rectangle {
            width: parent.width
            height: 2
            color: "#403F69"
        }
    }
}
