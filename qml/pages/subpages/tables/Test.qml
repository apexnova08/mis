import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Rectangle
{
    id: rTable
    color: "#12151c"

    Connections
    {
        target: backend

        function onGetResidents(sName, fName, addr)
        {
            var component
            var cell
            component = Qt.createComponent("ResidentsRow.qml")
            cell = component.createObject(container, {"anchors.rightMargin": 40, "width": rTable.width, "sNameText": sName, "fNameText": fName, "addressText": addr})
        }
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
        id: cAddress

        height: 30
        color: "#191d26"
        anchors.left: cFName.right
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
/*
    ScrollView
    {
        width: parent.width
        anchors.left: parent.left
        anchors.top: cSName.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 1
        anchors.bottomMargin: 1

        contentHeight: container.height

        clip: true

        Column
        {
            id: container     
            Button
            {
                text: "epic"
                onClicked:
                {
                    backend.GetResidents()
                }
            }
        }
    }
    */
/*
    ScrollView
    {

        anchors.left: parent.left
        anchors.top: cSName.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 1
        clip: true

        Label {
        text: "ABC"
        font.pixelSize: 1000
    }

        Rectangle
        {
            width: 20
            height: 1000
            color: "#00ff00"
        }

        Rectangle
    {
        height: 20
        width: 20
        color: "#ff0000"

        anchors.top: cSName.bottom

        Column
        {
            id: container     
            Button
            {
                text: "epic"
                onClicked:
                {
                    var component;
                    var sprite;
                    component = Qt.createComponent("ResidentsRow.qml");
                    sprite = component.createObject(container, {"x": 100, "y": 100});
                }
            }
        }
    }
    }
*/
    
}