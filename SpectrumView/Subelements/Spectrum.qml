import QtQuick 2.5

Rectangle {
    id: spectrum
    property int barSpacing: 1
    property int scaleFactor: -3
    color: "transparent"

    Row {
        id: container
        anchors.fill: parent
        spacing: barSpacing
        Repeater {
            model: threadController.spectrumData.yValues
            Rectangle {
                anchors.bottom: container.bottom
                height: scaleFactor*modelData
                width: spectrum.width/threadController.spectrumData.yValues.length - barSpacing
                color: "#FF6426"
            }
        }
    }
}
