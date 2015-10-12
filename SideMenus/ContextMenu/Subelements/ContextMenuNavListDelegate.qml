import QtQuick 2.5
import QtQuick.Controls 1.2

Component {
    id: menuDelegate

    Column {
        id: listElement
        width: parent.width

        Rectangle {
            width: parent.width
            height: 60
            color: "#4D4A48"

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 12
                color: mouseArea.containsMouse ? "#FF6426" : "#D9D9D9"
                text: title
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
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
            color: mouseArea.containsMouse ? "#FF6426" : "#403E3C"
        }
    }
}
