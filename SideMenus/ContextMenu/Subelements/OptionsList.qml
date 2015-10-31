import QtQuick 2.5
import QtQuick.Controls 1.2
import "../../../CommonElements/VirtualKeyboard"

Rectangle {
    id: optionsList
    property bool backButtonBarVisible: true
    property string title
    color: "#D9D9D9"

    Column {
        id: options
        anchors.left: parent.left
        anchors.margins: 30
        anchors.top: parent.top
        spacing: 20

        Column {
            Text {
                id: sfLabel
                color: "#21201F"
                height: 25
                width: 300
                font.pixelSize: height/1.5
                text: "Sampling Frequency"   
            }

            InputItemDelegate {
                id: sfInput
                descriptionText: "Hz"
                inputText: schedulerConfig.samplingRate 
            }
        }

        Column {
            Text {
                id: cfLabel
                color: "#21201F"
                height: 25
                width: 300
                font.pixelSize: height/1.5
                text: "Carrier Frequency"
            }

            InputItemDelegate {
                id: cfInput
                descriptionText: "Hz"
                inputText: schedulerConfig.carrierFrequency
            }
        }
    }

    ButtonDelegate {
        id: submitFreqConfig
        anchors.left: parent.left
        anchors.top: options.bottom
        anchors.topMargin: 30
        anchors.leftMargin: 30
        text: "Submit"

        onClicked: {
            schedulerConfig.carrierFrequency = cfInput.inputText;
            schedulerConfig.samplingRate = sfInput.inputText;
            optionsList.Stack.view.pop();
        }
    }

    Column {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: submitFreqConfig.bottom
        anchors.leftMargin: 30
        anchors.topMargin: 50

        ListModel {
            id: addressesListModel
            dynamicRoles: true
        }

        Component {
            id: addressesListDelegate
            Text {
                font.pixelSize: 12
                text: address
            }
        }

        Component.onCompleted: {
            var newModel = [];
            var addresses = hostInfo.addresses();
            for (var i = 0; i < addresses.length; i++) {
                newModel.push({"address": addresses[i]});
            }

            addressesList.model.clear();
            addressesList.model.append(newModel);
        }

        Text {
            id: addr
            color: "#21201F"
            font.pixelSize: height/1.5
            height: 25
            width: 300
            text: "IP addresses" 
        }

        ListView {
            id: addressesList
            clip: true
            delegate: addressesListDelegate
            height: parent.height - addr.height - 20
            width: 300
            model: addressesListModel
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
