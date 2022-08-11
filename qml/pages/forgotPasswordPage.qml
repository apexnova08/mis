import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "../controls"

Item
{
    QtObject
    {
        id: internal

        function clearErrors()
        {
            txtUsername.Material.foreground = Material.White
            txtA1.Material.foreground = Material.White
            txtA2.Material.foreground = Material.White
            txtPassword.Material.foreground = Material.White
            txtPasswordR.Material.foreground = Material.White

            lblError1.visible = false
            lblError2.visible = false
            lblError3.visible = false
        }
    }
    Connections
    {
        target: backend

        function onUsernameExists(bool)
        {
            internal.clearErrors()
            if (bool == false)
            {
                lblError1.text = qsTr("<i>Entered username does not exist</i>")
                lblError1.visible = true
                txtUsername.Material.foreground = Material.Pink
            }
            else
            {
                backend.GetSecurityQuestions(txtUsername.text)
                animationNextTo2.running = true
            }
        }
        function onGetSecurityQuestions(q1, q2)
        {
            lblQ1.text = q1
            lblQ2.text = q2
        }
        function onCheckSecurityQuestions(bool)
        {
            internal.clearErrors()
            if (bool == false)
            {
                txtA1.Material.foreground = Material.Pink
                txtA2.Material.foreground = Material.Pink
                lblError2.text = qsTr("<i>Incorrect answer(s).</i>")
                lblError2.visible = true
            }
            else
            {
                animationNextTo3.running = true
            }
        }
        function onRecoverAccount()
        {
            backend.ChangeOfficialPassword(txtUsername.text, txtPassword.text)
        }
    }
    Rectangle
    {
        id: bg
        color: "#12151c"
        anchors.fill: parent

        SequentialAnimation
        {
            id: animationNextTo2
            ParallelAnimation
            {
                PropertyAnimation {target: container1; property: "anchors.leftMargin"; to: -bg.width; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container2; property: "anchors.leftMargin"; to: -bg.width; duration: 500; easing.type: Easing.OutQuint}
            }
            ParallelAnimation
            {
                PropertyAnimation {target: container1; property: "anchors.left"; to: leftAnchor.left; duration: 0; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container1; property: "anchors.leftMargin"; to: 0; duration: 0; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container2; property: "anchors.left"; to: bg.left; duration: 0; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container2; property: "anchors.leftMargin"; to: 0; duration: 0; easing.type: Easing.OutQuint}
            }
        }
        SequentialAnimation
        {
            id: animationNextTo3
            ParallelAnimation
            {
                PropertyAnimation {target: container2; property: "anchors.leftMargin"; to: -bg.width; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container3; property: "anchors.leftMargin"; to: -bg.width; duration: 500; easing.type: Easing.OutQuint}
            }
            ParallelAnimation
            {
                PropertyAnimation {target: container2; property: "anchors.left"; to: leftAnchor.left; duration: 0; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container2; property: "anchors.leftMargin"; to: 0; duration: 0; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container3; property: "anchors.left"; to: bg.left; duration: 0; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container3; property: "anchors.leftMargin"; to: 0; duration: 0; easing.type: Easing.OutQuint}
            }
        }
        SequentialAnimation
        {
            id: animationBackTo2
            ParallelAnimation
            {
                PropertyAnimation {target: container2; property: "anchors.leftMargin"; to: bg.width; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container3; property: "anchors.leftMargin"; to: bg.width; duration: 500; easing.type: Easing.OutQuint}
            }
            ParallelAnimation
            {
                PropertyAnimation {target: container2; property: "anchors.left"; to: bg.left; duration: 0; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container2; property: "anchors.leftMargin"; to: 0; duration: 0; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container3; property: "anchors.left"; to: bg.right; duration: 0; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container3; property: "anchors.leftMargin"; to: 0; duration: 0; easing.type: Easing.OutQuint}
            }
        }
        SequentialAnimation
        {
            id: animationBackTo1
            ParallelAnimation
            {
                PropertyAnimation {target: container1; property: "anchors.leftMargin"; to: bg.width; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container2; property: "anchors.leftMargin"; to: bg.width; duration: 500; easing.type: Easing.OutQuint}
            }
            ParallelAnimation
            {
                PropertyAnimation {target: container1; property: "anchors.left"; to: bg.left; duration: 0; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container1; property: "anchors.leftMargin"; to: 0; duration: 0; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container2; property: "anchors.left"; to: bg.right; duration: 0; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container2; property: "anchors.leftMargin"; to: 0; duration: 0; easing.type: Easing.OutQuint}
            }
        }
        // Anchors
        Rectangle
        {
            id: leftAnchor
            width: parent.width
            color: "#12151c"
            anchors.top: parent.top
            anchors.right: parent.left
            anchors.bottom: parent.bottom
        }
        
        // BG Image
        Image
        {
            id: logo
            width: 400
            height: 400
            source: "../images/logo.png"
            opacity: 0.1
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }

        // Page 1
        Rectangle
        {
            id: container1
            width: parent.width
            color: "transparent"
            
            anchors.left: bg.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }
        Label
        {
            id: lblTitle
            text: qsTr("<b>Recover your Account</b>")
            font.pixelSize: 20

            anchors.horizontalCenter: container1.horizontalCenter
            anchors.bottom: txtUsername.top
            anchors.bottomMargin: 70
        }
        Label
        {
            font.pixelSize: 12
            text: qsTr("<i>Type in your username to get started...</i>")
    
            anchors.horizontalCenter: container1.horizontalCenter
            anchors.top: lblTitle.bottom
        }
        TextField
        {
            id: txtUsername
            width: 300
            selectByMouse: true
            placeholderText: qsTr("<i>username</i>")

            anchors.horizontalCenter: container1.horizontalCenter
            anchors.bottom: container1.verticalCenter
            anchors.bottomMargin: 70

            onPressed: Material.foreground = Material.White
        }
        Label
        {
            id: lblUsernameNotExists
            font.pixelSize: 10
            text: qsTr("<i>Entered username does not exist</i>")
            Material.foreground: Material.Pink
            visible: false

            anchors.left: txtUsername.left
            anchors.top: txtUsername.bottom
        }
        Button
        {
            id: btnNext1
            width: 300
            text: "NEXT"
            anchors.horizontalCenter: container1.horizontalCenter
            anchors.top: txtUsername.bottom
            anchors.topMargin: 10

            onClicked: 
            {
                internal.clearErrors()
                if (txtUsername.text == "")
                {
                    lblError1.text = qsTr("<i>Missing required fields</i>")
                    lblError1.visible = true
                }
                else
                {
                    backend.CheckIfUsernameExists(txtUsername.text)
                }
            }
        }
        Label
        {
            id: lblError1
            font.pixelSize: 10
            text: qsTr("")
            Material.foreground: Material.Pink
            visible: false
    
            anchors.left: btnNext1.left
            anchors.top: btnNext1.bottom
        }
        Button
        {
            id: btnCancel
            text: "Cancel"
            anchors.left: container1.left
            anchors.bottom: container1.bottom
            anchors.margins: 20

            onClicked: 
            {
                internal.clearErrors()
                if (txtUsername.text == "" && txtPassword.text == "" && txtPasswordR.text == "" && txtA1.text == "" && txtA2.text == "")
                {
                    backend.PopupFunc("GOTO LOGIN")
                }
                else
                {
                    cancelAccountRecoveryPopup.open()
                }
            }
        }

        // Page 2
        Rectangle
        {
            id: container2
            width: parent.width
            color: "transparent"

            anchors.left: bg.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }
        Label
        {
            id: lblTitleSecQuestions
            text: qsTr("<b>Security Questions</b>")
            font.pixelSize: 20

            anchors.horizontalCenter: container2.horizontalCenter
            anchors.top: container2.top
            anchors.topMargin: 100
        }
        Label
        {
            font.pixelSize: 12
            text: qsTr("<i>Answer these security questions to verify that it's you.</i>")
    
            anchors.horizontalCenter: container2.horizontalCenter
            anchors.top: lblTitleSecQuestions.bottom
        }
        Label
        {
            font.pixelSize: 12
            text: qsTr("<i>Question 1</i>")
    
            anchors.left: lblQ1.left
            anchors.bottom: lblQ1.top
        }
        Label
        {
            id: lblQ1
            text: qsTr("")

            anchors.left: txtA1.left
            anchors.top: lblTitleSecQuestions.bottom
            anchors.topMargin: 80
        }
        TextField
        {
            id: txtA1
            width: 300
            selectByMouse: true
            placeholderText: qsTr("<i>answer...</i>")

            anchors.horizontalCenter: container2.horizontalCenter
            anchors.top: lblQ1.bottom
            anchors.topMargin: 10

            onPressed:
            {
                Material.foreground = Material.White
                txtA2.Material.foreground = Material.White
            }
        }
        Label
        {
            font.pixelSize: 12
            text: qsTr("<i>Question 2</i>")
    
            anchors.left: lblQ2.left
            anchors.bottom: lblQ2.top
        }
        Label
        {
            id: lblQ2
            text: qsTr("")

            anchors.left: txtA2.left
            anchors.top: txtA1.bottom
            anchors.topMargin: 40
        }
        TextField
        {
            id: txtA2
            width: 300
            selectByMouse: true
            placeholderText: qsTr("<i>answer...</i>")

            anchors.horizontalCenter: container2.horizontalCenter
            anchors.top: lblQ2.bottom
            anchors.topMargin: 10

            onPressed:
            {
                Material.foreground = Material.White
                txtA1.Material.foreground = Material.White
            }
        }
        Button
        {
            id: btnNext2
            width: 300
            text: "NEXT"
            anchors.horizontalCenter: container2.horizontalCenter
            anchors.top: txtA2.bottom
            anchors.topMargin: 20

            onClicked: 
            {
                internal.clearErrors()
                if (txtA1.text == "" || txtA2.text == "")
                {
                    lblError2.text = qsTr("<i>Missing required fields</i>")
                    lblError2.visible = true
                }
                else
                {
                    backend.CheckSecurityQuestions(txtUsername.text, txtA1.text, txtA2.text)
                }
            }
        }
        Label
        {
            id: lblError2
            font.pixelSize: 10
            text: qsTr("")
            Material.foreground: Material.Pink
            visible: false
    
            anchors.left: btnNext2.left
            anchors.top: btnNext2.bottom
        }
        Button
        {
            id: btnBack
            text: "Back"
            anchors.left: container2.left
            anchors.bottom: container2.bottom
            anchors.margins: 20

            onClicked: animationBackTo1.running = true
        }
        // Page 3
        Rectangle
        {
            id: container3
            width: parent.width
            color: "transparent"
            
            anchors.left: bg.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
        }
        Label
        {
            id: lblTitleSecPassword
            text: qsTr("<b><i>Enter your New Password...</i></b>")
            font.pixelSize: 20

            anchors.horizontalCenter: container3.horizontalCenter
            anchors.bottom: txtPassword.top
            anchors.bottomMargin: 80
        }
        Label
        {
            font.pixelSize: 12
            text: qsTr("<i>Create a more memorable password this time.</i>")
    
            anchors.horizontalCenter: container3.horizontalCenter
            anchors.top: lblTitleSecPassword.bottom
        }
        TextField
        {
            id: txtPassword
            width: 300
            selectByMouse: true
            placeholderText: qsTr("<i>password</i>")

            echoMode: TextInput.Password

            anchors.horizontalCenter: container3.horizontalCenter
            anchors.bottom: txtPasswordR.top
            anchors.bottomMargin: 10

            onPressed:
            {
                Material.foreground = Material.White
                txtPasswordR.Material.foreground = Material.White
            }
        }
        Rectangle
        {
            id: viewPass
            color: "#12151c"

            width: 20
            height: 20
            
            anchors.right: txtPassword.right
            anchors.verticalCenter: txtPassword.verticalCenter

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
        TextField
        {
            id: txtPasswordR
            width: 300
            selectByMouse: true
            placeholderText: qsTr("<i>re-enter password</i>")

            echoMode: TextInput.Password

            anchors.horizontalCenter: container3.horizontalCenter
            anchors.verticalCenter: container3.verticalCenter

            onPressed:
            {
                Material.foreground = Material.White
                txtPassword.Material.foreground = Material.White
            }
        }
        Rectangle
        {
            id: viewPassR
            color: "#12151c"

            width: 20
            height: 20
            
            anchors.right: txtPasswordR.right
            anchors.verticalCenter: txtPasswordR.verticalCenter

            PropertyAnimation {id: animationViewHoverEnterColorR; target: viewPassR; property: "color"; to: "#3c4758"; duration: 500; easing.type: Easing.OutQuint;}
            PropertyAnimation {id: animationViewHoverExitColorR; target: viewPassR; property: "color"; to: "#12151c"; duration: 500; easing.type: Easing.OutQuint;}
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
                    txtPasswordR.echoMode = TextInput.Normal
                    animationViewHoverExitColorR.stop()
                    animationViewHoverEnterColorR.running = true
                }
                onExited:
                {
                    txtPasswordR.echoMode = TextInput.Password
                    animationViewHoverExitColorR.running = true
                }
            }
        }
        Button
        {
            id: btnChangePass
            width: 300
            text: "CHANGE PASSWORD"
            anchors.horizontalCenter: container3.horizontalCenter
            anchors.top: txtPasswordR.bottom
            anchors.topMargin: 20

            onClicked: 
            {
                internal.clearErrors()
                if (txtPassword.text == "" || txtPasswordR.text == "")
                {
                    lblError3.text = qsTr("<i>Missing required fields</i>")
                    lblError3.visible = true
                }
                else if (txtPassword.text != txtPasswordR.text)
                {
                    txtPassword.Material.foreground = Material.Pink
                    txtPasswordR.Material.foreground = Material.Pink
                    lblError3.text = qsTr("<i>Entered passwords does not match!</i>")
                    lblError3.visible = true
                }
                else
                {
                    recoverAccountPopup.open()
                }
            }
        }
        Label
        {
            id: lblError3
            font.pixelSize: 10
            text: qsTr("")
            Material.foreground: Material.Pink
            visible: false
    
            anchors.left: btnChangePass.left
            anchors.top: btnChangePass.bottom
        }
        Button
        {
            id: btnBack2
            text: "Back"
            anchors.left: container3.left
            anchors.bottom: container3.bottom
            anchors.margins: 20

            onClicked: animationBackTo2.running = true
        }
    }
    CustomPopup
    {
        id: recoverAccountPopup
        popText: "You are about to change your password. Continue?"
        popFunc: "ACCOUNT RECOVER"
    }
    CustomPopup
    {
        id: cancelAccountRecoveryPopup
        popText: "You are about to cancel recovery of your account. Continue?"
        popWarningText: "No changes will be made"

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "GOTO LOGIN"
        isWarning: true
    }
}