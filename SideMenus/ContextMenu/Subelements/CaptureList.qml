import QtQuick 2.5
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0

Rectangle {
    id: captureList
    property string title
    property bool backButtonBarVisible: true
    color: "#D9D9D9"

    FileDialog {
        id: fileDialog
        title: "Please choose a file"
        folder: shortcuts.home
        onAccepted: {
            schedulerConfig.inputFilename = fileDialog.fileUrl;
            captureList.Stack.view.push(
                        {item: Qt.resolvedUrl("qrc:/CommonElements/PleaseWait.qml"), replace: true});
            if (threadController.schedulerRunning)
                threadController.stopScheduler();
            else
                threadController.startScheduler(schedulerConfig);
        }
    }

    Button {
        text: threadController.schedulerRunning
        onClicked: {
            fileDialog.visible = true;
        }
    }



    Item {
       id: root
       width: 300
       height: 300

       Item {
           id: src
           anchors.fill: parent

           Rectangle {
               id: myRectangle
               anchors.centerIn: parent
               width: 100
               height: 100
               color: "grey"
           }
       }

       InnerShadow {
           anchors.fill: src
           cached: true
           horizontalOffset: 0
           verticalOffset: 0
           radius: 16
           samples: 32
           color: "#b0000000"
           smooth: true
           source: src
       }
    }
}
