import QtQuick 2.2
import QtQuick.Controls 1.2
import SDRDAB 1.0

ApplicationWindow {
    id: root
    visible: true
    width: 800
    height: 480

    toolBar: Rectangle {
        color: "#212126"
        width: parent.width
        height: 100
        visible: stackView.depth > 1 ? 1 : 0

        Rectangle {
            id: backButton
            width: 80
            height: 80
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            radius: 4
            color: backmouse.pressed ? "#222" : "transparent"

            Image {
                anchors.verticalCenter: parent.verticalCenter
                source: "images/navigation_previous_item.png"
            }

            MouseArea {
                id: backmouse
                anchors.fill: parent
                onClicked: stackView.pop()
            }

            Text {
                font.pixelSize: 42
                x: backButton.x + backButton.width + 20
                anchors.verticalCenter: parent.verticalCenter
                color: "white"
                text: stackView.currentItem.title ? stackView.currentItem.title : ""
            }
        }
    }

    StackView {
        id: stackView
        anchors.fill: parent
        focus: true
        initialItem: PizDab {}
        delegate: StackViewDelegate {
            function transitionFinished(properties) {
                properties.exitItem.opacity = 1
            }

            pushTransition: StackViewTransition {

                PropertyAnimation {
                    target: enterItem
                    property: "opacity"
                    from: 0
                    to: 1
                }

                PropertyAnimation {
                    target: exitItem
                    property: "opacity"
                    from: 1
                    to: 0
                }
            }
        }
    }
}

/*
Loader {//Just loader, since there's only one.
    source: "./pizdab.qml"
    focus: true
    // Exception to the standard sizing, because this is primarily a desktop
    // example and it benefits from being able to see everything at once.
    Timer {
        interval: 500
        running: true
        repeat: true
        onTriggered: {
            console.log("triggered");
            console.log(threadController.stationList.length ? threadController.stationList[0].stationName : "no name");
        }
    }
    onLoaded: load()
    QSchedulerConfig {
        id: mainConfig
    }
    function load() {
        console.log('starting');
        //threadController.startScheduler(mainConfig);
    }
}
*/
