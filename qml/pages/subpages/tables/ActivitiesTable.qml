import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Rectangle
{
    id: aTable
    color: "#12151c"

    Component.onCompleted:
    {
        backend.GetActivities()
    }

    Connections
    {
        target: backend
        
        function onGetActivities(pk, activity, date)
        {
            var component
            var cell
            component = Qt.createComponent("ActivitiesRow.qml")
            cell = component.createObject(container, {"anchors.left": container.left, "anchors.right": container.right, "pk": pk, "activityText": activity, "dateText": date})
        }
    }
    Rectangle
    {
        id: cActivity

        height: 30
        color: "#191d26"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: cDate.left
        anchors.margins: 1

        Label
        {
            text: qsTr("Activity / Event")
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    Rectangle
    {
        id: cDate

        height: 30
        width: 200
        color: "#191d26"
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr("Date")
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    ScrollView
    {
        id: scroll
        anchors.left: parent.left
        anchors.top: cActivity.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 1
        anchors.bottomMargin: 1

        contentHeight: container.height
        z: 1

        Rectangle
        {
            id: rectAnchor
            anchors.left: parent.left
            anchors.right: parent.right
        }

        Column
        {
            id: container
            clip: true 

            anchors.top: rectAnchor.bottom
            anchors.left: rectAnchor.left
            anchors.right: rectAnchor.right
        }
    }
}