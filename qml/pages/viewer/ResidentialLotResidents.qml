import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
    id: residentInfo

    property int pk: 1
    property string nameText: ""
    property string infoText: ""
    property bool isHead: false
    height: 80
    color: "#12171f"

    Component.onCompleted:
    {
        if (isHead == true)
        {
            txtHead.visible = true
        }
    }
    Connections
    {
        target: backend

        function onDestroyResidentialLot()
        {
            residentInfo.destroy()
        }
    }

    PropertyAnimation
    {
        id: animationHoverEnterColor
        target: residentInfo
        property: "color"
        to: "#3c4758"
        duration: 500
        easing.type: Easing.OutQuint
    }
    PropertyAnimation
    {
        id: animationHoverExitColor
        target: residentInfo
        property: "color"
        to: "#12171f"
        duration: 500
        easing.type: Easing.OutQuint
    }

    Rectangle
    {
        color: "#191d26"
        
        anchors.fill: parent
        anchors.margins: 2

        Label
        {
            id: txtName
            text: qsTr(nameText)
            color: "#ffffff"
            font.pixelSize: 16

            anchors.left: parent.left
            anchors.top: parent.top
            
            anchors.margins: 20
        }
        Label
        {
            id: txtInfo
            text: qsTr(infoText)
            color: "#ffffff"
            
            anchors.top: txtName.bottom
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
        Label
        {
            id: txtHead
            text: qsTr("<i>Head of the family</i>")
            color: "#ffffff"
            visible: false
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20
        }
    }
    MouseArea
    {
        hoverEnabled: true
        anchors.fill: parent
        onEntered:
        {
            animationHoverExitColor.stop()
            animationHoverEnterColor.running = true
        }
        onExited: animationHoverExitColor.running = true
        onClicked: backend.GetLotResident(pk)
    }
}