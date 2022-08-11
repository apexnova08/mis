import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
import "../../controls"

Rectangle
{
    id: accountViewer

    width: 700
    color: "#1b222c"

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    property int pk: 0
    property string aUser: ""
    property string aPass: ""
    property string bUser: ""
    property string bPass: ""

    QtObject
    {
        id: internal

        function valuesChanged()
        {
            if (txtAUser.text != aUser || txtAPass.text != aPass || txtBUser.text != bUser || txtBPass.text != bPass)
            {
                return true
            }
            else
            {
                return false
            }
        }
        function cancelRequest()
        {
            if (valuesChanged() == false)
            {
                backend.PopupFunc("ACCOUNT CANCEL EDIT")
            }
            else
            {
                cancelEditAccountPopup.open()
            }
        }
        function editRequest()
        {
            if (valuesChanged() == true)
            {
                editAccountPopup.open()
            }
            else
            {
                lblError.text = qsTr("<i>No changes were made</i>")
                lblError.visible = true
            }
        }
        function clearErrors()
        {
            lblAUser.Material.foreground = Material.White
            lblAPass.Material.foreground = Material.White
            lblBUser.Material.foreground = Material.White
            lblBPass.Material.foreground = Material.White
            lblError.visible = false
        }
        function clearFields()
        {
            clearErrors()
            txtAUser.text = ""
            txtAPass.text = ""
            txtBUser.text = ""
            txtBPass.text = ""
            infoContainer.ScrollBar.vertical.position = 0
        }
    }
    Connections
    {
        target: backend

        function onViewAccountSettings(pk, aUser, aPass, bUser, bPass)
        {
            accountViewer.pk = pk
            accountViewer.aUser = aUser
            accountViewer.aPass = aPass
            accountViewer.bUser = bUser
            accountViewer.bPass = bPass

            txtAUser.text = aUser
            txtAPass.text = aPass
            txtBUser.text = bUser
            txtBPass.text = bPass
        }

        function onEditAccountCancelRequest()
        {
            internal.cancelRequest()
        }
        function onEditAccountRequest()
        {
            editAccountVerifyPass.open()
        }
        function onVerifyPassword(bool, returnStr)
        {
            if (bool == true && returnStr == "ACCOUNT EDIT VERIFY")
            {
                backend.EditAccount(pk, txtAUser.text, txtAPass.text, txtBUser.text, txtBPass.text)
            }
        }
        function onAccountEdited()
        {
            internal.clearFields()
        }
        function onCancelEditAccount()
        {
            internal.clearFields()
        }
    }

    Rectangle
    {
        id: rectTitleBar

        color: "#12171f"
        height: 50

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right

        anchors.margins: 10

        Label
        {
            id: lblTitleBar

            text: qsTr("<b>Account Settings</b>")
            color: "#ffffff"
            font.pixelSize: 17
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
    }

    Rectangle
    {
        id: rectAccountInfo

        color: "#12171f"
        anchors.left: parent.left
        anchors.top: rectTitleBar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.margins: 10

        ScrollView
        {
            id: infoContainer

            anchors.fill: parent
            anchors.bottomMargin: 100
            contentHeight: 330

            Label
            {
                id: lblATitle
                text: qsTr("<b><i>Your Account</i></b>")
                color: "#ffffff"
                font.pixelSize: 17
                
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblAUser
                text: qsTr("Username:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblATitle.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            TextField
            {
                id: txtAUser
                selectByMouse: true
                placeholderText: "username"

                anchors.left: lblAUser.right
                anchors.right: parent.right
                anchors.verticalCenter: lblAUser.verticalCenter
            
                anchors.leftMargin: 20
                anchors.rightMargin: 50
            }
            Label
            {
                id: lblAPass
                text: qsTr("Password:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblAUser.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            TextField
            {
                id: txtAPass
                selectByMouse: true
                placeholderText: "password"

                echoMode: TextInput.Password

                anchors.left: lblAUser.right
                anchors.right: parent.right
                anchors.verticalCenter: lblAPass.verticalCenter
            
                anchors.leftMargin: 20
                anchors.rightMargin: 50
            }
            Rectangle
            {
                id: viewAPass
                color: "#12171f"

                width: 20
                height: 20
                
                anchors.right: txtAPass.right
                anchors.verticalCenter: txtAPass.verticalCenter

                PropertyAnimation {id: animationViewHoverEnterColorA; target: viewAPass; property: "color"; to: "#3c4758"; duration: 500; easing.type: Easing.OutQuint;}
                PropertyAnimation {id: animationViewHoverExitColorA; target: viewAPass; property: "color"; to: "#12171f"; duration: 500; easing.type: Easing.OutQuint;}
                Image
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    source: "../../images/icons/eye.png"
                }
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered:
                    {
                        txtAPass.echoMode = TextInput.Normal
                        animationViewHoverExitColorA.stop()
                        animationViewHoverEnterColorA.running = true
                    }
                    onExited:
                    {
                        txtAPass.echoMode = TextInput.Password
                        animationViewHoverExitColorA.running = true
                    }
                }
            }
            Label
            {
                id: lblBTitle
                text: qsTr("<b><i>General Account</i></b>")
                color: "#ffffff"
                font.pixelSize: 17
                
                anchors.top: lblAPass.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 40
            }
            Label
            {
                id: lblBUser
                text: qsTr("Username:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblBTitle.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            TextField
            {
                id: txtBUser
                selectByMouse: true
                placeholderText: "username"

                anchors.left: lblBUser.right
                anchors.right: parent.right
                anchors.verticalCenter: lblBUser.verticalCenter
            
                anchors.leftMargin: 20
                anchors.rightMargin: 50
            }
            Label
            {
                id: lblBPass
                text: qsTr("Password:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblBUser.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            TextField
            {
                id: txtBPass
                selectByMouse: true
                placeholderText: "password"

                echoMode: TextInput.Password

                anchors.left: lblBUser.right
                anchors.right: parent.right
                anchors.verticalCenter: lblBPass.verticalCenter
            
                anchors.leftMargin: 20
                anchors.rightMargin: 50
            }
            Rectangle
            {
                id: viewBPass
                color: "#12171f"

                width: 20
                height: 20
                
                anchors.right: txtBPass.right
                anchors.verticalCenter: txtBPass.verticalCenter

                PropertyAnimation {id: animationViewHoverEnterColorB; target: viewBPass; property: "color"; to: "#3c4758"; duration: 500; easing.type: Easing.OutQuint;}
                PropertyAnimation {id: animationViewHoverExitColorB; target: viewBPass; property: "color"; to: "#12171f"; duration: 500; easing.type: Easing.OutQuint;}
                Image
                {
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.verticalCenter: parent.verticalCenter
                    source: "../../images/icons/eye.png"
                }
                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true
                    onEntered:
                    {
                        txtBPass.echoMode = TextInput.Normal
                        animationViewHoverExitColorB.stop()
                        animationViewHoverEnterColorB.running = true
                    }
                    onExited:
                    {
                        txtBPass.echoMode = TextInput.Password
                        animationViewHoverExitColorB.running = true
                    }
                }
            }
        }

        // Bottom Controls
        Label
        {
            id: lblError
            font.pixelSize: 10
            text: qsTr("Missing required fields")
            Material.foreground: Material.Pink
            visible: false

            anchors.left: btnEditActivity.left
            anchors.bottom: btnEditActivity.top
        }
        Button
        {
            id: btnEditActivity
            text: "Done"

            anchors.left: parent.left
            anchors.bottom: parent.bottom
            
            anchors.margins: 20

            onClicked:
            {
                internal.clearErrors()
                if (txtAUser.text == "" || txtAPass.text == "" || txtBUser.text == "" || txtBPass.text == "")
                {
                    lblError.text = qsTr("<i>Missing required fields</i>")
                    lblError.visible = true

                    if (txtAUser.text == ""){lblAUser.Material.foreground = Material.Pink}
                    if (txtAPass.text == ""){lblAPass.Material.foreground = Material.Pink}
                    if (txtBUser.text == ""){lblBUser.Material.foreground = Material.Pink}
                    if (txtBPass.text == ""){lblBPass.Material.foreground = Material.Pink}
                }
                else
                {
                    internal.editRequest()
                }
            }
        }
        Button
        {
            id: btnCancel
            text: "Cancel"

            anchors.left: btnEditActivity.right
            anchors.bottom: parent.bottom

            anchors.margins: 20

            onClicked: internal.cancelRequest()
        }
    }
    CustomPopup
    {
        id: editAccountPopup
        popText: "You are about to change your / general account's login credentials. Continue?"
        popFunc: "ACCOUNT EDIT"
    }
    CustomPopup
    {
        id: cancelEditAccountPopup
        popText: "You are about to cancel editing your / general account's login credentials. Continue?"
        popWarningText: "No changes will be made"

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "ACCOUNT CANCEL EDIT"
        isWarning: true
    }
    VerifyPasswordPopup
    {
        id: editAccountVerifyPass
        popText: qsTr("<i>Type in your <b>current password</b> to proceed with this action...</i>")
        popFunc: "ACCOUNT EDIT VERIFY"
    }
}