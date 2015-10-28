import QtQuick 2.5

Component {
    Row {
        spacing: 30

        Rectangle {
            id: checkbox
            height: 50
            width: 50
            color: buttonMouseArea.pressed ? "#FF6426" : "#21201F"

            Text {
                id: character
                anchors.fill: parent
                color: "#D9D9D9"
                font.pixelSize: height/2
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "\u2713"
            }

            MouseArea {
                id: buttonMouseArea
                anchors.fill: parent
                onClicked: console.log("clicked")
            }
        }

        Text {
            id: description
            anchors.verticalCenter: checkbox.verticalCenter
            font.pixelSize:  character.font.pixelSize
            text: tab[index]
        }
    }
}
