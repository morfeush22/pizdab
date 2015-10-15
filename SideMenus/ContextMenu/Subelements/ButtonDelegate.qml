import QtQuick 2.5

Rectangle {
    property alias text: buttonText.text
    signal clicked()

    id: button
    width: 200
    height: 50
    color: buttonMouseArea.pressed ? "#FF6426" : "#21201F"

    Text {
        id: buttonText
        anchors.fill: parent
        text: "Submit"
        color: "#D9D9D9"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: parent.height/2
    }

    MouseArea {
        id: buttonMouseArea
        anchors.fill: parent
        onClicked: {
            button.clicked();
        }
    }
}
