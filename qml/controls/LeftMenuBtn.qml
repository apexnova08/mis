import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
    id: btnLeftMenu

    property url btnIcon: ""
    property string btnText: ""
    property bool isActive: false
    property url page: ""

    property bool isEnabled: true
    enabled: isEnabled

    implicitWidth: 250
    implicitHeight: 45

    color: "#1b222c"
    
    PropertyAnimation
    {
        id: animationHoverEnterColor
        target: btnLeftMenu
        property: "color"
        to: "#3c4758"
        duration: 500
        easing.type: Easing.OutQuint
    }
    PropertyAnimation
    {
        id: animationHoverExitColor
        target: btnLeftMenu
        property: "color"
        to: "#1b222c"
        duration: 500
        easing.type: Easing.OutQuint
    }
    Image
    {
        enabled: isEnabled
        anchors.left: parent.left
        anchors.leftMargin: 22
        anchors.verticalCenter: parent.verticalCenter
        source: btnIcon
    }
    Label
    {
        enabled: isEnabled
        anchors.left: parent.left
        anchors.leftMargin: 70
        anchors.verticalCenter: parent.verticalCenter
        text: qsTr(btnText)
        color: "white"
    }
    MouseArea
    {
        id: mArea
        anchors.fill: parent
        hoverEnabled: true
        enabled: isEnabled
        onEntered:
        {
            animationHoverExitColor.stop()
            animationHoverEnterColor.running = true
        }
        onExited: animationHoverExitColor.running = true
    }
    Rectangle
    {
        id: aBtnLeftMenu
        color: "#ffffff"
        width: 3
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        visible: isActive
    }
}