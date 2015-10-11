import QtQuick 2.5
import QtQuick.Controls 1.2

Component {
    id: menuDelegate

    Rectangle {
        width: parent.width
        height: 20

        Rectangle {
            Text { text:
                    if (station_id === threadController.userFICExtraData.currentStationId)
                        station_title ? station_title + " (current)" : ""
                    else
                        station_title ? station_title : ""
            }
        }

        MouseArea {
            anchors.fill: parent
            onClicked: {
                mainWindow.state = "sideMenusClosed"
                threadController.changeStation(sub_channel_id);
            }
        }
    }
}
