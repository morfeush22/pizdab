import QtQuick 2.5

Rectangle {
    id: about
    property string title
    property bool backButtonBarVisible: true
    color: "#D9D9D9"

    Text {
        id: aboutText
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 30
        anchors.leftMargin: 10
        font.pointSize: 12
        text: "<b>Pizdab</b> <br>

                Who are we? <br>
                Two students of final year first degree studies at AGH University of Science and Technology. <br>
                Pizdab is our thesis due to further work on Software Definied Radio. <br>
                We would like to thank our promoter - Jarosław Bułat - for all effort put in sdrdab project. <br>
                <br>
                Kacper Patro <br>
                Paweł Szulc
                "
    }

    Row {
        anchors.top: aboutText.bottom
        anchors.left: parent.left
        anchors.topMargin: 50
        anchors.leftMargin: 10
        spacing: 20

        Image {
            source: "qrc:/images/logo.png"
        }

        Image {
            source: "qrc:/images/iet_logo.png"
        }

        Image {
            source: "qrc:/images/kt_logo.png"
        }

        Image {
            source: "qrc:/images/agh_logo.png"
        }
    }
}
