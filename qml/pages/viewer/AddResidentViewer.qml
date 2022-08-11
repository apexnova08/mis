import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
import "../../controls"

Rectangle
{
    id: addResidentViewer

    width: 700
    color: "#1b222c"

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    property int currentYear: 0

    Component.onCompleted:
    {
        backend.GetCurrentYear()
    }

    QtObject
    {
        id: internal

        function cancelRequest()
        {
            if (txtSName.text == "" && txtFName.text == "" && txtMName.text == "" && txtNameExt.text == "" && txtMNumber.text == "" && txtAge.text == "" && comboGender.currentIndex == -1 && comboBMonth.currentIndex == - 1 && comboBDay.currentIndex == - 1 && txtBYear.text == "" && txtBPlace.text == "" && txtOccupation.text == "" && comboCivilStatus.currentIndex == -1 && txtCitizenship.text == "" && comboPensioner.currentIndex == -1 && comboPWD.currentIndex == -1 && comboPermanent.currentIndex == -1 && comboVoter.currentIndex == -1 && comboVaccine.currentIndex == -1 && comboBooster.currentIndex == -1 && txtLot.text == "" && txtStreet.text == "" && txtHLot.text == "" && comboHBlock.currentIndex == -1)
            {
                backend.PopupFunc("RESIDENT CANCEL ADD")
            }
            else
            {
                cancelAddResidentPopup.open()
            }
        }
        function clearErrors()
        {
            lblSName.Material.foreground = Material.White
            lblFName.Material.foreground = Material.White
            lblAge.Material.foreground = Material.White
            lblGender.Material.foreground = Material.White
            lblBDate.Material.foreground = Material.White
            lblBPlace.Material.foreground = Material.White
            lblCivilStatus.Material.foreground = Material.White
            lblCitizenship.Material.foreground = Material.White
            lblPensioner.Material.foreground = Material.White
            lblPWD.Material.foreground = Material.White
            lblPermanent.Material.foreground = Material.White
            lblVoter.Material.foreground = Material.White
            lblVaccine.Material.foreground = Material.White
            lblBooster.Material.foreground = Material.White
            lblLot.Material.foreground = Material.White
            lblStreet.Material.foreground = Material.White
            lblHBlock.Material.foreground = Material.White
            lblHLot.Material.foreground = Material.White

            lblMissingFieldsError.visible = false
        }
        function clearFields()
        {
            clearErrors()

            txtSName.text = ""
            txtFName.text = ""
            txtMName.text = ""
            txtNameExt.text = ""

            txtMNumber.text = ""
            txtAge.text = ""
            comboGender.currentIndex = -1
            comboBMonth.currentIndex = -1
            comboBDay.currentIndex = -1
            txtBYear.text = ""
            txtBPlace.text = ""

            txtOccupation.text = ""
            txtCitizenship.text = ""
            comboCivilStatus.currentIndex = -1
            comboPensioner.currentIndex = -1
            comboPWD.currentIndex = -1

            comboPermanent.currentIndex = -1
            comboVoter.currentIndex = -1

            comboVaccine.currentIndex = -1
            comboBooster.currentIndex = -1

            txtLot.text = ""
            txtStreet.text = ""

            chkHead.checked = false
            comboHBlock.currentIndex = -1
            txtHLot.text = ""

            infoContainer.ScrollBar.vertical.position = 0
        }
    }

    Connections
    {
        target: backend

        function onGetCurrentYear(i)
        {
            currentYear = i
        }
        function onAddResidentCancelRequest()
        {
            internal.cancelRequest()
        }
        function onHouseHeadExists(bool, typeString)
        {
            if (bool == true && typeString == "ADD")
            {
                headAlreadyExistsPopup.open()
            }
            else if (bool == false && typeString == "ADD")
            {
                backend.CheckResIfExists(txtSName.text, txtFName.text, txtMName.text, txtBYear.text + "-" + (comboBMonth.currentIndex + 1).toString() + "-" + (comboBDay.currentIndex + 1).toString(), txtBPlace.text, "ADD")
            }
        }
        function onReplaceHeadAdd()
        {
            backend.CheckResIfExists(txtSName.text, txtFName.text, txtMName.text, txtBYear.text + "-" + (comboBMonth.currentIndex + 1).toString() + "-" + (comboBDay.currentIndex + 1).toString(), txtBPlace.text, "ADD")
        }
        function onResidentExists(bool, typeString)
        {
            if (bool == true && typeString == "ADD")
            {
                resAlreadyExistsPopup.open()
            }
            else if (bool == false && typeString == "ADD")
            {
                addResidentPopup.open()
            }
        }
        function onAddResident()
        {
            if (chkHead.checked == true)
            {
                chkHead.isChecked = "Yes"
            }
            else
            {
                chkHead.isChecked = "No"
            }
            backend.AddResident(txtSName.text, txtFName.text, txtMName.text, txtNameExt.text, txtAge.text, comboGender.currentValue, comboBMonth.currentIndex + 1, comboBDay.currentIndex + 1, txtBYear.text, txtBPlace.text, comboCivilStatus.currentValue, txtCitizenship.text, comboPWD.currentValue, comboVoter.currentValue, txtLot.text, txtStreet.text, txtHLot.text, comboHBlock.currentValue, txtMNumber.text, comboPermanent.currentValue, comboVaccine.currentValue, comboBooster.currentValue, txtOccupation.text, chkHead.isChecked, comboPensioner.currentValue)
        }
        function onResidentAdded()
        {
            internal.clearFields()
        }
        function onCancelAddResident()
        {
            internal.clearFields()
        }
    }

    Rectangle
    {
        id: rectPosition

        color: "#12171f"
        height: 50

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right

        anchors.margins: 10

        Label
        {
            id: lblPosition

            text: qsTr("<b>Add Resident</b>")
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
        anchors.top: rectPosition.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.margins: 10

        ScrollView
        {
            id: infoContainer

            anchors.fill: parent
            anchors.bottomMargin: 100
            contentHeight: 950
            
            // Name
            Label
            {
                id: lblSName

                text: qsTr("Surname:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            TextField
            {
                id: txtSName
                selectByMouse: true
                placeholderText: "Surname"

                anchors.left: lblNameExt.right
                anchors.right: parent.right
                anchors.verticalCenter: lblSName.verticalCenter
            
                anchors.leftMargin: 20
                anchors.rightMargin: 50
            }
            Label
            {
                id: lblFName

                text: qsTr("First Name:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblSName.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 10
            }
            TextField
            {
                id: txtFName
                selectByMouse: true
                placeholderText: "First Name"

                anchors.left: lblNameExt.right
                anchors.right: parent.right
                anchors.verticalCenter: lblFName.verticalCenter
            
                anchors.leftMargin: 20
                anchors.rightMargin: 50
            }
            Label
            {
                id: lblMName

                text: qsTr("Middle Name:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblFName.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 10
            }
            TextField
            {
                id: txtMName
                selectByMouse: true
                placeholderText: "Middle Name"

                anchors.left: lblNameExt.right
                anchors.right: parent.right
                anchors.verticalCenter: lblMName.verticalCenter
            
                anchors.leftMargin: 20
                anchors.rightMargin: 50
            }
            Label
            {
                id: lblNameExt

                text: qsTr("Name Extension:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblMName.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 10
            }
            TextField
            {
                id: txtNameExt
                selectByMouse: true
                placeholderText: "Name Extension"

                anchors.left: lblNameExt.right
                anchors.right: parent.right
                anchors.verticalCenter: lblNameExt.verticalCenter
            
                anchors.leftMargin: 20
                anchors.rightMargin: 50
            }

            // Personal Info
            Label
            {
                id: lblMNumber

                text: qsTr("Contact Number:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblNameExt.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            TextField
            {
                id: txtMNumber
                selectByMouse: true
                placeholderText: "Contact Number"

                anchors.left: lblNameExt.right
                anchors.verticalCenter: lblMNumber.verticalCenter
                width: 200

                anchors.leftMargin: 20
            }
            Label
            {
                id: lblAge

                text: qsTr("Age:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblMNumber.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            TextField
            {
                id: txtAge
                selectByMouse: true
                validator: IntValidator {bottom: 0; top: 999;}
                horizontalAlignment: TextInput.AlignHCenter
                placeholderText: "Age"

                anchors.left: lblNameExt.right
                anchors.verticalCenter: lblAge.verticalCenter
                width: 100

                anchors.leftMargin: 20
            }
            Label
            {
                id: lblGender

                text: qsTr("Sex:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.verticalCenter: lblAge.verticalCenter
                anchors.left: parent.horizontalCenter
            }
            ComboBox
            {
                id: comboGender
                currentIndex: -1
                displayText: currentIndex === -1 ? "Choose Sex" : currentText
                model: ["Male", "Female"]

                anchors.left: lblGender.right
                anchors.verticalCenter: lblGender.verticalCenter
                width: 150

                anchors.leftMargin: 20
            }
            Label
            {
                id: lblBDate

                text: qsTr("Birth Date:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblGender.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            ComboBox
            {
                id: comboBMonth
                currentIndex: -1
                displayText: currentIndex === -1 ? "Month" : currentText
                model: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

                anchors.left: lblNameExt.right
                anchors.verticalCenter: lblBDate.verticalCenter
                width: 150

                anchors.leftMargin: 20
            }
            ComboBox
            {
                id: comboBDay
                currentIndex: -1
                displayText: currentIndex === -1 ? "Day" : currentText
                model: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]

                anchors.left: comboBMonth.right
                anchors.verticalCenter: lblBDate.verticalCenter
                width: 100

                anchors.leftMargin: 20
            }
            TextField
            {
                id: txtBYear
                selectByMouse: true
                validator: IntValidator {bottom: 0; top: 9999;}
                horizontalAlignment: TextInput.AlignHCenter
                placeholderText: "Year"

                anchors.left: comboBDay.right
                anchors.verticalCenter: lblBDate.verticalCenter
                width: 100

                anchors.leftMargin: 20
            }
            Label
            {
                id: lblBPlace

                text: qsTr("Birth Place:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblBDate.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            TextField
            {
                id: txtBPlace
                selectByMouse: true
                placeholderText: "Birth Place"

                anchors.left: lblNameExt.right
                anchors.right: parent.right
                anchors.verticalCenter: lblBPlace.verticalCenter
            
                anchors.leftMargin: 20
                anchors.rightMargin: 50
            }

            // Legal Information
            Label
            {
                id: lblOccupation

                text: qsTr("Occupation:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblBPlace.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            TextField
            {
                id: txtOccupation
                selectByMouse: true
                placeholderText: "Occupation"

                anchors.left: lblNameExt.right
                anchors.right: parent.horizontalCenter
                anchors.verticalCenter: lblOccupation.verticalCenter
            
                anchors.leftMargin: 20
                anchors.rightMargin: 10
            }
            Label
            {
                id: lblCitizenship

                text: qsTr("Citizenship:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.verticalCenter: lblOccupation.verticalCenter
                anchors.left: parent.horizontalCenter
            }
            TextField
            {
                id: txtCitizenship
                selectByMouse: true
                horizontalAlignment: TextInput.AlignHCenter
                placeholderText: "Citizenship"

                anchors.left: lblCitizenship.right
                anchors.right: parent.right
                anchors.verticalCenter: lblCitizenship.verticalCenter

                anchors.leftMargin: 20
                anchors.rightMargin: 50
            }
            Label
            {
                id: lblPensioner

                text: qsTr("Pensioner:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: txtOccupation.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            ComboBox
            {
                id: comboPensioner
                currentIndex: -1
                displayText: currentIndex === -1 ? "Yes / No" : currentText
                model: ["Yes", "No"]

                anchors.left: lblNameExt.right
                anchors.verticalCenter: lblPensioner.verticalCenter
                width: 100

                anchors.leftMargin: 20
            }
            Label
            {
                id: lblPWD

                text: qsTr("PWD:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.verticalCenter: lblPensioner.verticalCenter
                anchors.left: parent.horizontalCenter
            }
            ComboBox
            {
                id: comboPWD
                currentIndex: -1
                displayText: currentIndex === -1 ? "Yes / No" : currentText
                model: ["Yes", "No"]

                anchors.left: lblPWD.right
                anchors.verticalCenter: lblPWD.verticalCenter
                width: 100

                anchors.leftMargin: 20
            }
            Label
            {
                id: lblCivilStatus

                text: qsTr("Civil Status:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblPensioner.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            ComboBox
            {
                id: comboCivilStatus
                currentIndex: -1
                displayText: currentIndex === -1 ? "Civil Status" : currentText
                model: ["Single", "Married", "Divorced", "Widowed"]

                anchors.left: lblNameExt.right
                anchors.verticalCenter: lblCivilStatus.verticalCenter
                width: 150

                anchors.leftMargin: 20
            }

            // Residency
            Label
            {
                id: lblPermanent

                text: qsTr("Permanent Resident:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblCivilStatus.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            ComboBox
            {
                id: comboPermanent
                currentIndex: -1
                displayText: currentIndex === -1 ? "Yes / No" : currentText
                model: ["Yes", "No"]

                anchors.left: lblNameExt.right
                anchors.verticalCenter: lblPermanent.verticalCenter
                width: 100

                anchors.leftMargin: 20
            }
            Label
            {
                id: lblVoter

                text: qsTr("Registered Voter:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.verticalCenter: lblPermanent.verticalCenter
                anchors.left: parent.horizontalCenter
            }
            ComboBox
            {
                id: comboVoter
                currentIndex: -1
                displayText: currentIndex === -1 ? "Yes / No" : currentText
                model: ["Yes", "No"]

                anchors.left: lblVoter.right
                anchors.verticalCenter: lblVoter.verticalCenter
                width: 100

                anchors.leftMargin: 20
            }

            // COVID19
            Label
            {
                id: lblCovid

                text: qsTr("<b>COVID-19</b>")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblPermanent.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 50
            }
            Label
            {
                id: lblVaccine

                text: qsTr("Vaccinated:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblCovid.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            ComboBox
            {
                id: comboVaccine
                currentIndex: -1
                displayText: currentIndex === -1 ? "Yes / No" : currentText
                model: ["Yes", "No"]

                anchors.left: lblNameExt.right
                anchors.verticalCenter: lblVaccine.verticalCenter
                width: 100

                anchors.leftMargin: 20
            }
            Label
            {
                id: lblBooster

                text: qsTr("Booster:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.verticalCenter: lblVaccine.verticalCenter
                anchors.left: parent.horizontalCenter
            }
            ComboBox
            {
                id: comboBooster
                currentIndex: -1
                displayText: currentIndex === -1 ? "Yes / No" : currentText
                model: ["Yes", "No"]

                anchors.left: lblBooster.right
                anchors.verticalCenter: lblBooster.verticalCenter
                width: 100

                anchors.leftMargin: 20
            }

            // Address
            Label
            {
                id: lblAddress

                text: qsTr("<b>Address</b>")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblVaccine.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 50
            }
            Label
            {
                id: lblLot

                text: qsTr("Lot No.:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblAddress.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            TextField
            {
                id: txtLot
                selectByMouse: true
                horizontalAlignment: TextInput.AlignHCenter
                placeholderText: "Lot No."

                anchors.left: lblNameExt.right
                anchors.verticalCenter: lblLot.verticalCenter
                width: 100
            
                anchors.leftMargin: 20
            }
            Label
            {
                id: lblStreet

                text: qsTr("Street:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.verticalCenter: lblLot.verticalCenter
                anchors.left: parent.horizontalCenter
            }
            TextField
            {
                id: txtStreet
                selectByMouse: true
                horizontalAlignment: TextInput.AlignHCenter
                placeholderText: "Street"

                anchors.left: lblStreet.right
                anchors.right: parent.right
                anchors.verticalCenter: lblStreet.verticalCenter

                anchors.leftMargin: 20
                anchors.rightMargin: 50
            }

            // Household
            Label
            {
                id: lblHousehold

                text: qsTr("<b>House Block and Lot</b>")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblLot.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 50
            }
            CheckBox
            {
                id: chkHead
                text: qsTr("Head of the family")
                property string isChecked: "No"
                font.pixelSize: 16

                anchors.left: parent.left
                anchors.top: lblHousehold.bottom
                anchors.margins: 10
            }
            Label
            {
                id: lblHBlock

                text: qsTr("Block No.:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16

                anchors.top: chkHead.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 10
            }
            ComboBox
            {
                id: comboHBlock
                currentIndex: -1
                displayText: currentIndex === -1 ? "Block" : currentText
                model: ["1", "2", "3", "4", "5", "6",]

                anchors.left: lblNameExt.right
                anchors.verticalCenter: lblHBlock.verticalCenter
                width: 100

                anchors.leftMargin: 20
            }
            Label
            {
                id: lblHLot

                text: qsTr("Lot No.:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.verticalCenter: lblHBlock.verticalCenter
                anchors.left: parent.horizontalCenter
            }
            TextField
            {
                id: txtHLot
                selectByMouse: true
                horizontalAlignment: TextInput.AlignHCenter
                placeholderText: "Lot No."

                anchors.left: lblHLot.right
                anchors.right: parent.right
                anchors.verticalCenter: lblHLot.verticalCenter
                width: 100
            
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

            anchors.left: btnAddResident.left
            anchors.bottom: btnAddResident.top
        }

        Button
        {
            id: btnAddResident
            text: "Add Resident"

            anchors.left: parent.left
            anchors.bottom: parent.bottom
            
            anchors.margins: 20

            onClicked:
            {
                internal.clearErrors()
                if (txtSName.text == "" || txtFName.text == "" || txtAge.text == "" || comboGender.currentIndex == -1 || comboBMonth.currentIndex == -1 || comboBDay.currentIndex == -1 || txtBYear.text == "" || txtBPlace.text == "" || comboCivilStatus.currentIndex == -1 || txtCitizenship.text == "" || comboPensioner.currentIndex == -1 || comboPWD.currentIndex == -1 || comboPermanent.currentIndex == -1 || comboVoter.currentIndex == -1 || comboVaccine.currentIndex == -1 || comboBooster.currentIndex == -1 || txtLot.text == "" || txtStreet.text == "" || comboHBlock.currentIndex == -1 || txtHLot.text == "")
                {
                    lblMissingFieldsError.visible = true
                    if (txtSName.text == ""){lblSName.Material.foreground = Material.Pink}
                    if (txtFName.text == ""){lblFName.Material.foreground = Material.Pink}
                    if (txtAge.text == ""){lblAge.Material.foreground = Material.Pink}
                    if (comboGender.currentIndex == -1){lblGender.Material.foreground = Material.Pink}
                    if (comboBMonth.currentIndex == -1 || comboBDay.currentIndex == -1 || txtBYear.text == ""){lblBDate.Material.foreground = Material.Pink}
                    if (txtBPlace.text == ""){lblBPlace.Material.foreground = Material.Pink}
                    if (txtCitizenship.text == ""){lblCitizenship.Material.foreground = Material.Pink}
                    if (comboCivilStatus.currentIndex == -1){lblCivilStatus.Material.foreground = Material.Pink}
                    if (comboPensioner.currentIndex == -1){lblPensioner.Material.foreground = Material.Pink}
                    if (comboPWD.currentIndex == -1){lblPWD.Material.foreground = Material.Pink}
                    if (comboPermanent.currentIndex == -1){lblPermanent.Material.foreground = Material.Pink}
                    if (comboVoter.currentIndex == -1){lblVoter.Material.foreground = Material.Pink}
                    if (comboVaccine.currentIndex == -1){lblVaccine.Material.foreground = Material.Pink}
                    if (comboBooster.currentIndex == -1){lblBooster.Material.foreground = Material.Pink}
                    if (txtLot.text == ""){lblLot.Material.foreground = Material.Pink}
                    if (txtStreet.text == ""){lblStreet.Material.foreground = Material.Pink}
                    if (comboHBlock.currentIndex == -1){lblHBlock.Material.foreground = Material.Pink}
                    if (txtHLot.text == ""){lblHLot.Material.foreground = Material.Pink}
                }
                else
                {
                    if (chkHead.checked == true)
                    {
                        backend.checkHeadIfExists(comboHBlock.currentValue, txtHLot.text, "ADD", 0)
                    }
                    else
                    {
                        backend.CheckResIfExists(txtSName.text, txtFName.text, txtMName.text, txtBYear.text + "-" + (comboBMonth.currentIndex + 1).toString() + "-" + (comboBDay.currentIndex + 1).toString(), txtBPlace.text, "ADD")
                    }
                }
            }
        }
        Button
        {
            id: btnCancel
            text: "Cancel"

            anchors.left: btnAddResident.right
            anchors.bottom: parent.bottom

            anchors.margins: 20

            onClicked:
            {
                internal.cancelRequest()
            }
        }
    }

    CustomPopup
    {
        id: addResidentPopup
        popText: "Register this resident?"
        popFunc: "RESIDENT ADD"
    }
    CustomPopup
    {
        id: headAlreadyExistsPopup
        popText: "Head of block " + comboHBlock.currentValue + " - lot " + txtHLot.text + " already exists. Continue?"
        popWarningText: "Current head of block " + comboHBlock.currentValue + " - lot " + txtHLot.text + " will be replaced by this one"

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "REPLACE HEAD ADD"
        isWarning: true
    }
    CustomPopup
    {
        id: resAlreadyExistsPopup
        popText: "Resident with the <b>same name, birthdate, and birthplace</b> already exists. Continue?"
        popWarningText: "if these two are the same person, this action will result in data redundancy"

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "RESIDENT ADD"
        isWarning: true
    }
    CustomPopup
    {
        id: cancelAddResidentPopup
        popText: "You are about to cancel resident registration. Continue?"
        popWarningText: "Input data will be lost"

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "RESIDENT CANCEL ADD"
        isWarning: true
    }
}