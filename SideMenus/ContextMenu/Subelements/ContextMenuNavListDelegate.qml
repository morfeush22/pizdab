import QtQuick 2.5
import QtQuick.Controls 1.2

Column {
    id: contextMenuNavListDelegate

    property alias text: label.text
    signal clicked()

    width: parent.width

    Rectangle {
        color: "#4D4A48"
        height: 60
        width: parent.width

        Text {
            id: label
            anchors.left: parent.left
            anchors.leftMargin: 10
            anchors.verticalCenter: parent.verticalCenter
            color: mouseArea.containsMouse ? "#FF6426" : "#D9D9D9"
            font.pointSize: 12
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: {
                contextMenuNavListDelegate.clicked();
            }
        }
    }

    Rectangle {
        height: 2
        width: parent.width
        color: mouseArea.containsMouse ? "#FF6426" : "#403E3C"
    }
}
