import QtQuick 2.5

Item {
    id: marqueeText
    property int position: 0
    property alias text: scrollingText.text
    property alias pixelSize: scrollingText.font.pixelSize
    clip: true

    Text {
        id: scrollingText
        height: parent.height
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        x: position
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onClicked: {
            position = 0;
            timer.running = true;
        }
    }

    Timer {
        id: timer
        interval: 200;
        repeat: true
        running: false;

        onTriggered:{
            position = position + 5
            scrollingText.x = -position;

            if(position + marqueeText.width > scrollingText.width) {
                timer.running = false
                scrollingText.x = 0
            }
        }
    }
}
