import QtQuick 2.5
import "../../CommonElements"

Rectangle {
    id: tagBar

    property string text

    color: "transparent"

    onTextChanged: {
        if (text.length > 25) {
            commonText.visible = false;
            marqueeText.visible = true;
        }
        else {
            commonText.visible = true;
            marqueeText.visible = false;
        }
    }

    Text {
        id: commonText
        text: parent.text
        width: parent.width
        height: parent.height
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 46
        visible: false
    }

    MarqueeText {
        id: marqueeText
        text: parent.text
        width: parent.width
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        pixelSize: 46
        visible: false
    }
}
