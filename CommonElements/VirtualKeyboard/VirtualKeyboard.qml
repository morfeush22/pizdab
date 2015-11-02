import QtQuick 2.5
import QtQuick.Window 2.0

Item {
    id: virtualKeyboard
    height: 600
    width: parent.width
    y: parent.height

    VirtualKeyboardModel {
        id: virtualKeyboardModel
    }

    Component {
        id: virtualKeyboardDelegate

        VirtualKeyboardDelegate {
            height: 70
            width: 70
        }
    }

    FontLoader {
        source: "FontAwesome.otf"
    }

    Rectangle {
        id: keyboard
        anchors.bottom: parent.bottom
        color: "transparent"
        height: 80
        width: parent.width

        MouseArea {
            anchors.fill: parent
        }

        Column {
            id: keyboardColumn
            anchors.fill: parent
            anchors.margins: 5
            spacing: 5

            Row {
                id: keyboardRow
                anchors.horizontalCenter: parent.horizontalCenter
                height: keyboard.height/4 - 10
                spacing: 5  

                Repeater {
                    model: virtualKeyboardModel
                    delegate: virtualKeyboardDelegate
                }
            }
        }
    }
}
