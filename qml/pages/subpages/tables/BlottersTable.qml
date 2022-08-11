import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15


Rectangle
{
    id: bTable
    color: "#12151c"

    Component.onCompleted:
    {
        backend.GetBlotters()
    }

    Connections
    {
        target: backend
        
        function onGetBlotters(pk, suspect, date, title)
        {
            var component
            var cell
            component = Qt.createComponent("BlottersRow.qml")
            cell = component.createObject(container, {"anchors.rightMargin": 40, "width": bTable.width, "pk": pk, "suspectText": suspect, "dateText": date, "titleText": title})
        }
    }

    QtObject
    {
        id: internal

        property int rowNum: 0
    }
    

    Rectangle
    {
        id: cSuspect

        height: 30
        width: 250
        color: "#191d26"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr("Suspect")
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    Rectangle
    {
        id: cDate

        height: 30
        width: 200
        color: "#191d26"
        anchors.left: cSuspect.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr("Date Submitted")
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    Rectangle
    {
        id: cTitle

        height: 30
        color: "#191d26"
        anchors.left: cDate.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr("Incident")
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    ScrollView
    {
        id: scroll
        anchors.left: parent.left
        anchors.top: cSuspect.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 1
        anchors.bottomMargin: 1

        contentHeight: container.height
        z: 1

        Column
        {
            id: container
            clip: true 
        }
    }
}