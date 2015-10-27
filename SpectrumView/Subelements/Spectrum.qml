import QtQuick 2.5

Rectangle {
    id: spectrum
    property int barSpacing: 1
    property int scaleFactor: 300
    color: "transparent"

    Row {
        anchors.fill: parent
        spacing: barSpacing
        Repeater {
            model: threadController.spectrumData.yValues
            Rectangle {
                anchors.bottom: parent.bottom
                height: scaleFactor*modelData
                width: spectrum.width/threadController.spectrumData.yValues.length - 2*barSpacing
                color: "#FF6426"
            }
        }
    }
}
