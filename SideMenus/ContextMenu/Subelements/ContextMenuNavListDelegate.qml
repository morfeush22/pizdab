import QtQuick 2.5
import QtQuick.Controls 1.2

Component {
    id: menuDelegate

    Column {
        id: listElement
        width: parent.width

        Rectangle {
            color: "#4D4A48"
            height: 60
            width: parent.width

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                color: mouseArea.containsMouse ? "#FF6426" : "#D9D9D9"
                font.pointSize: 12
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
            height: 2
            width: parent.width  
            color: mouseArea.containsMouse ? "#FF6426" : "#403E3C"
        }
    }
}
