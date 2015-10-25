import QtQuick 2.5

Rectangle {
    id: spectrumView
    color: "black"
    state: "inactive"

    states: [
        State {
            name: "inactive";
            when: mainView.state === "showCoverView"

            PropertyChanges {
                target: spectrumView
                color: "red"
                scale: 1.5
            }

            PropertyChanges {
                target: mouseArea
                enabled: true
            }
        },

        State {
            name: "active";
            when: mainView.state === "showSpectrumView"

            PropertyChanges {
                target: mouseArea
                enabled: false
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
}
