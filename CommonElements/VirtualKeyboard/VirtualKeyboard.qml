import QtQuick 2.5
import QtQuick.Window 2.0

Item {
    id: virtualKeyboard
    width: parent.width
    height: 600
    y: parent.height

    Item {
        ListModel {
            id: virtualKeyboardModel
            ListElement { letter: "\uf078"; key: Qt.Key_Escape }
            ListElement { letter: "1"; key: Qt.Key_1 }
            ListElement { letter: "2"; key: Qt.Key_2 }
            ListElement { letter: "3"; key: Qt.Key_3 }
            ListElement { letter: "4"; key: Qt.Key_4 }
            ListElement { letter: "5"; key: Qt.Key_5 }
            ListElement { letter: "6"; key: Qt.Key_6 }
            ListElement { letter: "7"; key: Qt.Key_7 }
            ListElement { letter: "8"; key: Qt.Key_8 }
            ListElement { letter: "9"; key: Qt.Key_9 }
            ListElement { letter: "0"; key: Qt.Key_0 }
            ListElement { letter: "\uf060"; key: Qt.Key_Backspace }
        }
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
        color: "transparent"
        width: parent.width
        height: 80
        anchors.bottom: parent.bottom

        MouseArea {
            anchors.fill: parent
        }

        Column {
            id: keyboardColumn
            anchors.margins: 5
            anchors.fill: parent
            spacing: 5

            Row {
                id: keyboardRow
                height: keyboard.height/4 - 10
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter

                Repeater {
                    model: virtualKeyboardModel
                    delegate: virtualKeyboardDelegate
                }
            }
        }
    }
}
