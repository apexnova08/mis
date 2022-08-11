import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Popup
{
    id: passwordPopup
    width: 500
    height: 300
    modal: true
    focus: true

    Material.theme: Material.Dark
    anchors.centerIn: Overlay.overlay
    Overlay.modal: Rectangle
    {
        color: "#aacfdbe7"
    }

    property string popText: qsTr("<i>Type in your password to proceed with this action...</i>")
    property string popFunc: ""
    onClosed:
    {
        txtPassword.text = ""
        internal.clearErrors()
    }
    QtObject
    {
        id: internal

        function clearErrors()
        {
            lblError.visible = false
            txtPassword.Material.foreground = Material.White
        }
        function verify()
        {
            internal.clearErrors()
            if (txtPassword.text == "")
            {
                lblError.text = qsTr("<i>Missing required fields</i>")
                lblError.visible = true
            }
            else
            {
                backend.VerifyPassword(loggedInPK, txtPassword.text, popFunc)
            }
        }
    }
    Connections
    {
        target: backend

        function onVerifyPassword(bool, returnStr)
        {
            if (bool == true && returnStr == popFunc)
            {
                passwordPopup.close()
            }
            if (bool == false && returnStr == popFunc)
            {
                lblError.text = qsTr("<i>Incorrect password</i>")
                lblError.visible = true
            }
        }
        function onSystemTimeOut()
        {
            passwordPopup.close()
        }
    }

    Rectangle
    {
        id: bg
        color: "#1b222c"

        anchors.fill: parent

        Rectangle
        {
            id: colorBar
            color: "#cf1e60"
            height: 10
            visible: false

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
        }

        Label
        {
            id: lblText
            text: qsTr(popText)

            horizontalAlignment: Label.AlignHCenter
            wrapMode: Label.WordWrap

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
            
            anchors.leftMargin: 20
            anchors.topMargin: 60
            anchors.rightMargin: 20
        }
        TextField
        {
            id: txtPassword
            width: 300
            text: ""
            selectByMouse: true
            placeholderText: qsTr("<i>password</i>")

            echoMode: TextInput.Password

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter

            onPressed: Material.foreground = Material.White
            Keys.onReturnPressed: internal.verify()
        }
        Rectangle
        {
            id: viewPass
            color: "#1b222c"

            width: 20
            height: 20
            
            anchors.right: txtPassword.right
            anchors.verticalCenter: txtPassword.verticalCenter

            PropertyAnimation {id: animationViewHoverEnterColor; target: viewPass; property: "color"; to: "#3c4758"; duration: 500; easing.type: Easing.OutQuint;}
            PropertyAnimation {id: animationViewHoverExitColor; target: viewPass; property: "color"; to: "#1b222c"; duration: 500; easing.type: Easing.OutQuint;}
            Image
            {
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                source: "../images/icons/eye.png"
            }
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                onEntered:
                {
                    txtPassword.echoMode = TextInput.Normal
                    animationViewHoverExitColor.stop()
                    animationViewHoverEnterColor.running = true
                }
                onExited:
                {
                    txtPassword.echoMode = TextInput.Password
                    animationViewHoverExitColor.running = true
                }
            }
        }
        Label
        {
            id: lblError
            text: qsTr("")
            visible: false
            Material.foreground: Material.Pink

            anchors.left: txtPassword.left
            anchors.top: txtPassword.bottom
        }
        Rectangle
        {
            id: btnOK
            color: "#3c3c3c"
            radius: 2
            height: 40
            
            anchors.left: parent.left
            anchors.right: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.margins: 20

            Label
            {
                text: qsTr("Continue")
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            PropertyAnimation {id: animationOKButtonHoverEnter; target: btnOK; property: "color"; to: "#5a5a5a"; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {id: animationOKButtonHoverExit; target: btnOK; property: "color"; to: "#3c3c3c"; duration: 1000; easing.type: Easing.OutQuint}
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                onEntered:
                {
                    animationOKButtonHoverExit.stop()
                    animationOKButtonHoverEnter.running = true
                }
                onExited: animationOKButtonHoverExit.running = true
                onClicked: internal.verify()
            }
        }
        Rectangle
        {
            id: btnBack
            color: "#3c3c3c"
            radius: 2
            height: 40
            
            anchors.left: parent.horizontalCenter
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 20

            Label
            {
                text: qsTr("Cancel")
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            PropertyAnimation {id: animationBackButtonHoverEnter; target: btnBack; property: "color"; to: "#5a5a5a"; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {id: animationBackButtonHoverExit; target: btnBack; property: "color"; to: "#3c3c3c"; duration: 1000; easing.type: Easing.OutQuint}
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                onEntered:
                {
                    animationBackButtonHoverExit.stop()
                    animationBackButtonHoverEnter.running = true
                }
                onExited: animationBackButtonHoverExit.running = true
                onClicked: passwordPopup.close()
            }
        }
    }
}