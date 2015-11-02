import QtQuick 2.5

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
