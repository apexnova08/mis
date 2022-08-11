import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
import "../../controls"

Rectangle
{
    id: addComplaintViewer

    width: 700
    color: "#1b222c"

    property string comPK: ""
    property string defPK: ""

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    QtObject
    {
        id: internal

        function cancelRequest()
        {
            if (txtComplainant.text == "" && txtDefendant.text == "" && txtTitle.text == "" && txtDetails.text == "")
            {
                backend.PopupFunc("COMPLAINT CANCEL ADD")
            }
            else
            {
                cancelAddComplaintPopup.open()
            }
        }
        function clearErrors()
        {
            lblComplainant.Material.foreground = Material.White
            lblDefendant.Material.foreground = Material.White
            lblTitle.Material.foreground = Material.White
            lblDetails.Material.foreground = Material.White

            lblMissingFieldsError.visible = false
        }
        function clearFields()
        {
            clearErrors()

            comPK = ""
            defPK = ""

            txtComplainant.text = ""
            txtDefendant.text = ""
            txtTitle.text = ""
            txtDetails.text = ""

            infoContainer.ScrollBar.vertical.position = 0

            scrollTitle.ScrollBar.vertical.position = 0
            scrollDetails.ScrollBar.vertical.position = 0
        }
    }

    Connections
    {
        target: backend

        function onPopupResidentTableReturn(typeString, pk, name)
        {
            if (typeString == "COMPLAINT COMPLAINANT")
            {
                txtComplainant.text = name
                comPK = pk
                txtComplainant.Material.foreground = Material.Yellow
            }
            if (typeString == "COMPLAINT DEFENDANT")
            {
                txtDefendant.text = name
                defPK = pk
                txtDefendant.Material.foreground = Material.Yellow
            }
        }
        function onAddComplaintCancelRequest()
        {
            internal.cancelRequest()
        }
        function onAddComplaint()
        {
            backend.AddComplaint(txtComplainant.text, txtDefendant.text, txtTitle.text, txtDetails.text, comPK, defPK)
        }
        function onComplaintAdded()
        {
            internal.clearFields()
        }
        function onCancelAddComplaint()
        {
            internal.clearFields()
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

            text: qsTr("<b>File Complaint</b>")
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
            contentHeight: 410
            
            // Name
            Label
            {
                id: lblComplainant

                text: qsTr("Complainant:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            TextField
            {
                id: txtComplainant
                selectByMouse: true
                placeholderText: "Complainant's name"

                anchors.left: lblComplainant.right
                anchors.right: btnGetComplainant.left
                anchors.verticalCenter: lblComplainant.verticalCenter
            
                anchors.margins: 20

                onTextChanged:
                {
                    txtComplainant.Material.foreground = Material.White
                    comPK = ""
                }
            }
            Button
            {
                id: btnGetComplainant
                text: "Get from Residents"

                anchors.right: parent.right
                anchors.verticalCenter: lblComplainant.verticalCenter
                anchors.margins: 50

                onClicked:
                {
                    resPopup.typeString = "COMPLAINT COMPLAINANT"
                    resPopup.open()
                }
            }
            Label
            {
                id: lblDefendant

                text: qsTr("File Against:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblComplainant.bottom
                anchors.left: parent.left

                anchors.margins: 20
            }
            TextField
            {
                id: txtDefendant
                selectByMouse: true
                placeholderText: "Defendant's name"

                anchors.left: lblComplainant.right
                anchors.right: btnGetDefendant.left
                anchors.verticalCenter: lblDefendant.verticalCenter
            
                anchors.margins: 20

                onTextChanged:
                {
                    txtDefendant.Material.foreground = Material.White
                    defPK = ""
                }
            }
            Button
            {
                id: btnGetDefendant
                text: "Get from Residents"

                anchors.right: parent.right
                anchors.verticalCenter: lblDefendant.verticalCenter
                anchors.margins: 50

                onClicked:
                {
                    resPopup.typeString = "COMPLAINT DEFENDANT"
                    resPopup.open()
                }
            }
            Label
            {
                id: lblTitle

                text: qsTr("Complaint:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblDefendant.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 40
            }
            Rectangle
            {
                id: rectTitle
                color: "#1b222c"

                anchors.left: lblComplainant.right
                anchors.right: parent.right
                anchors.top: lblTitle.top
                height: 80

                anchors.leftMargin: 20
                anchors.rightMargin: 50

                ScrollView
                {
                    id: scrollTitle
                    
                    anchors.fill: parent
                    anchors.margins: 5

                    TextArea
                    {
                        id: txtTitle
                        selectByMouse: true
                        placeholderText: "Complaint"

                        wrapMode: TextArea.WordWrap
                    }
                }
            }
            Label
            {
                id: lblDetails

                text: qsTr("Details:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: rectTitle.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 10
            }
            Rectangle
            {
                id: rectDetails
                color: "#1b222c"

                anchors.left: lblComplainant.right
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

            anchors.left: btnAddComplaint.left
            anchors.bottom: btnAddComplaint.top
        }

        Button
        {
            id: btnAddComplaint
            text: "File Complaint"

            anchors.left: parent.left
            anchors.bottom: parent.bottom
            
            anchors.margins: 20

            onClicked:
            {
                internal.clearErrors()
                if (txtComplainant.text == "" || txtDefendant.text == "" || txtTitle.text == "" || txtDetails.text == "")
                {
                    lblMissingFieldsError.visible = true
                    if (txtComplainant.text == ""){lblComplainant.Material.foreground = Material.Pink}
                    if (txtDefendant.text == ""){lblDefendant.Material.foreground = Material.Pink}
                    if (txtTitle.text == ""){lblTitle.Material.foreground = Material.Pink}
                    if (txtDetails.text == ""){lblDetails.Material.foreground = Material.Pink}
                }
                else
                {
                    addComplaintPopup.open()
                }
            }
        }
        Button
        {
            id: btnCancel
            text: "Cancel"

            anchors.left: btnAddComplaint.right
            anchors.bottom: parent.bottom

            anchors.margins: 20

            onClicked: internal.cancelRequest()
        }
    }

    CustomPopup
    {
        id: addComplaintPopup
        popText: "File this complaint?"
        popFunc: "COMPLAINT ADD"
    }
    CustomPopup
    {
        id: cancelAddComplaintPopup
        popText: "You are about to cancel filing complaint. Continue?"
        popWarningText: "Input data will be lost"

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "COMPLAINT CANCEL ADD"
        isWarning: true
    }
    ResidentTablePopup
    {
        id: resPopup
    }
}