import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
import "../../controls"

Rectangle
{
    id: viewer

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

    QtObject
    {
        id: internal

        function valuesChanged()
        {
            if (txtDetails.text == details && (comboMeet1.enabled == false || comboMeet1.currentIndex == -1) && (comboMeet2.enabled == false || comboMeet2.currentIndex == -1) && (comboMeet3.enabled == false || comboMeet3.currentIndex == -1))
            {
                return false
            }
            else
            {
                return true
            }
        }
        function cancelRequest()
        {
            if (valuesChanged() == false)
            {
                backend.PopupFunc("COMPLAINT CANCEL EDIT")
            }
            else
            {
                cancelEditComplaintPopup.open()
            }
        }
        function editRequest()
        {
            clearErrors()
            if (valuesChanged() == false)
            {
                lblMissingFieldsError.text = "No changes were made"
                lblMissingFieldsError.visible = true
            }
            else
            {
                if (comboMeet1.currentIndex > 0 || comboMeet2.currentIndex > 0 || comboMeet3.currentIndex >= 0)
                {
                    closeEditComplaintPopup.open()
                }
                else
                {
                    editComplaintPopup.open()
                }
            }
        }
        function clearErrors()
        {
            lblDetails.Material.foreground = Material.White

            lblMissingFieldsError.text = "Missing required fields"
            lblMissingFieldsError.visible = false
        }
        function clearFields()
        {
            clearErrors()

            txtDetails.text = ""

            comboMeet1.currentIndex = -1
            comboMeet2.currentIndex = -1
            comboMeet3.currentIndex = -1

            comboMeet1.enabled = true
            comboMeet2.enabled = true
            comboMeet3.enabled = true

            infoContainer.ScrollBar.vertical.position = 0

            scrollDetails.ScrollBar.vertical.position = 0
        }
    }
    Connections
    {
        target: backend
        function onOpenEditComplaint(pk, complainant, defendant, dateFiled, meet1, meet1Date, meet2, meet2Date, meet3, meet3Date, status, title, details)
        {
            viewer.pk = pk
            viewer.complainant = complainant
            viewer.defendant = defendant
            viewer.dateFiled = dateFiled
            viewer.meet1 = meet1
            viewer.meet1Date = meet1Date
            viewer.meet2 = meet2
            viewer.meet2Date = meet2Date
            viewer.meet3 = meet3
            viewer.meet3Date = meet3Date
            viewer.status = status
            viewer.title = title
            viewer.details = details

            infoContainer.ScrollBar.vertical.position = 0
            infoContainer.contentHeight = lblTitleVal.height + 660

            txtDetails.text = details

            if (meet1 == "")
            {
                comboMeet2.enabled = false
                comboMeet3.enabled = false
            }
            if (meet1 != "" && meet2 == "")
            {
                comboMeet1.currentIndex = 0
                comboMeet1.enabled = false
                comboMeet3.enabled = false
            }
            if (meet2 != "" && meet3 == "")
            {
                comboMeet1.currentIndex = 0
                comboMeet2.currentIndex = 0
                comboMeet1.enabled = false
                comboMeet2.enabled = false
            }
        }
        function onEditComplaintCancelRequest()
        {
            internal.cancelRequest()
        }
        function onEditComplaint()
        {
            let strUpdateDetails = ""
            let meet = ""
            let meetVal = ""

            if (txtDetails.text != details)
            {
                strUpdateDetails = " comDetails = '" + txtDetails.text + "',"
            }
            if (comboMeet1.enabled == true && comboMeet1.currentIndex != -1)
            {
                meet = "comMeet1"
                meetVal = comboMeet1.currentValue
            }
            if (comboMeet2.enabled == true && comboMeet2.currentIndex != -1)
            {
                meet = "comMeet2"
                meetVal = comboMeet2.currentValue
            }
            if (comboMeet3.enabled == true && comboMeet3.currentIndex != -1)
            {
                meet = "comMeet3"
                meetVal = comboMeet3.currentValue
            }

            backend.EditComplaint(pk, strUpdateDetails, meet, meetVal)
        }
        function onComplaintEdited()
        {
            internal.clearFields()
        }
        function onCancelEditComplaint()
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

            text: qsTr("<b>Update Barangay Complaint</b>")
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
            contentHeight: lblTitleVal.height + 640

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
            
                anchors.top: lblDate.top
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
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
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblTitleVal.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 10
            }
            Rectangle
            {
                id: rectDetails
                color: "#1b222c"

                anchors.left: lblDetails.right
                anchors.right: parent.right
                anchors.top: lblDetails.top
                height: 200

                anchors.leftMargin: 20
                anchors.rightMargin: 50

                ScrollView
                {
                    id: scrollDetails
                    
                    anchors.fill: parent
                    anchors.margins: 5

                    TextArea
                    {
                        id: txtDetails
                        selectByMouse: true
                        placeholderText: "Complaint Details"

                        wrapMode: TextArea.WordWrap
                    }
                }
            }

            // Meeting 1
            Label
            {
                id: lblHearing1

                text: qsTr("<b>First Hearing</b>")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: rectDetails.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            ComboBox
            {
                id: comboMeet1
                currentIndex: -1
                displayText: currentIndex === -1 ? "Result" : currentText
                model: ["Unsettled", "Settled"]

                anchors.left: parent.left
                anchors.top: lblHearing1.bottom
                width: 200

                anchors.leftMargin: 20
                anchors.topMargin: 5
            }
            Label
            {
                id: lblMeet1Date

                text: qsTr("<i>" + meet1Date + "</i>")
                color: "#8f8f8f"
            
                anchors.verticalCenter: comboMeet1.verticalCenter
                anchors.left: comboMeet1.right
                anchors.margins: 20
            }

            // Meeting 2
            Label
            {
                id: lblHearing2

                text: qsTr("<b>Second Hearing</b>")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: comboMeet1.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            ComboBox
            {
                id: comboMeet2
                currentIndex: -1
                displayText: currentIndex === -1 ? "Result" : currentText
                model: ["Unsettled", "Settled"]

                anchors.left: parent.left
                anchors.top: lblHearing2.bottom
                width: 200

                anchors.leftMargin: 20
                anchors.topMargin: 5
            }
            Label
            {
                id: lblMeet2Date

                text: qsTr("<i>" + meet2Date + "</i>")
                color: "#8f8f8f"
            
                anchors.verticalCenter: comboMeet2.verticalCenter
                anchors.left: comboMeet2.right
                anchors.margins: 20
            }

            // Meeting 3
            Label
            {
                id: lblHearing3

                text: qsTr("<b>Third Hearing</b>")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: comboMeet2.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            ComboBox
            {
                id: comboMeet3
                currentIndex: -1
                displayText: currentIndex === -1 ? "Result" : currentText
                model: ["Settled", "Filed for action"]

                anchors.left: parent.left
                anchors.top: lblHearing3.bottom
                width: 200

                anchors.leftMargin: 20
                anchors.topMargin: 5
            }
            Label
            {
                id: lblMeet3Date

                text: qsTr("<i>" + meet3Date + "</i>")
                color: "#8f8f8f"
            
                anchors.verticalCenter: comboMeet3.verticalCenter
                anchors.left: comboMeet3.right
                anchors.margins: 20
            }
        }

        // Bottom Controls
        Label
        {
            id: lblMissingFieldsError
            font.italic: true
            font.pixelSize: 10
            text: "Missing required fields"
            Material.foreground: Material.Pink
            visible: false

            anchors.left: btnEditComplaint.left
            anchors.bottom: btnEditComplaint.top
        }
        Button
        {
            id: btnEditComplaint
            text: "Save Changes"

            anchors.left: parent.left
            anchors.bottom: parent.bottom
            
            anchors.margins: 20

            onClicked:
            {
                internal.clearErrors()
                if (txtDetails.text == "")
                {
                    lblMissingFieldsError.visible = true
                    lblDetails.Material.foreground = Material.Pink
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

            anchors.left: btnEditComplaint.right
            anchors.bottom: parent.bottom

            anchors.margins: 20

            onClicked: internal.cancelRequest()
        }
    }

    CustomPopup
    {
        id: editComplaintPopup
        popText: "You are about to update this complaint's data. Continue?"
        popFunc: "COMPLAINT EDIT"
    }
    CustomPopup
    {
        id: closeEditComplaintPopup
        popText: "Marking 'Settled' or 'Filed for action' will close this complaint record. Continue?"
        popWarningText: "Its contents will be <b>UNAVAILABLE FOR UPDATE</b> in the future."

        popFunc: "COMPLAINT EDIT"
        isNote: true
    }
    CustomPopup
    {
        id: cancelEditComplaintPopup
        popText: "You are about to cancel updating this complaint's data. Continue?"
        popWarningText: "No changes will be made"

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "COMPLAINT CANCEL EDIT"
        isWarning: true
    }
}