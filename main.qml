import QtQuick 2.2
import QtQuick.Controls 1.2

ApplicationWindow {
    id: root
    visible: true
    width: 800
    height: 480

    toolBar: Rectangle {
        color: "#212126"
        width: parent.width
        height: 100
        visible: stackView.depth > 1 && stackView.currentItem.backButtonBarVisible

        Rectangle {
            id: backButtonBar
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
                x: backButtonBar.x + backButtonBar.width + 20
                anchors.verticalCenter: parent.verticalCenter
                color: "white"
                text: {
                    if (stackView.currentItem && stackView.currentItem.title)
                        stackView.currentItem.title
                    else
                        ""
                }
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
