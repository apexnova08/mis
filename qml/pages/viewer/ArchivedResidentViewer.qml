import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

Rectangle
{
    id: archivedResidentViewer

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
    property string birthDate: ""
    property string birthPlace: ""
    property string civilStatus: ""
    property string citizenship: ""
    property string lot: ""
    property string street: ""
    property string householdLot: ""
    property string householdBlock: ""
    property string position: ""
    property string regDate: ""
    property string archDate: ""
    property string pwd: ""
    property string voter: ""
    property string mNumber: ""
    property string permanent: ""
    property string vaccine: ""
    property string booster: ""
    property string occupation: ""
    property string reason: ""

    Connections
    {
        target: backend
        function onGetArchivedResident(pk, sName, fName, mName, nameExt, age, gender, birthDate, birthPlace, civilStatus, citizenship, lot, street, householdLot, householdBlock, position, regDate, archDate, pwd, voter, mNumber, permanent, vaccine, booster, occupation, reason)
        {
            archivedResidentViewer.pk = pk
            archivedResidentViewer.sName = sName
            archivedResidentViewer.fName = fName
            archivedResidentViewer.mName = mName
            archivedResidentViewer.nameExt = nameExt
            archivedResidentViewer.age = age
            archivedResidentViewer.gender = gender
            archivedResidentViewer.birthDate = birthDate
            archivedResidentViewer.birthPlace = birthPlace
            archivedResidentViewer.civilStatus = civilStatus
            archivedResidentViewer.citizenship = citizenship
            archivedResidentViewer.lot = lot
            archivedResidentViewer.street = street
            archivedResidentViewer.householdLot = householdLot
            archivedResidentViewer.householdBlock = householdBlock
            archivedResidentViewer.position = position
            archivedResidentViewer.regDate = regDate
            archivedResidentViewer.archDate = archDate
            archivedResidentViewer.pwd = pwd
            archivedResidentViewer.voter = voter
            archivedResidentViewer.mNumber = mNumber
            archivedResidentViewer.permanent = permanent
            archivedResidentViewer.vaccine = vaccine
            archivedResidentViewer.booster = booster
            archivedResidentViewer.occupation = occupation
            archivedResidentViewer.reason = reason

            infoContainer.ScrollBar.vertical.position = 0
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

            text: qsTr("<b>Archived Resident Profile</b>")
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

                text: qsTr(birthDate)
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

            // Residency
            Label
            {
                id: lblVoter

                text: qsTr("Registered Voter:     ")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.top: lblPWD.bottom
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

            // Archive Details
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

                text: qsTr(regDate)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblRDate.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }
            Label
            {
                id: lblADate

                text: qsTr("Date Archived:     ")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.top: lblRDate.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblADateVal

                text: qsTr(archDate)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblADate.verticalCenter
                anchors.left: lblPWD.right
                anchors.margins: 20
            }
            Label
            {
                id: lblReason

                text: qsTr("Reason:     ")
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.top: lblADate.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblReasonVal

                text: qsTr(reason)
                color: "#ffffff"
                font.pixelSize: 16
                
                anchors.verticalCenter: lblReason.verticalCenter
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

            onClicked: backend.CloseArchivedResidentViewer()
        }
    }
}