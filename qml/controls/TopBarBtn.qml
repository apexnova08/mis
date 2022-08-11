import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
    id: btnTopBar

    property url btnIcon: ""
    property color btnHoverColor: "#2b303f"

    implicitWidth: 35
    implicitHeight: 30

    color: "#12151c"

    PropertyAnimation
    {
        id: animationHoverEnterColor
        target: btnTopBar
        property: "color"
        to: btnHoverColor
        duration: 500
        easing.type: Easing.OutQuint
    }
    PropertyAnimation
    {
        id: animationHoverExitColor
        target: btnTopBar
        property: "color"
        to: "#12151c"
        duration: 500
        easing.type: Easing.OutQuint
    }
    Image
    {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        source: btnIcon
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
    }
}