import QtQuick 2.5

Rectangle {
    id: snrContainter
    border.color: "#FF6426"
    border.width: 2
    color: "transparent"

    Text {
        id: snrValue
        anchors.bottomMargin: 5
        anchors.fill: parent
        anchors.leftMargin: 10
        color: "#21201F"
        elide: Text.ElideRight
        font.pixelSize: height/2
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
        text: "SNR: " + threadController.snr.toFixed(2) + "dB"
    }
}
