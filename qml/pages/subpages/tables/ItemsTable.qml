import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Rectangle
{
    id: iTable
    color: "#12151c"

    Component.onCompleted:
    {
        backend.GetItems()
    }

    Connections
    {
        target: backend
        
        function onGetItems(pk, item, amount, camount)
        {
            var component
            var cell
            component = Qt.createComponent("ItemsRow.qml")
            cell = component.createObject(container, {"anchors.rightMargin": 40, "width": iTable.width, "pk": pk, "itemText": item, "amountText": amount, "camountText": camount})
        }
    }

    QtObject
    {
        id: internal

        property int rowNum: 0
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
            text: qsTr("Item Name")
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
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
            text: qsTr("Total Quantity")
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
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
            text: qsTr("Current Quantity")
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    ScrollView
    {
        id: scroll
        anchors.left: parent.left
        anchors.top: cItem.bottom
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