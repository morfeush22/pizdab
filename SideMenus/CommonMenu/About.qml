import QtQuick 2.5

Rectangle {
    id: about
    property string title
    property bool backButtonBarVisible: true
    width: 100
    height: 62

    Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        text: "PizDab+"
    }
}

