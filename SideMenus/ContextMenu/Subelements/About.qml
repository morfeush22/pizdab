import QtQuick 2.5

Rectangle {
    id: about
    property string title
    property bool backButtonBarVisible: true

    Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        text: "PizDab+"
    }
}
