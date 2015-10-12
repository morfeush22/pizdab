import QtQuick 2.5
import QtQuick.Controls 1.2

Rectangle {
    id: optionsList
    property string title
    property bool backButtonBarVisible: true
    color: "#D9D9D9"

    Column {
        Row {
            height: 50
            width: 200
            spacing: 30

            Text {
                id: sfLabel
                text: "sample freq"
            }

            TextInput {
                id: sfInput
                focus: true
                text: schedulerConfig.samplingRate
                validator: IntValidator { bottom: 1 }
            }
        }

        Row {
            height: 50
            width: 200
            spacing: 30

            Text {
                id: cfLabel
                text: "carrier freq"
            }

            TextInput {
                id: cfInput
                focus: true
                text: schedulerConfig.carrierFrequency
                validator: IntValidator { bottom: 1 }
            }
        }

        Button {
            text: "submit"
            onClicked: {
                schedulerConfig.samplingRate = sfInput.text;
                schedulerConfig.carrierFrequency = cfInput.text;
                optionsList.Stack.view.pop();
            }
        }
    }
}
