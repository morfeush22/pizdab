import QtQuick 2.5

ListModel {
    id: contextMenuNavListModel
    ListElement {
        title: "Capture List"
        url: "qrc:/SideMenus/ContextMenu/Subelements/CaptureList.qml"
    }
    ListElement {
        title: "Options"
        url: "qrc:/SideMenus/ContextMenu/Subelements/OptionsList.qml"
    }
    ListElement {
        title: "About"
        url: "qrc:/SideMenus/ContextMenu/Subelements/About.qml"
    }
}
