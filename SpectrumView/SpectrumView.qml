import QtQuick 2.5
import "Subelements"

Rectangle {
    id: spectrumView
    color: "#D9D9D9"
    state: "inactive"

    states: [
        State {
            name: "inactive";
            when: mainView.state === "showCoverView"

            PropertyChanges {
                target: spectrumView
                scale: 1.5
            }

            PropertyChanges {
                target: mouseArea
                enabled: true
            }

            PropertyChanges {
                target: spectrum
                visible: false
            }

            PropertyChanges {
                target: spectrumIcon
                visible: true
            }

            PropertyChanges {
                target: snrValue
                visible: false
            }
        },

        State {
            name: "active";
            when: mainView.state === "showSpectrumView"

            PropertyChanges {
                target: mouseArea
                enabled: false
            }

            PropertyChanges {
                target: spectrum
                visible: true
            }

            PropertyChanges {
                target: spectrumIcon
                visible: false
            }

            PropertyChanges {
                target: snrValue
                visible: true
            }
        }
    ]

    MouseArea {
        id: mouseArea
        anchors.fill: parent

        onClicked: {
            mainView.state = "showSpectrumView"
        }
    }

    Spectrum {
        id: spectrum
        height: width
        width: 0.7*Math.min(parent.width, parent.height);

        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }

    Image {
        id: spectrumIcon
        anchors.fill: parent
        source: "qrc:/images/spectrum.png"
    }

    Rectangle {
        id: snrContainter
        anchors.right: parent.right
        anchors.rightMargin: 100
        anchors.top: parent.top
        anchors.topMargin: 50
        border.color: "#FF6426"
        border.width: 2
        color: "transparent"
        height: 50
        width: 200

        Text {
            id: snrValue
            anchors.bottomMargin: 5
            anchors.fill: parent
            anchors.leftMargin: 10
            color: "#21201F"
            font.pixelSize: height/2
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            text: "SNR: 0 dB"
        }
    }
}
