import QtQuick 2.5
import QtQuick.Controls 1.2

Component {
    id: menuDelegate

    Rectangle {
        width: parent.width
        height: 20

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
