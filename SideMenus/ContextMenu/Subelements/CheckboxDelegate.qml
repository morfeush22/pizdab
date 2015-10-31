import QtQuick 2.5
import QtQuick.Controls 1.2

Row {
    signal clicked()

    id: checkboxDelegate
    spacing: 30

    Rectangle {
        id: checkbox
        height: 50
        width: 50
        color: buttonMouseArea.pressed ? "#FF6426" : "#21201F"

        MouseArea {
            id: buttonMouseArea
            anchors.fill: parent
            onClicked: checkboxDelegate.clicked();
        }
    }

    Text {
        id: description
        anchors.verticalCenter: checkbox.verticalCenter
        font.pixelSize: parent.height/2
        text: name
    }
}
