import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

Rectangle
{
    id: row

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    property int pk: 0
    property int resPK: 0
    property string nameText: "<i> -- empty -- </i>"
    property string positionText: ""
    property url imgSource: "../../../mis/pfp/default.png"

    height: 80
    color: "#12151c"

    Component.onCompleted:
    {
        if (nameText == "<i> -- empty -- </i>")
        {
            txtName.color = "#cf1e60"
        }
    }
    Connections
    {
        target: backend
    }

    PropertyAnimation
    {
        id: animationHoverEnterColor
        target: row
        property: "color"
        to: "#3c4758"
        duration: 500
        easing.type: Easing.OutQuint
    }
    PropertyAnimation
    {
        id: animationHoverExitColor
        target: row
        property: "color"
        to: "#12151c"
        duration: 500
        easing.type: Easing.OutQuint
    }
    MouseArea
    {
        hoverEnabled: true
        anchors.fill: parent
        onEntered:
        {
            if (resPK != 0)
            {
                animationHoverExitColor.stop()
                animationHoverEnterColor.running = true
            }
        }
        onExited: animationHoverExitColor.running = true
        onClicked:
        {
            if (resPK != 0)
            {
                backend.GetResident(resPK)
            }
        }
    }

    Rectangle
    {
        color: "#191d26"
        
        anchors.fill: parent
        anchors.margins: 2

        Rectangle
        {
            id: rectPFP
            color: "#12171f"

            width: 72
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.margins: 2

            Image
            {
                id: imgPFP
                anchors.fill: parent
                anchors.margins: 2
                source: imgSource
            }
        }
        Label
        {
            id: txtName
            text: qsTr(nameText)
            color: "#ffffff"
            font.pixelSize: 16

            anchors.left: rectPFP.right
            anchors.top: parent.top
            
            anchors.margins: 20

            onTextChanged:
            {
                if (txtName.text == "<i> -- empty -- </i>")
                {
                    txtName.color = "#cf1e60"
                }
                else
                {
                    txtName.color = "#ffffff"
                }
            }
        }
        Label
        {
            id: txtPosition
            text: qsTr(positionText)
            color: "#ffffff"
            
            anchors.top: txtName.bottom
            anchors.left: rectPFP.right
            anchors.leftMargin: 20
        }
    }
}