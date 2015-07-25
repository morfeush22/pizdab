import QtQuick 2.0

Rectangle {
    id: cView

    color: "white"

    state: "inactive"

    states: [
        State {
            name: "active"; when: mainView.state == "showSpectrumView"
            PropertyChanges {
                target: cView
                color: "blue"
                scale: 1.5
            }

            PropertyChanges {
                target: mouseArea
                enabled: true
            }
        },

        State {
            name: "inactive"; when: mainView.state == "showCoverView"
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
            mainView.state = "showCoverView"
        }
    }
}

