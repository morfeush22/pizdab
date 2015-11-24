import QtQuick 2.5

Item {
    id: virtualKeyboardDelegate

    Rectangle {
        anchors.fill: parent
        color: buttonMouseArea.pressed ? "#FF6426" : "#21201F"

        FontLoader {
            id: fixedFont
            source: "FontAwesome.otf"
        }

        Text {
            id: buttonText
            anchors.margins: 2
            anchors.fill: parent
            color: "#D9D9D9"
            fontSizeMode: Text.Fit
            font.family: fixedFont.name
            font.pixelSize: 500
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: letter 
        }

        MouseArea {
            id: buttonMouseArea
            anchors.fill: parent
            onClicked: keyEventDispatcher.emitKey(key)
        }
    }
}
