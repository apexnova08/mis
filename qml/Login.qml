import QtQuick 
import QtQuick.Window 
import QtQuick.Controls 
import QtQuick.Controls.Material 

Rectangle
{
    id: login
    
    Material.accent: Material.LightBlue

    Connections
    {
        target: backend
        
        function onLogin(bool)
        {
            if (bool === true)
            {
                var component = Qt.createComponent("app.qml")
                var win = component.createObject()
                win.show()

                visible = false
            }
            else
            {
                txtUsername.Material.foreground = Material.Pink
                txtPassword.Material.foreground = Material.Pink

                lblError.visible = true
            }
        }

        function onLogout()
        {
            visible = true
        }
    }

    Image
    {
        id: logo
        width: 391
        height: 138
        source: "images/login.png"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 100
    }

    TextField
    {
        id: txtUsername
        width: 300
        text: ""
        selectByMouse: true
        placeholderText: "username"

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: logo.bottom
        anchors.topMargin: 30

        onPressed:
        {
            Material.foreground = Material.White
            txtPassword.Material.foreground = Material.White
        }
    }

    TextField
    {
        id: txtPassword
        width: 300
        text: ""
        selectByMouse: true
        placeholderText: "password"

        echoMode: TextInput.Password

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: txtUsername.bottom

        onPressed:
        {
            Material.foreground = Material.White
            txtUsername.Material.foreground = Material.White
        }
    }

    Label
    {
        id: lblError
        width: 300
        font.italic: true
        font.pixelSize: 10
        text: "Incorrect login credentials"
        Material.foreground: Material.Pink
        
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: txtPassword.bottom
        visible: false
    }

    Button
    {
        id: btnLogin
        width: 300
        text: "LOGIN"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: lblError.bottom
        anchors.margins: 5

        onClicked:
        {
            backend.Login(txtUsername.text, txtPassword.text)
        }
    }
}