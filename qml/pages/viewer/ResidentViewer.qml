import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
import "../../controls"

Rectangle
{
    id: residentViewer

    width: 700
    color: "#1b222c"

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    property int pk: 0
    property string sName: ""
    property string fName: ""
    property string mName: ""
    property string nameExt: ""
    property string age: ""
    property string gender: ""
    property int birthYear: 0
    property int birthMonth: 0
    property int birthDay: 0
    property string birthPlace: ""
    property string civilStatus: ""
    property string citizenship: ""
    property string lot: ""
    property string street: ""
    property string householdLot: ""
    property string householdBlock: ""
    property string position: ""
    property int regYear: 0
    property int regMonth: 0
    property int regDay: 0
    property string pwd: ""
    property string voter: ""
    property string mNumber: ""
    property string permanent: ""
    property string vaccine: ""
    property string booster: ""
    property string occupation: ""
    property string head: ""
    property string pensioner: ""

    property string birthMonthtext: ""
    property string regMonthtext: ""

    property string archivedReason: ""

    Connections
    {
        target: backend

        function onLogin(bool, pk, resPK, position)
        {
            if (bool === true)
            {
                if (pk == 0)
                {
                    btnEdit.enabled = false
                    btnArchive.enabled = false
                }
                else
                {
                    btnEdit.enabled = true
                    btnArchive.enabled = true
                }
            }
        }
        function onSystemTimeOut()
        {
            archiveResidentPopup.close()
        }
        function onGetResident(pk, sName, fName, mName, nameExt, age, gender, birthYear, birthMonth, birthDay, birthPlace, civilStatus, citizenship, lot, street, householdLot, householdBlock, position, regYear, regMonth, regDay, pwd, voter, mNumber, permanent, vaccine, booster, occupation, head, pensioner)
        {
            residentViewer.pk = pk
            residentViewer.sName = sName
            residentViewer.fName = fName
            residentViewer.mName = mName
            residentViewer.nameExt = nameExt
            residentViewer.age = age
            residentViewer.gender = gender
            residentViewer.birthYear = birthYear
            residentViewer.birthMonth = birthMonth
            residentViewer.birthDay = birthDay
            residentViewer.birthPlace = birthPlace
            residentViewer.civilStatus = civilStatus
            residentViewer.citizenship = citizenship
            residentViewer.lot = lot
            residentViewer.street = street
            residentViewer.householdLot = householdLot
            residentViewer.householdBlock = householdBlock
            if (position == "SK")
            {
                residentViewer.position = "SK Chairman"
            }
            else
            {
                residentViewer.position = position
            }
            residentViewer.regYear = regYear
            residentViewer.regMonth = regMonth
            residentViewer.regDay = regDay
            residentViewer.pwd = pwd
            residentViewer.voter = voter
            residentViewer.mNumber = mNumber
            residentViewer.permanent = permanent
            residentViewer.vaccine = vaccine
            residentViewer.booster = booster
            residentViewer.occupation = occupation
            residentViewer.head = head
            residentViewer.pensioner = pensioner

            infoContainer.ScrollBar.vertical.position = 0

            // Birth Month
            if (birthMonth == 1)
            {
                birthMonthtext = "January"
            }
            if (birthMonth == 2)
            {
                birthMonthtext = "February"
            }
            if (birthMonth == 3)
            {
                birthMonthtext = "March"
            }
            if (birthMonth == 4)
            {
                birthMonthtext = "April"
            }
            if (birthMonth == 5)
            {
                birthMonthtext = "May"
            }
            if (birthMonth == 6)
            {
                birthMonthtext = "June"
            }
            if (birthMonth == 7)
            {
                birthMonthtext = "July"
            }
            if (birthMonth == 8)
            {
                birthMonthtext = "August"
            }
            if (birthMonth == 9)
            {
                birthMonthtext = "September"
            }
            if (birthMonth == 10)
            {
                birthMonthtext = "October"
            }
            if (birthMonth == 11)
            {
                birthMonthtext = "November"
            }
            if (birthMonth == 12)
            {
                birthMonthtext = "December"
            }
            
            // Registered Month
            if (regMonth == 1)
            {
                regMonthtext = "January"
            }
            if (regMonth == 2)
            {
                regMonthtext = "February"
            }
            if (regMonth == 3)
            {
                regMonthtext = "March"
            }
            if (regMonth == 4)
            {
                regMonthtext = "April"
            }
            if (regMonth == 5)
            {
                regMonthtext = "May"
            }
            if (regMonth == 6)
            {
                regMonthtext = "June"
            }
            if (regMonth == 7)
            {
                regMonthtext = "July"
            }
            if (regMonth == 8)
            {
                regMonthtext = "August"
            }
            if (regMonth == 9)
            {
                regMonthtext = "September"
            }
            if (regMonth == 10)
            {
                regMonthtext = "October"
            }
            if (regMonth == 11)
            {
                regMonthtext = "November"
            }
            if (regMonth == 12)
            {
                regMonthtext = "December"
            }
        }

        function onGetOfficialPosition(position, eString)
        {
            if (position == "None" && eString == "RESVIEWER")
            {
                archiveResidentPopup.open()
            }
            if (position != "None" && eString == "RESVIEWER")
            {
                resHasPositionPopup.popText = "Selected resident is currently elected as <b><i>" + position + "</i></b>. Dismiss them from their active position first before removing them from the residents list."
                resHasPositionPopup.open()
            }
        }

        function onArchiveResident()
        {
            backend.ArchiveResident(pk, archivedReason)
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

            text: qsTr("<b>Barangay " + position + " Profile</b>")
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
            contentHeight: 650

            // Name
            Label
            {
                id: lblSName

                text: qsTr("Surname:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblSNameVal

                text: qsTr(sName)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblSName.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }
            Label
            {
                id: lblFName

                text: qsTr("First Name:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblSName.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblFNameVal

                text: qsTr(fName)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblFName.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }
            Label
            {
                id: lblMName

                text: qsTr("Middle Name:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblFName.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblMNameVal

                text: qsTr(mName)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblMName.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }
            Label
            {
                id: lblNameExt

                text: qsTr("Name Extension:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblMName.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblNameExtVal

                text: qsTr(nameExt)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblNameExt.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }

            // Personal Info
            Label
            {
                id: lblMNumber

                text: qsTr("Contact Number:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblNameExt.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblMNumberVal

                text: qsTr(mNumber)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblMNumber.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }
            Label
            {
                id: lblAge

                text: qsTr("Age:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblMNumber.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblAgeVal

                text: qsTr(age)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblAge.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }
            Label
            {
                id: lblGender

                text: qsTr("Sex:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblAge.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblGenderVal

                text: qsTr(gender)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblGender.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }
            Label
            {
                id: lblBDate

                text: qsTr("Birth Date:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblGender.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblBDateVal

                text: qsTr(birthMonthtext + " " + birthDay + ", " + birthYear)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblBDate.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }
            Label
            {
                id: lblBPlace

                text: qsTr("Birth Place:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblBDate.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblBPlaceVal

                text: qsTr(birthPlace)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblBPlace.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }

            // Legal Information
            Label
            {
                id: lblOccupation

                text: qsTr("Occupation:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblBPlace.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblOccupationVal

                text: qsTr(occupation)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblOccupation.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }
            Label
            {
                id: lblCivilStatus

                text: qsTr("Civil Status:     ")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.top: lblOccupation.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblCivilStatusVal

                text: qsTr(civilStatus)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblCivilStatus.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }
            Label
            {
                id: lblCitizenship

                text: qsTr("Citizenship:     ")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.top: lblCivilStatus.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblCitizenshipVal

                text: qsTr(citizenship)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblCitizenship.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }
            Label
            {
                id: lblPWD

                text: qsTr("Person with Disability:     ")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.top: lblCitizenship.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblPWDVal

                text: qsTr(pwd)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblPWD.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }
            Label
            {
                id: lblPensioner

                text: qsTr("Pensioner:     ")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.top: lblPWDVal.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblPensionerVal

                text: qsTr(pensioner)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblPensioner.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }

            // Residency
            Label
            {
                id: lblVoter

                text: qsTr("Registered Voter:     ")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.top: lblPensioner.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblVoterVal

                text: qsTr(voter)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblVoter.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }
            Label
            {
                id: lblPerm

                text: qsTr("Permanent Resident:     ")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.top: lblVoter.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblPermVal

                text: qsTr(permanent)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblPerm.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }

            // COVID
            Label
            {
                id: lblVaccine

                text: qsTr("COVID-19 Vaccinated:     ")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.top: lblPerm.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblVaccineVal

                text: qsTr(vaccine)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblVaccine.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }
            Label
            {
                id: lblBooster

                text: qsTr("COVID-19 Booster:     ")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.top: lblVaccine.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblBoosterVal

                text: qsTr(booster)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblBooster.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }

            // Address
            Label
            {
                id: lblAddress

                text: qsTr("Address:     ")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.top: lblBooster.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblAddressVal

                text: qsTr(lot + ", " + street + " street")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblAddress.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }
            Label
            {
                id: lblHousehold

                text: qsTr("Household:     ")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.top: lblAddress.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblHouseholdVal

                text: qsTr("Block " + householdBlock + ", Lot " + householdLot)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblHousehold.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }

            // Date Registered
            Label
            {
                id: lblRDate

                text: qsTr("Date Registered:     ")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.top: lblHousehold.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblRDateVal

                text: qsTr(regMonthtext + " " + regDay + ", " + regYear)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblRDate.verticalCenter
                anchors.left: lblPWD.right
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

            onClicked: backend.CloseResidentViewer()
        }
        Button
        {
            id: btnEdit
            text: "Edit Resident Data"

            anchors.left: btnBack.right
            anchors.bottom: parent.bottom
            anchors.margins: 20

            onClicked: backend.OpenEditResidentPanel(pk, sName, fName, mName, nameExt, age, gender, birthYear, birthMonth, birthDay, birthPlace, civilStatus, citizenship, lot, street, householdLot, householdBlock, position, regYear, regMonth, regDay, pwd, voter, mNumber, permanent, vaccine, booster, occupation, head, pensioner)
        }
        Button
        {
            id: btnArchive
            text: "Archive Resident"

            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 20

            onClicked: backend.GetOfficialPosition(pk, "RESVIEWER")
        }

        ErrorPopup
        {
            id: resHasPositionPopup
        }
        
        Popup
        {
            id: archiveResidentPopup
            width: 500
            height: 300
            modal: true
            focus: true

            anchors.centerIn: Overlay.overlay
            Overlay.modal: Rectangle
            {
                color: "#aacfdbe7"
            }

            Rectangle
            {
                id: popbg
                color: "#1b222c"

                anchors.fill: parent

                Rectangle
                {
                    id: redBar
                    color: "#cf1e60"
                    height: 10

                    anchors.left: parent.left
                    anchors.top: parent.top
                    anchors.right: parent.right
                }

                Label
                {
                    id: lblText
                    text: qsTr("This resident will be archived. Continue?")

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: redBar.bottom
                    anchors.margins: 30
                }
                Label
                {
                    id: lblWarningText
                    text: qsTr("Resident data will be premanently deleted from active residents list")

                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.top: lblText.bottom
                    anchors.topMargin: 40
                }
                Label
                {
                    id: lblWarning
                    text: qsTr("Warning: ")
                    Material.foreground: Material.Pink

                    anchors.left: lblWarningText.left
                    anchors.bottom: lblWarningText.top
                }
                Label
                {
                    id: lblReason
                    text: qsTr("Optional: Reason for removing this resident")

                    anchors.left: txtReason.left
                    anchors.top: lblWarningText.bottom
                    anchors.topMargin: 30
                }
                TextField
                {
                    id: txtReason
                    selectByMouse: true
                    placeholderText: "State your reason here..."

                    anchors.left: parent.left
                    anchors.top: lblReason.bottom
                    anchors.right: parent.right
                    anchors.leftMargin: 50
                    anchors.rightMargin: 50

                    width: 100
                }
                Rectangle
                {
                    id: btnPopOK
                    color: "#cf1e60"
                    radius: 2
                    height: 40
                    
                    anchors.left: parent.left
                    anchors.right: parent.horizontalCenter
                    anchors.bottom: parent.bottom
                    anchors.margins: 20

                    Label
                    {
                        text: qsTr("Archive")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    PropertyAnimation {id: animationOKButtonHoverEnter; target: btnPopOK; property: "color"; to: "#5a5a5a"; duration: 500; easing.type: Easing.OutQuint}
                    PropertyAnimation {id: animationOKButtonHoverExit; target: btnPopOK; property: "color"; to: "#3c3c3c"; duration: 1000; easing.type: Easing.OutQuint}
                    MouseArea
                    {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered:
                        {
                            animationOKButtonHoverExit.stop()
                            animationOKButtonHoverEnter.running = true
                        }
                        onExited: animationOKButtonHoverExit.running = true
                        onClicked: 
                        {
                            archivedReason = txtReason.text
                            backend.PopupFunc("RESIDENT ARCHIVE")
                            archiveResidentPopup.close()
                        }
                    }
                }
                Rectangle
                {
                    id: btnPopBack
                    color: "#3c3c3c"
                    radius: 2
                    height: 40
                    
                    anchors.left: parent.horizontalCenter
                    anchors.right: parent.right
                    anchors.bottom: parent.bottom
                    anchors.margins: 20

                    Label
                    {
                        text: qsTr("Back")
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    PropertyAnimation {id: animationBackButtonHoverEnter; target: btnPopBack; property: "color"; to: "#5a5a5a"; duration: 500; easing.type: Easing.OutQuint}
                    PropertyAnimation {id: animationBackButtonHoverExit; target: btnPopBack; property: "color"; to: "#3c3c3c"; duration: 1000; easing.type: Easing.OutQuint}
                    MouseArea
                    {
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered:
                        {
                            animationBackButtonHoverExit.stop()
                            animationBackButtonHoverEnter.running = true
                        }
                        onExited: animationBackButtonHoverExit.running = true
                        onClicked: archiveResidentPopup.close()
                    }
                }
            }
        }
    }
}