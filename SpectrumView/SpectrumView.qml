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
                target: snrContainer
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
                target: snrContainer
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
        height: 0.7 * parent.height
        width: 0.7 * parent.width

        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }

    Rectangle {
        id: spectrumIcon
        color: mouseArea.pressed ? "#FF6426" : "#21201F"
        anchors.fill: parent

        Text {
            id: character
            anchors.margins: 2
            anchors.fill: parent
            color: "#D9D9D9"
            fontSizeMode: Text.Fit
            font.pixelSize: height
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: "\u007e"
        }
    }

    SNRContainer {
        id: snrContainer
        anchors.right: parent.right
        anchors.rightMargin: 100
        anchors.top: parent.top
        anchors.topMargin: 50
        height: 50
        width: 200
    }
}
