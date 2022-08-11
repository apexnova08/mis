import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
import "../../controls"

Rectangle
{
    id: printViewer

    width: 700
    color: "#1b222c"

    property string resPK: ""

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    QtObject
    {
        id: internal

        function cancelRequest()
        {
            if (resPK == "" && txtPurpose.text == "")
            {
                backend.PopupFunc("PRINT CANCEL BGYCERTIFICATE")
            }
            else
            {
                cancelPrintPopup.open()
            }
        }
        function clearErrors()
        {
            lblResident.Material.foreground = Material.White
            lblMissingFieldsError.visible = false
        }
        function clearFields()
        {
            clearErrors()

            resPK = ""

            lblResidentVal.text = "<i>Select Resident...</i>"
            lblResidentVal.Material.foreground = Material.Grey
            txtPurpose.text = ""

            infoContainer.ScrollBar.vertical.position = 0
        }
    }

    Connections
    {
        target: backend

        function onPopupResidentTableReturn(typeString, pk, name)
        {
            if (typeString == "PRINT BGYCERTIFICATE")
            {
                lblResidentVal.text = name
                resPK = pk
                lblResidentVal.Material.foreground = Material.Yellow
            }
        }
        function onClosePrintPanelRequest(page)
        {
            if (page == "BGYCERTIFICATE")
            {
                internal.cancelRequest()
            }
        }
        function onPrintDocument(page)
        {
            if (page == "BGYCERTIFICATE")
            {
                backend.PrintBgyCertificate(resPK, txtPurpose.text)
            }
        }
        function onClosePrintPanel(page)
        {
            if (page == "BGYCERTIFICATE")
            {
                internal.clearFields()
            }
        }
    }

    Rectangle
    {
        id: rectTitleBAr

        color: "#12171f"
        height: 50

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right

        anchors.margins: 10

        Label
        {
            id: lblTitleBar

            text: qsTr("<b>Print Barangay Certificate</b>")
            color: "#ffffff"
            font.pixelSize: 17
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
    }
    Rectangle
    {
        id: rectBasicInfo

        color: "#12171f"
        anchors.left: parent.left
        anchors.top: rectTitleBAr.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.margins: 10

        ScrollView
        {
            id: infoContainer

            anchors.fill: parent
            anchors.bottomMargin: 100
            contentHeight: 130
            
            // Name
            Label
            {
                id: lblResident

                text: qsTr("Issue certificate to:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblResidentVal

                text: qsTr("<i>Select Resident...</i>")
                Material.foreground: Material.Grey
                font.pixelSize: 16
            
                anchors.left: lblResident.right
                anchors.right: btnGetResident.left
                anchors.verticalCenter: lblResident.verticalCenter

                anchors.margins: 20
            }
            Button
            {
                id: btnGetResident
                text: "Select Resident"

                anchors.right: parent.right
                anchors.verticalCenter: lblResident.verticalCenter
                anchors.margins: 50

                onClicked: resPopup.open()
            }
            Label
            {
                id: lblPurpose

                text: qsTr("Purpose:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblResident.bottom
                anchors.left: parent.left

                anchors.margins: 20
            }
            TextField
            {
                id: txtPurpose
                selectByMouse: true
                placeholderText: "Purpose (Optional)"

                anchors.left: lblResident.right
                anchors.right: parent.right
                anchors.verticalCenter: lblPurpose.verticalCenter
            
                anchors.leftMargin: 20
                anchors.rightMargin: 50
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

            anchors.left: btnPrint.left
            anchors.bottom: btnPrint.top
        }

        Button
        {
            id: btnPrint
            text: "Done"

            anchors.left: parent.left
            anchors.bottom: parent.bottom
            
            anchors.margins: 20

            onClicked:
            {
                internal.clearErrors()
                if (resPK == "")
                {
                    lblMissingFieldsError.visible = true
                    lblResident.Material.foreground = Material.Pink
                }
                else
                {
                    printPopup.open()
                }
            }
        }
        Button
        {
            id: btnCancel
            text: "Cancel"

            anchors.left: btnPrint.right
            anchors.bottom: parent.bottom

            anchors.margins: 20

            onClicked: internal.cancelRequest()
        }
    }

    CustomPopup
    {
        id: printPopup
        popText: "You are about to print this document. Continue?"
        popFunc: "PRINT BGYCERTIFICATE"
    }
    CustomPopup
    {
        id: cancelPrintPopup
        popText: "You are about to cancel creating this document. Continue?"
        popWarningText: "Input data will be lost"

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "PRINT CANCEL BGYCERTIFICATE"
        isWarning: true
    }

    ResidentTablePopup
    {
        id: resPopup
        typeString: "PRINT BGYCERTIFICATE"
    }
}