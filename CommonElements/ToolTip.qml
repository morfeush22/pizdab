import QtQuick 2.5

Item {
    id: toolTipRoot
    height: content.contentHeight
    visible: false
    clip: false

    property alias text: toolTip.text
    property var target: null
    property bool tipEnabled: true

    function onMouseHover(x, y) {
        var obj = toolTipRoot.target.mapToItem(toolTipRoot.parent, x, y);
        toolTipRoot.x = obj.x + 15;
        toolTipRoot.y = obj.y + 15;
    }

    function onVisibleStatus(flag) {
        toolTipRoot.visible = toolTipRoot.tipEnabled ? flag : false;
    }

    Component.onCompleted: {
        var itemParent = toolTipRoot.target;

        var newObject = Qt.createQmlObject('import QtQuick 2.5; MouseArea {hoverEnabled: true; signal mouserHover(int x, int y); signal showChanged(bool flag); anchors.fill:parent; onPositionChanged: {mouserHover(mouseX, mouseY)} onEntered: {showChanged(true)} onExited:{showChanged(false)}}',
            itemParent);
        newObject.mouserHover.connect(onMouseHover);
        newObject.showChanged.connect(onVisibleStatus);
    }


    Rectangle {
        id: content
        anchors.centerIn: parent
        width: toolTipRoot.width
        height: toolTip.contentHeight + 2
        color: "black"
        radius: 2

        Text {
            id: toolTip
            anchors {
                fill: parent
                margins: 2
            }
            color: "white"

            wrapMode: Text.WordWrap
        }
    }
}
