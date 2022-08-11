import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
    id: row

    property int pk: 1
    property string complainantText: ""
    property string defendantText: ""
    property string statusText: ""
    property string titleText: ""
    height: 32
    color: "#12151c"

    Connections
    {
        target: backend

        function onDestroyComplaintTable()
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
        id: cComplainant

        height: 30
        width: 200
        color: "#191d26"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr(complainantText)
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
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
            text: qsTr(defendantText)
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
        width: 100
        color: "#191d26"
        anchors.left: cDefendant.right
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
        id: cTitle

        height: 30
        color: "#191d26"
        anchors.left: cStatus.right
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr(titleText)
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
        onClicked: backend.GetComplaint(pk)
    }
}