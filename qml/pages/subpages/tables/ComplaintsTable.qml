import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15


Rectangle
{
    id: cTable
    color: "#12151c"

    Component.onCompleted:
    {
        backend.GetComplaints()
    }

    Connections
    {
        target: backend
        
        function onGetComplaints(pk, complainant, defendant, status, title)
        {
            var component
            var cell
            component = Qt.createComponent("ComplaintsRow.qml")
            cell = component.createObject(container, {"anchors.rightMargin": 40, "width": cTable.width, "pk": pk, "complainantText": complainant, "defendantText": defendant, "statusText": status, "titleText": title})
        }
    }

    QtObject
    {
        id: internal

        property int rowNum: 0
    }
    

    Rectangle
    {
        id: cComplainant

        height: 30
        width: 200
        color: "#191d26"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr("Complainant")
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    Rectangle
    {
        id: cDefendant

        height: 30
        width: 200
        color: "#191d26"
        anchors.left: cComplainant.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr("Defendant")
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    Rectangle
    {
        id: cStatus

        height: 30
        width: 100
        color: "#191d26"
        anchors.left: cDefendant.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr("Status")
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }
    Rectangle
    {
        id: cTitle

        height: 30
        color: "#191d26"
        anchors.left: cStatus.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr("Complaint")
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    ScrollView
    {
        id: scroll
        anchors.left: parent.left
        anchors.top: cComplainant.bottom
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