import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "../../controls"

Rectangle
{
    id: rectangle
    color: "#12151c"

    Component.onCompleted: 
    {
        if (loggedInPK == 0)
        {
            btnAccountSettings.enabled = false
            btnAccountSettings.visible = false
        }
        else
        {
            btnAccountSettings.enabled = true
            btnAccountSettings.visible = true
        }
        backend.DGetAccountInfo(loggedInPK)
    }

    Connections
    {
        target: backend

        function onDGetAccountInfo(name, position)
        {
            lblName.text = qsTr("<b>" + name + "</b>")
            lblPosition.text = qsTr("<i>" + position + "</i>")
        }
        function onVerifyPassword(bool, returnStr)
        {
            if (bool == true && returnStr == "ACCOUNT SYSTEM VERIFY")
            {
                backend.ViewAccountSettings(loggedInPK)
            }
        }
    }
    
    Label
    {
        id: label
        text: qsTr("<i>Logged in as:</i>")
        Material.foreground: Material.Grey
        anchors.left: lblName.left
        anchors.bottom: lblName.top
    }
    
    Label
    {
        id: lblName
        text: qsTr("")
        font.pixelSize: 20

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: 20
        anchors.topMargin: 30
    }
    Label
    {
        id: lblPosition
        text: qsTr("")

        anchors.left: parent.left
        anchors.top: lblName.bottom
        anchors.leftMargin: 20
    }

    Rectangle
    {
        id: btnAccountSettings

        width: 170
        height: 50
        color: "#191d26"
        enabled: true

        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: 20

        PropertyAnimation
        {
            id: animationHoverEnterColor
            target: btnAccountSettings
            property: "color"
            to: "#3c4758"
            duration: 500
            easing.type: Easing.OutQuint
        }
        PropertyAnimation
        {
            id: animationHoverExitColor
            target: btnAccountSettings
            property: "color"
            to: "#191d26"
            duration: 500
            easing.type: Easing.OutQuint
        }
        MouseArea
        {
            id: mArea
            anchors.fill: parent
            hoverEnabled: true
            enabled: btnAccountSettings.enabled
            onEntered:
            {
                animationHoverExitColor.stop()
                animationHoverEnterColor.running = true
            }
            onExited: animationHoverExitColor.running = true
            onClicked:
            {
                animationHoverExitColor.running = true
                viewSettingsVerifyPass.open()
            }
        }

        Image
        {
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
            source: "../../images/icons/settings.png"
        }
        Label
        {
            anchors.left: parent.left
            anchors.leftMargin: 50
            anchors.verticalCenter: parent.verticalCenter
            text: qsTr("Account Settings")
        }
    }
    VerifyPasswordPopup
    {
        id: viewSettingsVerifyPass
        popText: "<i>Type in your password to view your account settings...</i>"
        popFunc: "ACCOUNT SYSTEM VERIFY"
    }
}