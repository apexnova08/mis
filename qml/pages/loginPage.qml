import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Item
{
    QtObject
    {
        id: internal
        function login()
        {
            txtLoginPassword.focus = false
            if (txtLoginUsername.text == "" || txtLoginPassword.text == "")
            {
                lblLoginError.text = qsTr("<i>Missing required fields</i>")
                lblLoginError.visible = true
            }
            else
            {
                backend.Login(txtLoginUsername.text, txtLoginPassword.text)
            }
        }
    }
    Connections
    {
        target: backend

        function onLogin(bool, pk, resPK, position)
        {
            if (bool === true && position != "None")
            {
                txtLoginUsername.Material.foreground = Material.White
                txtLoginPassword.Material.foreground = Material.White

                txtLoginPassword.text = ""
                lblLoginError.visible = false
            }
            else
            {
                txtLoginUsername.Material.foreground = Material.Pink
                txtLoginPassword.Material.foreground = Material.Pink

                lblLoginError.text = qsTr("<i>Incorrect login credentials</i>")
                lblLoginError.visible = true
            }
        }
        function onSystemTimeOut()
        {
            if (loggedIn == true)
            {
                lblSessionTimeOut.visible = true
            }
        }
    }
    //Login
    Rectangle
    {
        id: login
        color: "#12151c"
        anchors.fill: parent
        
        // Login Design
        Image
        {
            id: loginLogo
            width: 391
            height: 138
            source: "../images/login.png"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 100
        }

        TextField
        {
            id: txtLoginUsername
            width: 300
            text: ""
            selectByMouse: true
            placeholderText: qsTr("<i>username</i>")

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: loginLogo.bottom
            anchors.topMargin: 30

            onPressed:
            {
                Material.foreground = Material.White
                txtLoginPassword.Material.foreground = Material.White
                lblSessionTimeOut.visible = false
            }
        }
        TextField
        {
            id: txtLoginPassword
            width: 300
            text: ""
            selectByMouse: true
            placeholderText: qsTr("<i>password</i>")

            echoMode: TextInput.Password

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: txtLoginUsername.bottom

            onPressed:
            {
                Material.foreground = Material.White
                txtLoginUsername.Material.foreground = Material.White
                lblSessionTimeOut.visible = false
            }
            Keys.onReturnPressed: internal.login()
        }
        Rectangle
        {
            id: viewPass
            color: "#12151c"

            width: 20
            height: 20
            
            anchors.right: txtLoginPassword.right
            anchors.verticalCenter: txtLoginPassword.verticalCenter

            PropertyAnimation {id: animationViewHoverEnterColor; target: viewPass; property: "color"; to: "#3c4758"; duration: 500; easing.type: Easing.OutQuint;}
            PropertyAnimation {id: animationViewHoverExitColor; target: viewPass; property: "color"; to: "#12151c"; duration: 500; easing.type: Easing.OutQuint;}
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
                    txtLoginPassword.echoMode = TextInput.Normal
                    animationViewHoverExitColor.stop()
                    animationViewHoverEnterColor.running = true
                }
                onExited:
                {
                    txtLoginPassword.echoMode = TextInput.Password
                    animationViewHoverExitColor.running = true
                }
            }
        }

        Label
        {
            id: lblLoginError
            font.pixelSize: 10
            text: qsTr("")
            Material.foreground: Material.Pink
    
            anchors.left: txtLoginUsername.left
            anchors.top: txtLoginPassword.bottom
            visible: false
        }

        Button
        {
            id: btnLogin
            width: 300
            text: "LOGIN"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: lblLoginError.bottom
            anchors.margins: 5

            onClicked: internal.login()
        }
        Label
        {
            id: lblForgotPassword
            font.italic: true
            font.pixelSize: 12
            text: "Forgot password?"
            Material.foreground: Material.White
    
            anchors.right: btnLogin.right
            anchors.top: btnLogin.bottom

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true

                onEntered: lblForgotPassword.font.underline = true
                onExited: lblForgotPassword.font.underline = false
                onClicked: backend.ForgotPassword()
            }
        }
        Label
        {
            id: lblSessionTimeOut
            text: qsTr("<i>Session timed out: Inactive for more than 5 minutes</i>")
            Material.foreground: Material.Pink
            visible: false
    
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: btnLogin.bottom
            anchors.topMargin: 50
        }
    }
}