import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
import "../../controls"

Rectangle
{
    id: addBlotterViewer

    width: 700
    color: "#1b222c"

    property string resPK: ""
    property string subPK: ""

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    QtObject
    {
        id: internal

        function cancelRequest()
        {
            if (txtSuspect.text == "" && txtSubmitter.text == "" && txtTitle.text == "" && txtDetails.text == "")
            {
                backend.PopupFunc("BLOTTER CANCEL ADD")
            }
            else
            {
                cancelAddBlotterPopup.open()
            }
        }
        function clearErrors()
        {
            lblSuspect.Material.foreground = Material.White
            lblSubmitter.Material.foreground = Material.White
            lblTitle.Material.foreground = Material.White
            lblDetails.Material.foreground = Material.White

            lblMissingFieldsError.visible = false
        }
        function clearFields()
        {
            clearErrors()

            resPK = ""
            subPK = ""

            txtSuspect.text = ""
            txtSubmitter.text = ""
            txtTitle.text = ""
            txtDetails.text = ""

            infoContainer.ScrollBar.vertical.position = 0

            scrollTitle.ScrollBar.vertical.position = 0
            scrollDetails.ScrollBar.vertical.position = 0

            txtSuspect.Material.foreground = Material.White
        }
    }

    Connections
    {
        target: backend

        function onPopupResidentTableReturn(typeString, pk, name)
        {
            if (typeString == "BLOTTER SUSPECT")
            {
                txtSuspect.text = name
                resPK = pk
                txtSuspect.Material.foreground = Material.Yellow
            }
            if (typeString == "BLOTTER SUBMITTER")
            {
                txtSubmitter.text = name
                subPK = pk
                txtSubmitter.Material.foreground = Material.Yellow
            }
        }
        function onAddBlotterCancelRequest()
        {
            internal.cancelRequest()
        }
        function onAddBlotter()
        {
            backend.AddBlotter(resPK, txtSuspect.text, txtSubmitter.text, txtTitle.text, txtDetails.text, subPK)
        }
        function onBlotterAdded()
        {
            internal.clearFields()
        }
        function onCancelAddBlotter()
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

            text: qsTr("<b>Create Blotter Report</b>")
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
            contentHeight: 450
            
            // Name
            Label
            {
                id: lblSuspect

                text: qsTr("Suspect:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            TextField
            {
                id: txtSuspect
                selectByMouse: true
                placeholderText: "Suspect's name"

                anchors.left: lblSubmitter.right
                anchors.right: btnGetSuspect.left
                anchors.verticalCenter: lblSuspect.verticalCenter
            
                anchors.margins: 20

                onTextChanged:
                {
                    txtSuspect.Material.foreground = Material.White
                    resPK = ""
                }
            }
            Button
            {
                id: btnGetSuspect
                text: "Get from Residents"

                anchors.right: parent.right
                anchors.verticalCenter: lblSuspect.verticalCenter
                anchors.margins: 50

                onClicked:
                {
                    resPopup.typeString = "BLOTTER SUSPECT"
                    resPopup.open()
                }
            }
            Label
            {
                id: lblSubmitter

                text: qsTr("Reported by:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblSuspect.bottom
                anchors.left: parent.left

                anchors.margins: 20
            }
            TextField
            {
                id: txtSubmitter
                selectByMouse: true
                placeholderText: "Report Submitter's name"

                anchors.left: lblSubmitter.right
                anchors.right: btnGetSubmitter.left
                anchors.verticalCenter: lblSubmitter.verticalCenter
            
                anchors.margins: 20

                onTextChanged:
                {
                    txtSubmitter.Material.foreground = Material.White
                    subPK = ""
                }
            }
            Button
            {
                id: btnGetSubmitter
                text: "Get from Residents"

                anchors.right: parent.right
                anchors.verticalCenter: lblSubmitter.verticalCenter
                anchors.margins: 50

                onClicked:
                {
                    resPopup.typeString = "BLOTTER SUBMITTER"
                    resPopup.open()
                }
            }
            Label
            {
                id: lblTitle

                text: qsTr("Blottered for:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblSubmitter.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            Rectangle
            {
                id: rectTitle
                color: "#1b222c"

                anchors.left: lblTitle.right
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
                        placeholderText: "Suspect's Actions"

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
                        placeholderText: "Blotter Details"

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

            anchors.left: btnAddBlotter.left
            anchors.bottom: btnAddBlotter.top
        }

        Button
        {
            id: btnAddBlotter
            text: "Submit Blotter"

            anchors.left: parent.left
            anchors.bottom: parent.bottom
            
            anchors.margins: 20

            onClicked:
            {
                internal.clearErrors()
                if (txtSuspect.text == "" || txtSubmitter.text == "" || txtTitle.text == "" || txtDetails.text == "")
                {
                    lblMissingFieldsError.visible = true
                    if (txtSuspect.text == ""){lblSuspect.Material.foreground = Material.Pink}
                    if (txtSubmitter.text == ""){lblSubmitter.Material.foreground = Material.Pink}
                    if (txtTitle.text == ""){lblTitle.Material.foreground = Material.Pink}
                    if (txtDetails.text == ""){lblDetails.Material.foreground = Material.Pink}
                }
                else
                {
                    addBlotterPopup.open()
                }
            }
        }
        Button
        {
            id: btnCancel
            text: "Cancel"

            anchors.left: btnAddBlotter.right
            anchors.bottom: parent.bottom

            anchors.margins: 20

            onClicked: internal.cancelRequest()
        }
    }

    CustomPopup
    {
        id: addBlotterPopup
        popText: "Submit this blotter?"
        popFunc: "BLOTTER ADD"
    }
    CustomPopup
    {
        id: cancelAddBlotterPopup
        popText: "You are about to cancel creating this blotter report. Continue?"
        popWarningText: "Input data will be lost"

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "BLOTTER CANCEL ADD"
        isWarning: true
    }

    ResidentTablePopup
    {
        id: resPopup
    }
}