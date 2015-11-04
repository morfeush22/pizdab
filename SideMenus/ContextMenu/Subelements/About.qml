import QtQuick 2.5

Rectangle {
    property bool backButtonBarVisible: true
    property string title

    color: "#D9D9D9"

    Flickable {
        id: about
        anchors.fill: parent
        contentHeight: aboutText.height + aboutText.anchors.topMargin + logos.height + logos.anchors.topMargin + 30
        contentWidth: Math.max(aboutText.width, logos.width) + 30


        Text {
            id: aboutText
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 30
            anchors.topMargin: 30
            font.pointSize: 12
            text: "<b>PizDab</b> <br>

                    Who are we? <br>
                    Two students of final year first degree studies at AGH University of Science and Technology. <br>
                    Pizdab is our thesis due to further work on Software Definied Radio. <br>
                    We would like to thank our promoter - Jarosław Bułat - for all effort put in sdrdab project. <br>
                    <br>
                    Kacper Patro <br>
                    Paweł Szulc
                    "
        }

        Column {
            id: logos
            anchors.left: parent.left
            anchors.top: aboutText.bottom
            anchors.leftMargin: 30
            anchors.topMargin: 20
            spacing: 20

            Image {
                source: "qrc:/images/iet_logo.png"
            }

            Image {
                source: "qrc:/images/kt_logo.png"
            }

            Image {
                source: "qrc:/images/logo.png"
            }
        }
    }
}
