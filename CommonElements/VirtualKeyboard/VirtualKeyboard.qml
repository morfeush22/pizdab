import QtQuick 2.5
import QtQuick.Window 2.0

Item {
    id: virtualKeyboard
    height: 600
    width: parent.width
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
        anchors.bottom: parent.bottom
        id: keyboard
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
