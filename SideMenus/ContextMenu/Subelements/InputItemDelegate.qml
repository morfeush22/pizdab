import QtQuick 2.5

Row {
    property alias descriptionText: description.text
    property alias hasFocus: input.activeFocus
    property alias inputText: input.text

    spacing: 10

    Rectangle {
        id: border
        border.color: "#FF6426"
        border.width: 2
        color: "transparent"
        height: 50
        width: 400

        TextInput {
            id: input
            anchors.bottomMargin: 5
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "#21201F"
            font.pixelSize: height/2
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            validator: IntValidator { bottom: 1 }
        }
    }

    Text {
        id: description
        anchors.leftMargin: 10
        anchors.verticalCenter: border.verticalCenter
        font.pixelSize:  input.font.pixelSize
    }
}
