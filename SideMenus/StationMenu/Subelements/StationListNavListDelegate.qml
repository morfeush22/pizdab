import QtQuick 2.5
import QtQuick.Controls 1.2

Component {
    id: menuDelegate

    Column {
        id: listElement
        width: parent.width

        Rectangle {
            color: "#4D4A48"
            height: 60
            width: parent.width

            Text {
                anchors.left: parent.left
                anchors.leftMargin: 10
                anchors.verticalCenter: parent.verticalCenter
                font.pointSize: 12
                text: station_title ? station_title : ""

                color: {
                    if (mouseArea.containsMouse || station_id === threadController.userFICExtraData.currentStationId)
                        "#FF6426"
                    else
                        "#D9D9D9"
                }
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true

                onClicked: {
                    mainWindow.state = "sideMenusClosed"
                    threadController.changeStation(sub_channel_id);
                }
            }
        }

        Rectangle {
            height: 2
            width: parent.width
            color: mouseArea.containsMouse ? "#FF6426" : "#403E3C"
        }
    }
}
