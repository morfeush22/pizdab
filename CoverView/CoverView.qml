import QtQuick 2.5
import "./Subelements"

Rectangle {
    id: cView
    color: "yellow"
    state: "active"

    //Behavior on scale { NumberAnimation{} }

    states: [
        State {
            name: "inactive";
            when: mainView.state == "showSpectrumView"

            PropertyChanges {
                target: cView
                color: "blue"
                scale: 1.5
            }

            PropertyChanges {
                target: mouseArea
                enabled: true
            }

            PropertyChanges {
                target: cover
                width: Math.min(parent.width, parent.height);
                height: width
            }

            PropertyChanges {
                target: tagBar
                visible: false
            }
        },

        State {
            name: "active";
            when: mainView.state == "showCoverView"

            PropertyChanges {
                target: mouseArea
                enabled: false
            }

            PropertyChanges {
                target: cover
                width: 0.7*Math.min(parent.width, parent.height);
                height: width
            }

            PropertyChanges {
                target: tagBar
                visible: true
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

    Cover {
        id: cover

        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }
    }

    TagBar {
        id: tagBar
        width: cover.width
        height: (mainView.height - cover.height)/2
        anchors.horizontalCenter: cover.horizontalCenter
        anchors.top: cover.bottom
        anchors.topMargin: 5
    }
}

