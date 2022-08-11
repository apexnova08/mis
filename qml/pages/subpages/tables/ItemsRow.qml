import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
    id: row

    property int pk: 1
    property string itemText: ""
    property string amountText: ""
    property string camountText: ""
    height: 32
    color: "#12151c"

    Connections
    {
        target: backend

        function onDestroyItemsTable()
        {
            row.destroy()
        }
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
    Rectangle
    {
        id: cItem

        height: 30
        color: "#191d26"
        anchors.left: parent.left
        anchors.right: cAmount.left
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr(itemText)
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
        }
    }
    Rectangle
    {
        id: cAmount

        height: 30
        width: 200
        color: "#191d26"
        anchors.right: cCAmount.left
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr(amountText)
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
        }
    }
    Rectangle
    {
        id: cCAmount

        height: 30
        width: 200
        color: "#191d26"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr(camountText)
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
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
        onClicked: backend.GetItem(pk)
    }
}