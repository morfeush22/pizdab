import QtQuick 2.5

Rectangle {
    id: sView
    color: "black"
    state: "inactive"

    Behavior on scale { NumberAnimation{} }

    states: [
        State {
            name: "inactive";
            when: mainView.state == "showCoverView"

            PropertyChanges {
                target: sView
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
            when: mainView.state == "showSpectrumView"

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

