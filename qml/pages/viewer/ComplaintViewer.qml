import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
import "../../controls"

Rectangle
{
    id: complainantViewer

    width: 700
    color: "#1b222c"

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    property int pk: 0
    property string complainant: ""
    property string defendant: ""
    property string dateFiled: ""
    property string meet1: ""
    property string meet1Date: ""
    property string meet2: ""
    property string meet2Date: ""
    property string meet3: ""
    property string meet3Date: ""
    property string status: ""
    property string title: ""
    property string details: ""

    property string comPK: ""
    property string defPK: ""

    Connections
    {
        target: backend
        
        function onGetComplaint(pk, complainant, defendant, dateFiled, meet1, meet1Date, meet2, meet2Date, meet3, meet3Date, status, title, details, comPK, defPK)
        {
            complainantViewer.pk = pk
            complainantViewer.complainant = complainant
            complainantViewer.defendant = defendant
            complainantViewer.dateFiled = dateFiled
            complainantViewer.meet1 = meet1
            complainantViewer.meet1Date = meet1Date
            complainantViewer.meet2 = meet2
            complainantViewer.meet2Date = meet2Date
            complainantViewer.meet3 = meet3
            complainantViewer.meet3Date = meet3Date
            complainantViewer.status = status
            complainantViewer.title = title
            complainantViewer.details = details

            complainantViewer.comPK = comPK
            complainantViewer.defPK = defPK

            if (status != "Unsettled")
            {
                btnEdit.enabled = false
                lblClosed.visible = true
            }
            else if (loggedInPK == 0)
            {
                btnEdit.enabled = false
                lblClosed.visible = false
            }
            else
            {
                btnEdit.enabled = true
                lblClosed.visible = false
            }

            if (comPK != "")
            {
                lblComplainantVal.color = "#ffffaa"
            }
            else
            {
                lblComplainantVal.color = "#ffffff"
            }
            if (defPK != "")
            {
                lblDefendantVal.color = "#ffffaa"
            }
            else
            {
                lblDefendantVal.color = "#ffffff"
            }

            infoContainer.ScrollBar.vertical.position = 0
            infoContainer.contentHeight = lblTitleVal.height + lblDetailsVal.height + 420
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
            id: lblStatusBar

            text: qsTr("<b>Barangay Complaint</b>")
            color: "#ffffff"
            font.pixelSize: 17
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
    }
    Rectangle
    {
        id: rectComplaintInfo

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
            contentHeight: lblTitleVal.height + lblDetailsVal.height + 420

            // Name
            Label
            {
                id: lblComplainant

                text: qsTr("Complainant:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblComplainantVal

                text: qsTr(complainant)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblComplainant.verticalCenter
                anchors.left: lblComplainant.right
                anchors.margins: 20

                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: if (comPK != ""){lblComplainantVal.font.underline = true}
                    onExited: lblComplainantVal.font.underline = false
                    
                    onClicked: if (comPK != ""){backend.ViewResidentFromComplaint(comPK)}
                }
            }
            Label
            {
                id: lblDefendant

                text: qsTr("Defendant:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblComplainant.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblDefendantVal

                text: qsTr(defendant)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblDefendant.verticalCenter
                anchors.left: lblComplainant.right
                anchors.margins: 20

                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: if (defPK != ""){lblDefendantVal.font.underline = true}
                    onExited: lblDefendantVal.font.underline = false
                    
                    onClicked: if (defPK != ""){backend.ViewResidentFromComplaint(defPK)}
                }
            }
            Label
            {
                id: lblDate

                text: qsTr("Date Filed:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblDefendant.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblDateVal

                text: qsTr(dateFiled)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblDate.verticalCenter
                anchors.left: lblComplainant.right
                anchors.margins: 20
            }
            Label
            {
                id: lblStatus

                text: qsTr("Status:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblDate.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 10
            }
            Label
            {
                id: lblStatusVal

                text: qsTr("<b>" + status + "</b>")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblStatus.verticalCenter
                anchors.left: lblComplainant.right
                anchors.margins: 20
            }

            // Complaint Details
            Label
            {
                id: lblTitle

                text: qsTr("Complaint:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblStatus.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblTitleVal

                text: qsTr("<b>" + title + "</b>")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblTitle.top
                anchors.left: lblTitle.right
                anchors.right: parent.right
                anchors.leftMargin: 20
                anchors.rightMargin: 20

                wrapMode: Label.WordWrap
            }
            Label
            {
                id: lblDetails

                text: qsTr("Details:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblTitleVal.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 10

                wrapMode: Label.WordWrap
            }
            Label
            {
                id: lblDetailsVal

                text: qsTr(details)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblDetails.top
                anchors.left: lblDetails.right
                anchors.right: parent.right
                anchors.leftMargin: 20
                anchors.rightMargin: 20

                wrapMode: Label.WordWrap
            }

            // Meeting 1
            Label
            {
                id: lblHearing1

                text: qsTr("<b>First Hearing</b>")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblDetailsVal.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblMeet1Date

                text: qsTr("Date:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblHearing1.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 5
            }
            Label
            {
                id: lblMeet1DateVal

                text: qsTr(meet1Date)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblMeet1Date.verticalCenter
                anchors.left: lblTitle.right
                anchors.margins: 20
            }
            Label
            {
                id: lblMeet1

                text: qsTr("Result:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblMeet1Date.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblMeet1Val

                text: qsTr(meet1)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblMeet1.verticalCenter
                anchors.left: lblTitle.right
                anchors.margins: 20
            }

            // Meeting 2
            Label
            {
                id: lblHearing2

                text: qsTr("<b>Second Hearing</b>")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblMeet1.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblMeet2Date

                text: qsTr("Date:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblHearing2.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 5
            }
            Label
            {
                id: lblMeet2DateVal

                text: qsTr(meet2Date)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblMeet2Date.verticalCenter
                anchors.left: lblTitle.right
                anchors.margins: 20
            }
            Label
            {
                id: lblMeet2

                text: qsTr("Result:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblMeet2Date.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblMeet2Val

                text: qsTr(meet2)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblMeet2.verticalCenter
                anchors.left: lblTitle.right
                anchors.margins: 20
            }

            // Meeting 3
            Label
            {
                id: lblHearing3

                text: qsTr("<b>Third Hearing</b>")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblMeet2.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblMeet3Date

                text: qsTr("Date:     ")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.top: lblHearing3.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 5
            }
            Label
            {
                id: lblMeet3DateVal

                text: qsTr(meet3Date)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblMeet3Date.verticalCenter
                anchors.left: lblTitle.right
                anchors.margins: 20
            }
            Label
            {
                id: lblMeet3

                text: qsTr("Result:     ")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.top: lblMeet3Date.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblMeet3Val

                text: qsTr(meet3)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblMeet3.verticalCenter
                anchors.left: lblTitle.right
                anchors.margins: 20
            }
        }

        // Bottom Controls
        Button
        {
            id: btnBack
            text: "Back"

            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.margins: 20

            onClicked: backend.CloseComplaintViewer()
        }
        Button
        {
            id: btnEdit
            text: "Update Case"

            anchors.left: btnBack.right
            anchors.bottom: parent.bottom
            anchors.margins: 20

            onClicked: backend.OpenEditComplaintPanel(pk)
        }
        Label
        {
            id: lblClosed

            text: qsTr("<i>Closed complaints cannot be updated</i>")
            color: "#8f8f8f"
            visible: false
            
            anchors.verticalCenter: btnEdit.verticalCenter
            anchors.left: btnEdit.right
            anchors.margins: 20
        }
    }
}