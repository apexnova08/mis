import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
    id: row

    property int pk: 1
    property string borrowerText: ""
    property string itemText: ""
    property string quantityText: ""
    property string statusText: ""
    property string dateText: ""
    height: 32
    color: "#12151c"

    Connections
    {
        target: backend

        function onDestroyBorrowedItemsTable()
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
        id: cBorrower

        height: 30
        width: 200
        color: "#191d26"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr(borrowerText)
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
        }
    }
    Rectangle
    {
        id: cItem

        height: 30
        width: 200
        color: "#191d26"
        anchors.left: cBorrower.right
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
        id: cQuantity

        height: 30
        width: 80
        color: "#191d26"
        anchors.left: cItem.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr(quantityText)
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
        }
    }
    Rectangle
    {
        id: cStatus

        height: 30
        width: 150
        color: "#191d26"
        anchors.left: cQuantity.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr(statusText)
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
        }
    }
    Rectangle
    {
        id: cDate

        height: 30
        color: "#191d26"
        anchors.left: cStatus.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr(dateText)
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
        onClicked: backend.GetBorrowedItem(pk)
    }
}