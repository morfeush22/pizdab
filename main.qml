import QtQuick 2.5
import QtQuick.Controls 1.2

ApplicationWindow {
    id: root
    width: 800
    height: 480
    visible: true

    toolBar: Column {
        visible: stackView.depth > 1 && stackView.currentItem.backButtonBarVisible

        Rectangle {
            width: root.width
            height: 100
            color: "#21201F"

            Rectangle {
                id: backButton
                width: 80
                height: 80
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.verticalCenter: parent.verticalCenter
                color: "transparent"

                Image {
                    anchors.verticalCenter: parent.verticalCenter
                    source: "qrc:/images/navigation_previous_item.png"
                }

                MouseArea {
                    anchors.fill: parent
                    onClicked: stackView.pop()
                }

                Text {
                    font.pixelSize: 42
                    x: backButton.x + backButton.width + 20
                    anchors.verticalCenter: parent.verticalCenter
                    color: "#D9D9D9"
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
            width: root.width
            height: 5
            color: "#FF6426"
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
