import QtQuick 2.5
import QtQuick.Controls 1.2
import "../../../CommonElements/VirtualKeyboard"

Rectangle {
    id: optionsList
    property string title
    property bool backButtonBarVisible: true
    color: "#D9D9D9"

    Column {
        id: options
        spacing: 20
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 30

        Column {
            Text {
                width: 300
                height: 25
                id: sfLabel
                text: "Sampling Frequency"
                font.pixelSize: height/1.5
                color: "#21201F"
            }

            InputItemDelegate {
                id: sfInput
                inputText: schedulerConfig.samplingRate
                descriptionText: "Hz"
            }
        }

        Column {
            Text {
                width: 300
                height: 25
                id: cfLabel
                text: "Carrier Frequency"
                font.pixelSize: height/1.5
                color: "#21201F"
            }

            InputItemDelegate {
                id: cfInput
                inputText: schedulerConfig.carrierFrequency
                descriptionText: "Hz"
            }
        }
    }

    ButtonDelegate {
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: options.bottom
        anchors.topMargin: 30
        text: "Submit"
        onClicked: {
            schedulerConfig.samplingRate = sfInput.inputText;
            schedulerConfig.carrierFrequency = cfInput.inputText;
            optionsList.Stack.view.pop();
        }
    }

    VirtualKeyboard {
        id: virtualKeyboard

        states: State {
            name: "visible"
            when: sfInput.hasFocus || cfInput.hasFocus
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
