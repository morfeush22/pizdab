import QtQuick 2.5

Rectangle {
    id: spectrum

    property int barSpacing: 0
    property int offset: 600
    property real scaleFactor: 3

    color: "transparent"

    Row {
        id: container
        anchors.fill: parent
        spacing: barSpacing
        Repeater {
            model: threadController.spectrumData.yValues
            Rectangle {
                anchors.bottom: container.bottom
                height: offset + scaleFactor*modelData
                width: spectrum.width/threadController.spectrumData.yValues.length
                color: "#FF6426"
            }
        }
    }
}
