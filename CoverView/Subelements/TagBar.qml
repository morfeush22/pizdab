import QtQuick 2.5
import "../../CommonElements"

    Text {
        id: textArea

        text: "Hello World! Hello World! Hello World! Hello World! Hello World!\n DDDddd AAAaaa CCCccc EEEeee "

        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter

        fontSizeMode: Text.HorizontalFit
        minimumPixelSize: 29

        font.pixelSize: 72
        elide: Text.ElideRight 

        ToolTip {
            id: toolTip
            text: textArea.text
            width: 250
            target: textArea
            tipEnabled: cView.state == "inactive" ? true : false
        }
    }

