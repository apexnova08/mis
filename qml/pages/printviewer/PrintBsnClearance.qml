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
            if (txtResident.text == "" && txtAddress.text == "" && txtBusiness.text == "" && txtBusinessAddress.text == "")
            {
                backend.PopupFunc("PRINT CANCEL BSNCLEARANCE")
            }
            else
            {
                cancelPrintPopup.open()
            }
        }
        function clearErrors()
        {
            lblResident.Material.foreground = Material.White
            txtAddress.Material.foreground = Material.White
            txtBusiness.Material.foreground = Material.White
            txtBusinessAddress.Material.foreground = Material.White
            
            lblMissingFieldsError.visible = false
        }
        function clearFields()
        {
            clearErrors()

            resPK = ""

            txtResident.text = ""
            txtResident.Material.foreground = Material.White
            txtAddress.text = ""
            txtAddress.Material.foreground = Material.White

            txtBusiness.text = ""
            txtBusinessAddress.text = ""

            infoContainer.ScrollBar.vertical.position = 0
        }
    }

    Connections
    {
        target: backend

        function onPopupResidentTableReturn(typeString, pk, name)
        {
            if (typeString == "PRINT BSNCLEARANCE")
            {
                txtResident.text = name
                resPK = pk

                backend.GetResidentAddress(pk, typeString)
            }
        }
        function onGetResidentAddress(pk, address, typeString)
        {
            if (typeString == "PRINT BSNCLEARANCE")
            {
                txtAddress.text = address
                txtAddress.Material.foreground = Material.Yellow
                txtResident.Material.foreground = Material.Yellow
            }
        }
        function onClosePrintPanelRequest(page)
        {
            if (page == "BSNCLEARANCE")
            {
                internal.cancelRequest()
            }
        }
        function onPrintDocument(page)
        {
            if (page == "BSNCLEARANCE")
            {
                backend.PrintBsnClearance(txtResident.text, txtAddress.text, txtBusiness.text, txtBusinessAddress.text)
            }
        }
        function onClosePrintPanel(page)
        {
            if (page == "BSNCLEARANCE")
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

            text: qsTr("<b>Print Business Clearance</b>")
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
                id: lblResidentTitle

                text: qsTr("<b>Business Owner</b>")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            Label
            {
                id: lblResident

                text: qsTr("Issue clearance to:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblResidentTitle.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            TextField
            {
                id: txtResident
                selectByMouse: true
                Material.foreground: Material.White
                placeholderText: "Owner's Name"

                anchors.left: lblResident.right
                anchors.right: btnGetResident.left
                anchors.verticalCenter: lblResident.verticalCenter
            
                anchors.margins: 20

                onTextChanged:
                {
                    txtResident.Material.foreground = Material.White
                    txtAddress.Material.foreground = Material.White
                    resPK = ""
                }
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
                id: lblAddress

                text: qsTr("Address:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblResident.bottom
                anchors.left: parent.left

                anchors.margins: 20
            }
            TextField
            {
                id: txtAddress
                selectByMouse: true
                placeholderText: "Address"

                anchors.left: lblResident.right
                anchors.right: parent.right
                anchors.verticalCenter: lblAddress.verticalCenter
            
                anchors.leftMargin: 20
                anchors.rightMargin: 50

                onTextChanged:
                {
                    txtResident.Material.foreground = Material.White
                    txtAddress.Material.foreground = Material.White
                    resPK = ""
                }
            }

            Label
            {
                id: lblBusinessTitle

                text: qsTr("<b>Business</b>")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblAddress.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 40
            }
            Label
            {
                id: lblBusiness

                text: qsTr("Business Name:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblBusinessTitle.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            TextField
            {
                id: txtBusiness
                selectByMouse: true
                placeholderText: "Business Name"

                anchors.left: lblResident.right
                anchors.right: parent.right
                anchors.verticalCenter: lblBusiness.verticalCenter
            
                anchors.leftMargin: 20
                anchors.rightMargin: 50
            }
            Label
            {
                id: lblBusinessAddress

                text: qsTr("Business Address:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblBusiness.bottom
                anchors.left: parent.left

                anchors.margins: 20
            }
            TextField
            {
                id: txtBusinessAddress

                selectByMouse: true
                placeholderText: "Business Address"

                anchors.left: lblResident.right
                anchors.right: parent.right
                anchors.verticalCenter: lblBusinessAddress.verticalCenter
            
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
                if (txtResident.text == "" || txtAddress.text == "" || txtBusiness.text == "" || txtBusinessAddress.text == "")
                {
                    lblMissingFieldsError.visible = true

                    if (txtResident.text == ""){lblResident.Material.foreground = Material.Pink}
                    if (txtAddress.text == ""){lblAddress.Material.foreground = Material.Pink}
                    if (txtBusiness.text == ""){lblBusiness.Material.foreground = Material.Pink}
                    if (txtBusinessAddress.text == ""){lblBusinessAddress.Material.foreground = Material.Pink}
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
        popFunc: "PRINT BSNCLEARANCE"
    }
    CustomPopup
    {
        id: cancelPrintPopup
        popText: "You are about to cancel creating this document. Continue?"
        popWarningText: "Input data will be lost"

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "PRINT CANCEL BSNCLEARANCE"
        isWarning: true
    }

    ResidentTablePopup
    {
        id: resPopup
        typeString: "PRINT BSNCLEARANCE"
    }
}