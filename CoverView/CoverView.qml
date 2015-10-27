import QtQuick 2.5
import "./Subelements"

Rectangle {
    id: coverView
    color: "#D9D9D9"
    state: "active"

    states: [
        State {
            name: "inactive";
            when: mainView.state === "showSpectrumView"

            PropertyChanges {
                target: coverView
                scale: 1.5
            }

            PropertyChanges {
                target: mouseArea
                enabled: true
            }

            PropertyChanges {
                target: cover
                height: width
                width: Math.min(parent.width, parent.height);   
            }

            PropertyChanges {
                target: tagBar
                visible: false
            }
        },

        State {
            name: "active";
            when: mainView.state === "showCoverView"

            PropertyChanges {
                target: mouseArea
                enabled: false
            }

            PropertyChanges {
                target: cover
                height: width
                width: 0.7*Math.min(parent.width, parent.height);  
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
        anchors.horizontalCenter: cover.horizontalCenter
        anchors.top: cover.bottom
        anchors.topMargin: 0
        height: (coverView.height - cover.height)/2
        text: "No RDS data"
        width: cover.width
    }
}
