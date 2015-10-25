import QtQuick 2.5
import QtQuick.Controls 1.2

ApplicationWindow {
    id: root
    height: 480
    width: 800
    visible: true

    toolBar: Column {
        visible: stackView.depth > 1 && stackView.currentItem.backButtonBarVisible

        Rectangle {
            color: "#21201F"
            height: 100
            width: root.width

            Rectangle {
                id: backButton
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                color: "transparent"
                height: 80
                width: 80

                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/images/navigation_previous_item.png"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: stackView.pop()
                }

                Text {
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#D9D9D9"
                    font.pixelSize: 42
                    x: backButton.x + backButton.width + 20

                    text: {
                        if (stackView.currentItem && stackView.currentItem.title)
                            stackView.currentItem.title
                        else
                            ""
                    }
                }
            }
        }

        Rectangle {
            color: "#FF6426"
            height: 5
            width: root.width
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
                    from: 0
                    to: 1
                    property: "opacity"
                }

                PropertyAnimation {
                    target: exitItem
                    from: 1
                    to: 0
                    property: "opacity"
                }
            }
        }
    }
}
