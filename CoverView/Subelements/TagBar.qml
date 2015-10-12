import QtQuick 2.5
import "../../CommonElements"

    Text {
        id: textArea

        text: "No RDS data"

        wrapMode: Text.WordWrap
        horizontalAlignment: Text.AlignHCenter

        fontSizeMode: Text.HorizontalFit
        minimumPixelSize: 29

        font.pixelSize: 46
        elide: Text.ElideRight 

        ToolTip {
            id: toolTip
            text: textArea.text
            width: 250
            target: textArea
            tipEnabled: cView.state == "inactive" ? true : false
        }
    }
