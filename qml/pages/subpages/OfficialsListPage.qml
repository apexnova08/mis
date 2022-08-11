import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "tables"
import "../../controls"

Rectangle
{
    id: rectangle
    anchors.fill: parent
    color: "#12151c"

    property int tempPK: 0
    property string tempName: ""

    clip: true

    Connections
    {
        target: backend

        function onDestroyOfficialTable()
        {
            btnEditOfficials.text = "Dismiss Official(s)"
        }
        function onTurnOverRequest()
        {
            turnOverVerifyPass.open()
        }
        function onVerifyPassword(bool, returnStr)
        {
            if (bool == true && returnStr == "TURNOVER SYSTEM VERIFY")
            {
                resPopup.open()
            }
        }
        function onPopupResidentTableReturn(typeString, pk, name)
        {
            if (typeString == "TURNOVER SYSTEM CHOOSE")
            {
                tempPK = pk
                tempName = name

                createAccountPopup.popText = "Turning over the system will trigger <b>account creation</b> for the new <b><i>Barangay Chairman</i></b>. Continue?"
                createAccountPopup.popFunc = "OFFICIAL CREATE ACCOUNT YES " + pk + " <i>Barangay Chairman</i>"

                createAccountPopup.open()
            }
        }
    }
    SequentialAnimation
    {
        id: animationOfficialsActive
        PropertyAnimation {target: otable; property: "anchors.rightMargin"; to: -rectangle.width; duration: 500; easing.type: Easing.OutQuint}
        ParallelAnimation
        {
            PropertyAnimation {target: otable; property: "anchors.right"; to: rectangle.right; duration: 0; easing.type: Easing.OutQuint}
            PropertyAnimation {target: otable; property: "anchors.rightMargin"; to: 0; duration: 0; easing.type: Easing.OutQuint}
        }
    }
    SequentialAnimation
    {
        id: animationArchivedActive
        PropertyAnimation {target: otable; property: "anchors.rightMargin"; to: rectangle.width; duration: 500; easing.type: Easing.OutQuint}
        ParallelAnimation
        {
            PropertyAnimation {target: otable; property: "anchors.right"; to: rectangle.left; duration: 0; easing.type: Easing.OutQuint}
            PropertyAnimation {target: otable; property: "anchors.rightMargin"; to: 0; duration: 0; easing.type: Easing.OutQuint}
        }
    }

    OfficialsTable
    {
        id: otable
        width: parent.width
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: btnTurnOver.top
        anchors.bottomMargin: 20
        anchors.rightMargin: 0
    }
    ArchivedOfficialsTable
    {
        id: atable
        width: parent.width
        anchors.left: otable.right
        anchors.top: parent.top
        anchors.bottom: btnBackToOfficials.top
        anchors.bottomMargin: 20
    }

    Button
    {
        id: btnTurnOver
        text: "Turn over system"

        anchors.left: otable.left
        anchors.bottom: parent.bottom

        onClicked:
        {
            turnOverPopup.open()
            backend.CancelEditOfficials()
            btnEditOfficials.text = "Dismiss Official(s)"
        }
    }
    Button
    {
        id: btnEditOfficials
        text: "Dismiss Official(s)"

        anchors.left: btnTurnOver.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: 20

        onClicked:
        {
            if (btnEditOfficials.text == "Dismiss Official(s)")
            {
                backend.EditOfficials()
                btnEditOfficials.text = "Done"
            }
            else
            {
                backend.CancelEditOfficials()
                btnEditOfficials.text = "Dismiss Official(s)"
            }
        }
    }
    Button
    {
        id: btnViewArchived
        text: "View Past Officials"

        anchors.right: otable.right
        anchors.bottom: parent.bottom

        onClicked: 
        {
            animationArchivedActive.running = true
            backend.CancelEditOfficials()
            btnEditOfficials.text = "Dismiss Official(s)"
        }
    }
    Button
    {
        id: btnBackToOfficials
        text: "View Active Officials"

        anchors.right: atable.right
        anchors.bottom: parent.bottom

        onClicked: animationOfficialsActive.running = true
    }
    CustomPopup
    {
        id: turnOverPopup
        popText: "You are about to <b>elect a new Barangay Chairman</b> and turn over this system to them. This action will <b>DISMISS ALL OFFICIALS</b> from their positions. This action is only recommended to use after barangay elections. Continue?"
        popWarningText: "You and all the barangay officials will <b>LOSE</b> access to the <b>ENTIRE SYSTEM</b>."

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popOKButtonText: "TURN OVER"
        popFunc: "TURNOVER SYSTEM REQUEST"
        isWarning: true
    }
    VerifyPasswordPopup
    {
        id: turnOverVerifyPass
        popFunc: "TURNOVER SYSTEM VERIFY"
    }
    ResidentTablePopup
    {
        id: resPopup

        typeString: "TURNOVER SYSTEM CHOOSE"
    }
    CustomPopup
    {
        id: createAccountPopup
        popWarningText: "This action will log you out of the application"

        popOKButtonText: "CREATE"
        isNote: true
    }
}