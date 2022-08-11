import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
    id: houseBL

    property string propertyType: "R"
    
    property string btnBlock: ""
    property string btnLot: ""

    implicitWidth: 26
    implicitHeight: 26

    color: "#3232ff"
    opacity: 0.1
    
    Component.onCompleted:
    {
        if (propertyType == "B")
        {
            color = "#c83223"
        }
        if (propertyType == "C")
        {
            color = "#ffff00"
        }
        if (propertyType == "V")
        {
            color = "#323232"
        }
    }

    Connections
    {
        target: backend
    }

    PropertyAnimation
    {
        id: animationHoverEnterColor
        target: houseBL
        property: "opacity"
        to: 1
        duration: 500
        easing.type: Easing.OutQuint
    }
    PropertyAnimation
    {
        id: animationHoverExitColor
        target: houseBL
        property: "opacity"
        to: 0.1
        duration: 500
        easing.type: Easing.OutQuint
    }
    MouseArea
    {
        id: mArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered:
        {
            animationHoverExitColor.stop()
            animationHoverEnterColor.running = true
        }
        onExited: animationHoverExitColor.running = true
        onClicked: 
        {
            if (propertyType == "R")
            {
                backend.GetLotResidents(btnLot, btnBlock)
            }
        }
    }
}