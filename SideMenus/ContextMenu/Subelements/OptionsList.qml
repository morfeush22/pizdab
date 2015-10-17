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
        id: submitFreqConfig
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

    Column {
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: submitFreqConfig.bottom
        anchors.topMargin: 50
        anchors.bottom: parent.bottom

        ListModel {
            id: addressesListModel
            dynamicRoles: true
        }

        Component {
            id: addressesListDelegate
            Text {
                text: address
                font.pixelSize: 12
            }
        }

        Component.onCompleted: {
            var newModel = [];
            var addresses = hostInfo.addresses();
            for (var i = 0; i < addresses.length; i++) {
                newModel.push({"address": addresses[i]});
                //console.log(addresses[i]);
            }

            addressesList.model.clear();
            addressesList.model.append(newModel);
        }

        Text {
            width: 300
            height: 25
            id: addr
            text: "IP addresses"
            font.pixelSize: height/1.5
            color: "#21201F"
        }

        ListView {
            id: addressesList
            width: 300
            height: parent.height
            model: addressesListModel
            delegate: addressesListDelegate
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
