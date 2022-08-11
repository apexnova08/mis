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
            txtPassword.Material.foreground = Material.White
            txtPasswordR.Material.foreground = Material.White

            lblUsernameTaken.visible = false
            lblPasswordNotMatch.visible = false
            lblMissingFieldsError.visible = false
            lblMissingFieldsError2.visible = false
        }
    }
    Connections
    {
        target: backend

        function onUsernameExists(bool)
        {
            internal.clearErrors()

            if (bool == true && registerTurnOver == "NO")
            {
                lblUsernameTaken.visible = true
                txtUsername.Material.foreground = Material.Pink
            }
            else
            {
                animationNext.running = true
            }
        }
        function onRegisterOfficialAccount()
        {
            backend.RegisterOfficialAccount(registerTurnOver, registerAccountPK, registerAccountName, registerAccountPosition, txtUsername.text, txtPassword.text, comboQ1.currentValue, txtA1.text, comboQ2.currentValue, txtA2.text)
        }
    }
    Rectangle
    {
        id: bg
        color: "#12151c"
        anchors.fill: parent

        SequentialAnimation
        {
            id: animationNext
            PropertyAnimation {target: container1; property: "anchors.rightMargin"; to: bg.width; duration: 500; easing.type: Easing.OutQuint}
            ParallelAnimation
            {
                PropertyAnimation {target: container1; property: "anchors.right"; to: bg.left; duration: 0; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container1; property: "anchors.rightMargin"; to: 0; duration: 0; easing.type: Easing.OutQuint}
            }
        }
        SequentialAnimation
        {
            id: animationBack
            ParallelAnimation
            {
                PropertyAnimation {target: container1; property: "anchors.right"; to: bg.right; duration: 0; easing.type: Easing.OutQuint}
                PropertyAnimation {target: container1; property: "anchors.rightMargin"; to: bg.width; duration: 0; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: container1; property: "anchors.rightMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
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
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
        }
        Label
        {
            id: lblTitle
            text: qsTr("<b>Register Official Account</b>")
            font.pixelSize: 20

            anchors.horizontalCenter: container1.horizontalCenter
            anchors.top: container1.top
            anchors.topMargin: 100
        }
        Label
        {
            id: lblName
            text: qsTr("for <b>" + registerAccountName + "</b>")
            font.pixelSize: 15

            anchors.horizontalCenter: container1.horizontalCenter
            anchors.top: lblTitle.bottom
            anchors.topMargin: 20
        }
        Label
        {
            id: lblPosition
            text: qsTr("as " + registerAccountPosition)
            font.pixelSize: 15

            anchors.horizontalCenter: container1.horizontalCenter
            anchors.top: lblName.bottom
            anchors.topMargin: 5
        }
        TextField
        {
            id: txtUsername
            width: 300
            selectByMouse: true
            placeholderText: qsTr("<i>username</i>")

            anchors.horizontalCenter: container1.horizontalCenter
            anchors.top: lblPosition.bottom
            anchors.topMargin: 30

            onPressed: Material.foreground = Material.White
        }
        Label
        {
            id: lblUsernameTaken
            font.pixelSize: 10
            text: qsTr("<i>Username already exists. Try a different one!</i>")
            Material.foreground: Material.Pink
            visible: false

            anchors.left: txtUsername.left
            anchors.top: txtUsername.bottom
        }
        TextField
        {
            id: txtPassword
            width: 300
            selectByMouse: true
            placeholderText: qsTr("<i>password</i>")

            echoMode: TextInput.Password

            anchors.horizontalCenter: container1.horizontalCenter
            anchors.top: lblUsernameTaken.bottom
            anchors.topMargin: 10

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

            anchors.horizontalCenter: container1.horizontalCenter
            anchors.top: txtPassword.bottom

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

        Label
        {
            id: lblPasswordNotMatch
            font.pixelSize: 10
            text: qsTr("<i>Passwords does not match!</i>")
            Material.foreground: Material.Pink
            visible: false
    
            anchors.left: txtPasswordR.left
            anchors.top: txtPasswordR.bottom
        }
        Button
        {
            id: btnNext
            width: 300
            text: "NEXT"
            anchors.horizontalCenter: container1.horizontalCenter
            anchors.top: lblPasswordNotMatch.bottom
            anchors.margins: 5

            onClicked: 
            {
                internal.clearErrors()
                if (txtUsername.text == "" || txtPassword.text == "" || txtPasswordR.text == "")
                {
                    lblMissingFieldsError.visible = true
                }
                else if (txtPassword.text != txtPasswordR.text)
                {
                    lblPasswordNotMatch.visible = true
                    txtPassword.Material.foreground = Material.Pink
                    txtPasswordR.Material.foreground = Material.Pink
                }
                else
                {
                    backend.CheckIfUsernameExists(txtUsername.text)
                }
            }
        }
        Label
        {
            id: lblMissingFieldsError
            font.pixelSize: 10
            text: qsTr("<i>Missing required fields</i>")
            Material.foreground: Material.Pink
            visible: false
    
            anchors.left: btnNext.left
            anchors.top: btnNext.bottom
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
                if (txtUsername.text == "" && txtPassword.text == "" && txtPasswordR.text == "" && comboQ1.currentIndex == -1 && txtA1.text == "" && comboQ2.currentIndex == -1 && txtA2.text == "")
                {
                    backend.PopupFunc("GOTO LOGIN")
                }
                else
                {
                    cancelRegisterAccountPopup.open()
                }
            }
        }

        // Page 2
        Rectangle
        {
            id: container2
            width: parent.width
            color: "transparent"
            anchors.top: parent.top
            anchors.left: container1.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: 0
        }
        Label
        {
            id: lblTitleSecQuestions
            text: qsTr("<b><i>Choose Security Questions...</i></b>")
            font.pixelSize: 20

            anchors.horizontalCenter: container2.horizontalCenter
            anchors.top: container2.top
            anchors.topMargin: 100
        }
        Label
        {
            font.pixelSize: 12
            text: qsTr("<i>In case you forgot you password, this would help us verify that it's you.</i>")
    
            anchors.horizontalCenter: container2.horizontalCenter
            anchors.top: lblTitleSecQuestions.bottom
        }
        Label
        {
            font.pixelSize: 12
            text: qsTr("<i>Question 1</i>")
    
            anchors.left: comboQ1.left
            anchors.bottom: comboQ1.top
        }
        ComboBox
        {
            id: comboQ1
            width: 300
            currentIndex: -1
            displayText: currentIndex === -1 ? "Security Question 1" : currentText
            model: ["In what city were you born?", "What is the name of your favorite pet?", "Where did you meet your spouse?", "What high school did you attend?", "What is the name of your first school?", "What is your favorite food?"]

            anchors.horizontalCenter: container2.horizontalCenter
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
            anchors.top: comboQ1.bottom
            anchors.topMargin: 10
        }
        Label
        {
            font.pixelSize: 12
            text: qsTr("<i>Question 2</i>")
    
            anchors.left: comboQ2.left
            anchors.bottom: comboQ2.top
        }
        ComboBox
        {
            id: comboQ2
            width: 300
            currentIndex: -1
            displayText: currentIndex === -1 ? "Security Question 2" : currentText
            model: ["In what city were you born?", "What is the name of your favorite pet?", "Where did you meet your spouse?", "What high school did you attend?", "What is the name of your first school?", "What is your favorite food?"]

            anchors.horizontalCenter: container2.horizontalCenter
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
            anchors.top: comboQ2.bottom
            anchors.topMargin: 10
        }
        Button
        {
            id: btnRegister
            width: 300
            text: "REGISTER"
            anchors.horizontalCenter: container2.horizontalCenter
            anchors.top: txtA2.bottom
            anchors.topMargin: 40

            onClicked: 
            {
                internal.clearErrors()
                if (comboQ1.currentIndex == -1 || comboQ1.currentIndex == -1 || txtA1.text == "" || txtA2.text == "")
                {
                    lblMissingFieldsError2.text = qsTr("<i>Missing required fields</i>")
                    lblMissingFieldsError2.visible = true
                }
                else if (comboQ1.currentIndex == comboQ2.currentIndex)
                {
                    lblMissingFieldsError2.text = qsTr("<i>Please select two different security questions</i>")
                    lblMissingFieldsError2.visible = true
                }
                else
                {
                    registerAccountPopup.open()
                }
            }
        }
        Label
        {
            id: lblMissingFieldsError2
            font.pixelSize: 10
            text: qsTr("<i>Missing required fields</i>")
            Material.foreground: Material.Pink
            visible: false
    
            anchors.left: btnRegister.left
            anchors.top: btnRegister.bottom
        }
        Button
        {
            id: btnBack
            text: "Back"
            anchors.left: container2.left
            anchors.bottom: container2.bottom
            anchors.margins: 20

            onClicked: animationBack.running = true
        }
    }
    CustomPopup
    {
        id: registerAccountPopup
        popText: "You are about to register a new official account. Continue?"
        popFunc: "OFFICIAL ACCOUNT ADD"
    }
    CustomPopup
    {
        id: cancelRegisterAccountPopup
        popText: "You are about to cancel registration of your account. Continue?"
        popWarningText: "Input data and credentials will be lost"

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "GOTO LOGIN"
        isWarning: true
    }
}