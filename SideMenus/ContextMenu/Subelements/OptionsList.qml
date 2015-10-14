import QtQuick 2.5
import QtQuick.Controls 1.2
import "../../../CommonElements/VirtualKeyboard"

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
                //focus: true
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
                //focus: true
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

    VirtualKeyboard {
        id: virtualKeyboard

        states: State {
            name: "visible"
            when: sfInput.activeFocus || cfInput.activeFocus
            PropertyChanges {
                target: virtualKeyboard
                y: optionsList.height - virtualKeyboard.height
            }
        }

        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 150
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
