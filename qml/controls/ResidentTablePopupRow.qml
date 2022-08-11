import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
    id: residentsRow

    property int pk: 1
    property string sNameText: ""
    property string fNameText: ""
    property string mNameText: ""
    property string nameExtText: ""
    property string genderText: ""
    property string ageText: ""

    property string typeString: ""
    height: 32
    color: "#12151c"

    Connections
    {
        target: backend

        function onDestroyPopupResidentTable()
        {
            residentsRow.destroy()
        }
    }

    PropertyAnimation
    {
        id: animationHoverEnterColor
        target: residentsRow
        property: "color"
        to: "#3c4758"
        duration: 500
        easing.type: Easing.OutQuint
    }
    PropertyAnimation
    {
        id: animationHoverExitColor
        target: residentsRow
        property: "color"
        to: "#12151c"
        duration: 500
        easing.type: Easing.OutQuint
    }

    Rectangle
    {
        id: cSName

        height: 30
        width: 150
        color: "#191d26"
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr(sNameText)
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
        }
    }
    Rectangle
    {
        id: cFName

        height: 30
        width: 150
        color: "#191d26"
        anchors.left: cSName.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr(fNameText + " " + nameExtText)
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
        }
    }
    Rectangle
    {
        id: cMName

        height: 30
        width: 150
        color: "#191d26"
        anchors.left: cFName.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr(mNameText)
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
        }
    }
    Rectangle
    {
        id: cGender

        height: 30
        width: 75
        color: "#191d26"
        anchors.left: cMName.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr(genderText)
            color: "#ffffff"
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 10
        }
    }
    Rectangle
    {
        id: cAge

        height: 30
        width: 75
        color: "#191d26"
        anchors.left: cGender.right
        anchors.top: parent.top
        anchors.margins: 1

        Label
        {
            text: qsTr(ageText)
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
        onClicked:
        {
            backend.PopupResidentTableReturn(typeString, pk, sNameText, fNameText, mNameText, nameExtText)
        }
    }
}