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
            height: keyboard.height
            width: height
        }
    }

    FontLoader {
        source: "FontAwesome.otf"
    }

    Rectangle {
        id: keyboard
        anchors.bottom: parent.bottom
        color: "transparent"
        height: virtualKeyboard.width/virtualKeyboardModel.count
        width: parent.width

        Row {
            id: keyboardRow
            anchors.horizontalCenter: parent.horizontalCenter
            height: keyboard.height/4 - 10

            Repeater {
                model: virtualKeyboardModel
                delegate: virtualKeyboardDelegate
            }
        }
    }
}
