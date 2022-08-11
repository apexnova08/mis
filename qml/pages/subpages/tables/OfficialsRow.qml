import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
import "../../../controls"

Rectangle
{
    id: row

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    property int pk: 0
    property int resPK: 0
    property string nameText: "<i> -- empty -- </i>"
    property string positionText: ""
    property bool isMe: false
    property url imgSource: "../../../../mis/pfp/default.png"

    property int tempPK: 0
    property string tempName: ""

    height: 80
    color: "#12171f"

    Component.onCompleted:
    {
        if (isMe == true)
        {
            txtRemarks.text = "<b><i>Me</i><b>"
            txtRemarks.visible = true
        }
        if (nameText == "<i> -- empty -- </i>")
        {
            txtName.color = "#cf1e60"
            txtRemarks.text = "<i>Click to Elect</i>"
            txtRemarks.visible = true
        }
    }
    QtObject
    {
        id: internal
    }
    Connections
    {
        target: backend

        function onDestroyOfficialTable()
        {
            pk = 0
            resPK = 0
            imgSource = "../../../../mis/pfp/default.png"
            nameText = "<i> -- empty -- </i>"
            btnDismiss.visible = false
            isMe: false

            tempPK: 0
            tempName: ""
        }
        function onPopupResidentTableReturn(typeString, pk, name)
        {
            if (typeString == "OFFICIAL " + positionText)
            {
                tempPK = pk
                tempName = name

                backend.GetOfficialPosition(pk, positionText)
            }
        }
        function onGetOfficialPosition(position, eString)
        {
            if (position == "None" && eString == positionText)
            {
                addOfficialPopup.popText = "You are about to elect <b>" + tempName + "</b> as <b>" + positionText + "</b>. Continue?"
                addOfficialPopup.open()
            }
            if (position != "None" && eString == positionText)
            {
                alreadyHasPositionPopup.popText = "Selected official is <b>already elected as <i>" + position + "</i></b>. Dismiss them from their active position first before electing them to <b>" + positionText + "</b>."
                alreadyHasPositionPopup.open()
            }
        }
        function onAddOfficial(position)
        {
            if (position == "OFFICIAL ADD " + positionText)
            {
                if (positionText == "<i>Barangay Chairman</i>" || positionText == "<i>Barangay Secretary</i>")
                {
                    createAccountPopup.popText = "<b><i>Barangay Chairman</i></b> and <b><i>Barangay Secretary</i></b> needs to <b>have their own account created</b> for more secure data management. Continue?"
                    createAccountPopup.popFunc = "OFFICIAL CREATE ACCOUNT NO " + tempPK + " " + positionText

                    createAccountPopup.open()
                }
                else
                {
                    backend.ElectOfficial(tempPK, positionText, tempName)
                }
            }
        }
        function onOfficialHasAccount(bool, eString, pk, name)
        {
            if (bool == true && eString == positionText)
            {
                backend.ElectOfficial(pk, eString)
            }
            if (bool == false && eString == positionText)
            {
                createAccountPopup.popText = "No user account detected for " + name + ". <b>Create a new one</b>?"
                createAccountPopup.popFunc = "OFFICIAL CREATE ACCOUNT " + pk + " " + eString

                createAccountPopup.open()
            }
        }
        function onEditOfficials()
        {
            if (txtRemarks.visible == false)
            {
                btnDismiss.visible = true
            }
        }
        function onOfficialDismissRequest(returnStr)
        {
            if (returnStr == "OFFICIAL DISMISS REQUEST " + positionText)
            {
                dismissVerifyPass.open()
            }
        }
        function onCancelEditOfficials()
        {
            btnDismiss.visible = false
        }
        function onVerifyPassword(bool, returnStr)
        {
            if (bool == true && returnStr == "OFFICIAL DISMISS " + positionText)
            {
                backend.DismissOfficial(resPK, positionText)
            }
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
        to: "#12171f"
        duration: 500
        easing.type: Easing.OutQuint
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
            if (resPK == 0)
            {
                resPopup.typeString = "OFFICIAL " + positionText
                resPopup.open()
            }
            else
            {
                backend.GetResident(resPK)
            }
        }
    }

    Rectangle
    {
        color: "#191d26"
        
        anchors.fill: parent
        anchors.margins: 2

        Rectangle
        {
            id: rectPFP
            color: "#12171f"

            width: 72
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.margins: 2

            PropertyAnimation
            {
                id: animationPFPHoverEnterColor
                target: rectPFP
                property: "color"
                to: "#3c4758"
                duration: 500
                easing.type: Easing.OutQuint
            }
            PropertyAnimation
            {
                id: animationPFPHoverExitColor
                target: rectPFP
                property: "color"
                to: "#12171f"
                duration: 500
                easing.type: Easing.OutQuint
            }
            MouseArea
            {
                hoverEnabled: true
                anchors.fill: parent
                onEntered:
                {
                    if (resPK != 0)
                    {
                        animationPFPHoverExitColor.stop()
                        animationPFPHoverEnterColor.running = true
                    }
                }
                onExited:
                {
                    if (resPK != 0)
                    {
                        animationPFPHoverExitColor.running = true
                    }
                }
                onClicked:
                {
                    if (resPK != 0)
                    {
                        backend.ChangePFP(resPK)
                    }
                }
            }
            Image
            {
                id: imgPFP
                anchors.fill: parent
                anchors.margins: 2
                source: imgSource
            }
        }

        Label
        {
            id: txtName
            text: qsTr(nameText)
            color: "#ffffff"
            font.pixelSize: 16

            anchors.left: rectPFP.right
            anchors.top: parent.top
            
            anchors.margins: 20

            onTextChanged:
            {
                if (txtName.text == "<i> -- empty -- </i>")
                {
                    txtName.color = "#cf1e60"
                    txtRemarks.text = "<i>Click to Elect</i>"
                    txtRemarks.visible = true
                }
                else
                {
                    txtName.color = "#ffffff"
                    txtRemarks.text = "<b><i>Me</i><b>"
                    
                    if (loggedInResPK == resPK)
                    {
                        txtRemarks.visible = true
                    }
                    else
                    {
                        txtRemarks.visible = false
                    }
                }
            }
        }
        Label
        {
            id: txtPosition
            text: qsTr(positionText)
            color: "#ffffff"
            
            anchors.top: txtName.bottom
            anchors.left: rectPFP.right
            anchors.leftMargin: 20
        }
        Label
        {
            id: txtRemarks
            text: qsTr("<b><i>Me</i><b>")
            color: "#ffffff"
            visible: false
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 30
        }
        Button
        {
            id: btnDismiss
            text: "Dismiss"
            visible: false

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 20

            onClicked: dismissOfficial.open()
        }
    }
    CustomPopup
    {
        id: addOfficialPopup
        popFunc: "OFFICIAL ADD " + positionText
    }
    CustomPopup
    {
        id: dismissOfficial
        popText: "You are about to dismiss <b><i>" + nameText + "</i></b> from the Barangay. Continue?"
        popWarningText: "<b><i>" + nameText + "</i></b> will <b>LOSE</b> their access to the <b>ENTIRE SYSTEM</b>."

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "OFFICIAL DISMISS REQUEST " + positionText
        isWarning: true
    }
    VerifyPasswordPopup
    {
        id: dismissVerifyPass
        popFunc: "OFFICIAL DISMISS " + positionText
    }
    ResidentTablePopup
    {
        id: resPopup
    }
    ErrorPopup
    {
        id: alreadyHasPositionPopup
    }
    CustomPopup
    {
        id: createAccountPopup
        popWarningText: "This action will log you out of the application"

        popOKButtonText: "CREATE"
        isNote: true
    }
}