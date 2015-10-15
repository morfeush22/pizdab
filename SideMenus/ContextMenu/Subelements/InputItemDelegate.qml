import QtQuick 2.5

Row {
    spacing: 10
    property alias inputText: input.text
    property alias descriptionText: description.text
    property alias hasFocus: input.activeFocus

    Rectangle {
        id: border
        color: "transparent"
        border.width: 2
        border.color: "#FF6426"
        width: 400
        height: 50

        TextInput {
            anchors.fill: parent
            anchors.bottomMargin: 5
            anchors.leftMargin: 10
            color: "#21201F"

            id: input

            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            font.pixelSize: height/2
            validator: IntValidator { bottom: 1 }
        }
    }

    Text {
        id: description
        anchors.leftMargin: 10
        font.pixelSize:  input.font.pixelSize
        anchors.verticalCenter: border.verticalCenter
    }
}
