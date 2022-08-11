import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Rectangle
{
    id: rTable
    color: "#12151c"

    Component.onCompleted:
    {
        backend.GetResidents()
    }

    Connections
    {
        target: backend
        
        function onGetResidents(pk, sName, fName, mName, addr)
        {
            var component
            var cell
            component = Qt.createComponent("ResidentsRow.qml")
            cell = component.createObject(container, {"anchors.rightMargin": 40, "width": rTable.width, "pk": pk, "sNameText": sName, "fNameText": fName, "mNameText": mName, "addressText": addr, "resType": "RESIDENT"})
        }
    }

    QtObject
    {
        id: internal

        property int rowNum: 0
    }
    

    Rectangle
    {
        id: cSName

        height: 30
        width: 150
        color: "#191d26"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr("Surname")
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    Rectangle
    {
        id: cFName

        height: 30
        width: 150
        color: "#191d26"
        anchors.left: cSName.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr("First Name")
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    Rectangle
    {
        id: cMName

        height: 30
        width: 150
        color: "#191d26"
        anchors.left: cFName.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr("Middle Name")
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    Rectangle
    {
        id: cAddress

        height: 30
        color: "#191d26"
        anchors.left: cMName.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr("Address")
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    ScrollView
    {
        id: scroll
        anchors.left: parent.left
        anchors.top: cSName.bottom
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