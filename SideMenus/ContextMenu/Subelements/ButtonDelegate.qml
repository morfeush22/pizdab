import QtQuick 2.5

Rectangle {
    id: buttonDelegate

    property alias text: buttonText.text
    property alias textColor: buttonText.color
    signal clicked()

    color: buttonMouseArea.pressed ? "#FF6426" : "#21201F"
    height: 50
    width: 200

    Text {
        id: buttonText
        anchors.fill: parent
        color: "#D9D9D9"
        font.pixelSize: parent.height/2
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        text: "Submit"
    }

    MouseArea {
        id: buttonMouseArea
        anchors.fill: parent

        onClicked: {
            buttonDelegate.clicked();
        }
    }
}
