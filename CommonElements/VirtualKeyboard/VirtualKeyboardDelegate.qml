import QtQuick 2.5

Item {
    id: keyboardDelegate

    Rectangle {
        anchors.fill: parent
        color: buttonMouseArea.pressed ? "#FF6426" : "#21201F"

        Text {
            id: buttonText
            anchors.margins: 2
            anchors.fill: parent
            fontSizeMode: Text.Fit
            font.pixelSize: 500
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: letter
            color: "#D9D9D9"
        }

        MouseArea {
            id: buttonMouseArea
            anchors.fill: parent
            onClicked: keyEventDispatcher.emitKey(key)
        }
    }
}
