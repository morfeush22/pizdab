import QtQuick 2.4
import QtQuick.Window 2.2
import "CoverView"
import "SpectrumView"
import "SideMenus"

Window {
    id: mainWindow
    visible: true

    width: 800; height: 640
    color: "#3E606F"

    FocusScope {
        id: mainView

        width: parent.width; height: parent.height
        focus: true

        state: "showCoverView"

        CoverView {
            id: coverView
        }

        SpectrumView {
            id: spectrumView
        }

        states: [
            State {
                PropertyChanges {
                    target: spectrumView
                    width: 50; height: 50
                    x: 20; y: 20; z: 1
                }

                name: "showCoverView"
                PropertyChanges {
                    target: coverView
                    width: parent.width; height: parent.height
                }
            },

            State {
                name: "showSpectrumView"
                PropertyChanges {
                    target: coverView
                    width: 50; height: 50
                    x: 20; y: 20; z: 1
                }

                PropertyChanges {
                    target: spectrumView
                    width: parent.width; height: parent.height
                }      
            }
        ]
    }
}
