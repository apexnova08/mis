import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "tables"

Rectangle
{
    id: rectangle
    color: "#12151c"
    anchors.fill: parent

    property string searchString: "SELECT * FROM residents"

    Component.onCompleted: 
    {
        if (loggedInPK == 0)
        {
            btnAddResident.enabled = false
            btnPrintList.enabled = false
        }
        else
        {
            btnAddResident.enabled = true
            btnPrintList.enabled = true
        }
    }
    Connections
    {
        target: backend

        function onSystemTimeOut()
        {
            printPopup.close()
        }
    }
    QtObject
    {
        id: internal

        function searchRequest()
        {
            searchString = "SELECT * FROM residents WHERE "

            if (txtSearchName.text != "")
            {
                const names = txtSearchName.text.split(" ")
                for (let i = 0; i < names.length; i++)
                {
                    searchString = searchString + "(resSName LIKE '%" + names[i] + "%' OR "
                    searchString = searchString + "resFName LIKE '%" + names[i] + "%' OR "
                    searchString = searchString + "resMName LIKE '%" + names[i] + "%' OR "
                    searchString = searchString + "resNameExt LIKE '%" + names[i] + "%') AND "
                }
            }
            if (txtAgeMin.text != "" && txtAgeMax.text == "")
            {
                searchString = searchString + "resAge >= '" + txtAgeMin.text + "' AND "
            }
            if (txtAgeMin.text == "" && txtAgeMax.text != "")
            {
                searchString = searchString + "resAge <= '" + txtAgeMax.text + "' AND "
            }
            if (txtAgeMin.text != "" && txtAgeMax.text != "")
            {
                searchString = searchString + "resAge BETWEEN '" + txtAgeMin.text + "' AND '" + txtAgeMax.text + "' AND "
            }
            if (comboGender.currentIndex != 0)
            {
                searchString = searchString + "resGender = '" + comboGender.currentValue + "' AND "
            }
            if (txtMNumber.text != "")
            {
                searchString = searchString + "resMNumber = '" + txtMNumber.text + "' AND "
            }
            if (comboPWD.currentIndex != 0)
            {
                searchString = searchString + "resPWD = '" + comboPWD.currentValue + "' AND "
            }
            if (comboSenior.currentIndex == 1)
            {
                searchString = searchString + "resAge >= 60 AND "
            }
            if (comboSenior.currentIndex == 2)
            {
                searchString = searchString + "resAge < 60 AND "
            }
            if (txtOccupation.text != "")
            {
                searchString = searchString + "resOccupation LIKE '%" + txtOccupation.text + "%' AND "
            }
            if (txtCitizenship.text != "")
            {
                searchString = searchString + "resCitizenship LIKE '%" + txtCitizenship.text + "%' AND "
            }
            if (comboCivilStatus.currentIndex != 0)
            {
                searchString = searchString + "resCivilStatus = '" + comboCivilStatus.currentValue + "' AND "
            }
            if (comboPermanent.currentIndex != 0)
            {
                searchString = searchString + "resPerm = '" + comboPermanent.currentValue + "' AND "
            }
            if (comboVoter.currentIndex != 0)
            {
                searchString = searchString + "resVoter = '" + comboVoter.currentValue + "' AND "
            }
            if (comboVaccine.currentIndex != 0)
            {
                searchString = searchString + "resVaccine = '" + comboVaccine.currentValue + "' AND "
            }
            if (comboBooster.currentIndex != 0)
            {
                searchString = searchString + "resBooster = '" + comboBooster.currentValue + "' AND "
            }
            if (txtStreet.text != "")
            {
                searchString = searchString + "resStreet LIKE '%" + txtStreet.text + "%' AND "
            }
            if (txtHBlock.text != "")
            {
                searchString = searchString + "resHouseholdBlock LIKE '%" + txtHBlock.text + "%' AND "
            }
            if (comboRegMonth.currentIndex != 0)
            {
                let str = comboRegMonth.currentIndex.toString()
                if (comboRegMonth.currentIndex <= 9)
                {
                    str = "0" + comboRegMonth.currentIndex.toString()
                }
                searchString = searchString + "resDateRegistered LIKE '%-" + str + "-%' AND "
            }
            if (comboRegDay.currentIndex != 0)
            {
                let str = comboRegDay.currentIndex.toString()
                if (comboRegDay.currentIndex <= 9)
                {
                    str = "0" + comboRegDay.currentIndex.toString()
                }
                searchString = searchString + "resDateRegistered LIKE '%-" + str + "' AND "
            }
            if (txtRegYear.text != "")
            {
                searchString = searchString + "resDateRegistered LIKE '" + txtRegYear.text + "-%' AND "
            }

            // Finalization
            if (searchString == "SELECT * FROM residents WHERE ")
            {
                searchString = "SELECT * FROM residents"
            }
            else
            {
                searchString = searchString.slice(0, -5)
            }
            backend.SearchResident(searchString)
        }
    }

    ResidentsTable
    {
        id: table
            
        width: 800
        
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom

        anchors.leftMargin: 10
        anchors.topMargin: 10
        anchors.bottomMargin: 10
    }

    // Search
    Label
    {
        id: lblSearch

        text: qsTr("<b>Search</b>")
        Material.foreground: Material.White
        font.pixelSize: 20

        anchors.left: table.right
        anchors.top: parent.top
        anchors.right: parent.right

        anchors.margins: 20
    }
    TextField
    {
        id: txtSearchName
        selectByMouse: true
        placeholderText: "Search resident by name..."

        anchors.left: table.right
        anchors.top: lblSearch.bottom
        anchors.right: btnSearch.left
        
        anchors.margins: 20

        onTextChanged: internal.searchRequest()
    }
    Rectangle
    {
        id: btnSearch
        color: "#3c3c3c"

        width: 70
        
        anchors.top: txtSearchName.top
        anchors.right: parent.right
        anchors.bottom: txtSearchName.bottom
        anchors.rightMargin: 20

        PropertyAnimation {id: animationSearchHoverEnterColor; target: btnSearch; property: "color"; to: "#5a5a5a"; duration: 500; easing.type: Easing.OutQuint;}
        PropertyAnimation {id: animationSearchHoverExitColor; target: btnSearch; property: "color"; to: "#3c3c3c"; duration: 500; easing.type: Easing.OutQuint;}
        Image
        {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            source: "../../images/icons/search.png"
        }
        MouseArea
        {
            id: searchMArea
            anchors.fill: parent
            hoverEnabled: true
            onEntered:
            {
                animationSearchHoverExitColor.stop()
                animationSearchHoverEnterColor.running = true
            }
            onExited: animationSearchHoverExitColor.running = true
            onClicked:
            {
                animationSearchHoverExitColor.running = true
                internal.searchRequest()
            }
        }
    }

    // Filter
    Label
    {
        id: lblFilter

        text: qsTr("Filter Residents")
        Material.foreground: Material.White
        font.pixelSize: 16

        anchors.left: table.right
        anchors.top: txtSearchName.bottom

        anchors.margins: 20
    }
    Rectangle
    {
        id: btnClearFilterSelection
        color: "#1b222c"

        width: 100
        height: 30

        anchors.right: filterContainer.right
        anchors.bottom: filterContainer.top

        PropertyAnimation {id: animationClearFilterSelectionHoverEnterColor; target: btnClearFilterSelection; property: "color"; to: "#3c4758"; duration: 500; easing.type: Easing.OutQuint;}
        PropertyAnimation {id: animationClearFilterSelectionHoverExitColor; target: btnClearFilterSelection; property: "color"; to: "#1b222c"; duration: 500; easing.type: Easing.OutQuint;}
        Label
        {
            text: qsTr("Clear Selection")
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
        }
        MouseArea
        {
            id: clearMArea
            anchors.fill: parent
            hoverEnabled: true
            onEntered:
            {
                animationClearFilterSelectionHoverExitColor.stop()
                animationClearFilterSelectionHoverEnterColor.running = true
            }
            onExited: animationClearFilterSelectionHoverExitColor.running = true
            onClicked:
            {
                animationClearFilterSelectionHoverExitColor.running = true

                txtAgeMin.text = ""
                txtAgeMax.text = ""
                comboGender.currentIndex = 0
                txtMNumber.text = ""
                comboPWD.currentIndex = 0
                comboSenior.currentIndex = 0
                txtOccupation.text = ""
                txtCitizenship.text = ""
                comboCivilStatus.currentIndex = 0
                comboPermanent.currentIndex = 0
                comboVoter.currentIndex = 0
                comboVaccine.currentIndex = 0
                comboBooster.currentIndex = 0
                txtStreet.text = ""
                txtHBlock.text = ""
                comboRegMonth.currentIndex = 0
                comboRegDay.currentIndex = 0
                txtRegYear.text = ""

                internal.searchRequest()
            }
        }
    }

    // Filter Container
    Rectangle
    {
        id: filterContainer
        color: "#1b222c"

        anchors.left: table.right
        anchors.top: lblFilter.bottom
        anchors.right: parent.right
        anchors.bottom: btnApplyFilter.top
        anchors.leftMargin: 20
        anchors.topMargin: 20
        anchors.rightMargin: 20

        ScrollView
        {
            anchors.fill: parent
            contentHeight: 1150
            
            Label
            {
                id: lblAge
                text: qsTr("Age:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 20
            }
            TextField
            {
                id: txtAgeMin
                selectByMouse: true
                validator: IntValidator {bottom: 0; top: 999;}
                horizontalAlignment: TextInput.AlignHCenter
                placeholderText: "Any"

                anchors.left: lblAge.right
                anchors.verticalCenter: lblAge.verticalCenter
                anchors.right: lblAgeTo.left

                anchors.margins: 20
            }
            Label
            {
                text: qsTr("<i>min</i>")
                Material.foreground: Material.White
                font.pixelSize: 10
            
                anchors.top: txtAgeMin.bottom
                anchors.horizontalCenter: txtAgeMin.horizontalCenter
                anchors.topMargin: -10
            }
            Label
            {
                id: lblAgeTo
                text: qsTr("to")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.verticalCenter: lblAge.verticalCenter
                anchors.horizontalCenter: comboGender.horizontalCenter
            }
            TextField
            {
                id: txtAgeMax
                selectByMouse: true
                validator: IntValidator {bottom: 0; top: 999;}
                horizontalAlignment: TextInput.AlignHCenter
                placeholderText: "Any"

                anchors.left: lblAgeTo.right
                anchors.verticalCenter: lblAge.verticalCenter
                anchors.right: parent.right
                width: 100

                anchors.margins: 20
            }
            Label
            {
                text: qsTr("<i>max</i>")
                Material.foreground: Material.White
                font.pixelSize: 10
            
                anchors.top: txtAgeMax.bottom
                anchors.horizontalCenter: txtAgeMax.horizontalCenter
                anchors.topMargin: -10
            }
            Label
            {
                id: lblGender
                text: qsTr("Gender:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblAge.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            ComboBox
            {
                id: comboGender
                model: ["Any", "Male", "Female"]

                anchors.left: lblGender.right
                anchors.verticalCenter: lblGender.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblMNumber
                text: qsTr("Contact No.:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblGender.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            TextField
            {
                id: txtMNumber
                selectByMouse: true
                placeholderText: "Any"

                anchors.left: lblMNumber.right
                anchors.verticalCenter: lblMNumber.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblPWD
                text: qsTr("PWD:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblMNumber.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 60
            }
            ComboBox
            {
                id: comboPWD
                model: ["Any", "Yes", "No"]

                anchors.left: lblPWD.right
                anchors.verticalCenter: lblPWD.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblSenior
                text: qsTr("Senior Citizen:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblPWD.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            ComboBox
            {
                id: comboSenior
                model: ["Any", "Yes", "No"]

                anchors.left: lblSenior.right
                anchors.verticalCenter: lblSenior.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblOccupation
                text: qsTr("Occupation:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblSenior.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 60
            }
            TextField
            {
                id: txtOccupation
                selectByMouse: true
                placeholderText: "Any"

                anchors.left: lblOccupation.right
                anchors.verticalCenter: lblOccupation.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblCitizenship
                text: qsTr("Citizenship:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblOccupation.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            TextField
            {
                id: txtCitizenship
                selectByMouse: true
                placeholderText: "Any"

                anchors.left: lblCitizenship.right
                anchors.verticalCenter: lblCitizenship.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblCivilStatus
                text: qsTr("Civil Status:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblCitizenship.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            ComboBox
            {
                id: comboCivilStatus
                model: ["Any", "Single", "Married", "Divorced", "Widowed"]

                anchors.left: lblCivilStatus.right
                anchors.verticalCenter: lblCivilStatus.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblPermanent
                text: qsTr("Permanent Resident:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblCivilStatus.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            ComboBox
            {
                id: comboPermanent
                model: ["Any", "Yes", "No"]

                anchors.left: lblPermanent.right
                anchors.verticalCenter: lblPermanent.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblVoter
                text: qsTr("Registered Voter:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblPermanent.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            ComboBox
            {
                id: comboVoter
                model: ["Any", "Yes", "No"]

                anchors.left: lblVoter.right
                anchors.verticalCenter: lblVoter.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblCOVID
                text: qsTr("<b>COVID-19</b>")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblVoter.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 40
            }
            Label
            {
                id: lblVaccine
                text: qsTr("Vaccine:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblCOVID.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            ComboBox
            {
                id: comboVaccine
                model: ["Any", "Yes", "No"]

                anchors.left: lblVaccine.right
                anchors.verticalCenter: lblVaccine.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblBooster
                text: qsTr("Booster:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblVaccine.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            ComboBox
            {
                id: comboBooster
                model: ["Any", "Yes", "No"]

                anchors.left: lblBooster.right
                anchors.verticalCenter: lblBooster.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblAddress
                text: qsTr("<b>Address</b>")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblBooster.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 40
            }
            Label
            {
                id: lblStreet
                text: qsTr("Street:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblAddress.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            TextField
            {
                id: txtStreet
                selectByMouse: true
                placeholderText: "Any"

                anchors.left: lblStreet.right
                anchors.verticalCenter: lblStreet.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblHBlock
                text: qsTr("House Block:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblStreet.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            TextField
            {
                id: txtHBlock
                selectByMouse: true
                placeholderText: "Any"

                anchors.left: lblHBlock.right
                anchors.verticalCenter: lblHBlock.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblRegDate
                text: qsTr("<b>Date Registered</b>")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblHBlock.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 40
            }
            Label
            {
                id: lblRegMonth
                text: qsTr("Month:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblRegDate.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            ComboBox
            {
                id: comboRegMonth
                model: ["Any", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

                anchors.left: lblRegMonth.right
                anchors.verticalCenter: lblRegMonth.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblRegDay
                text: qsTr("Day:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblRegMonth.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            ComboBox
            {
                id: comboRegDay
                model: ["Any", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]

                anchors.left: lblRegMonth.right
                anchors.verticalCenter: lblRegDay.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblRegYear
                text: qsTr("Year:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblRegDay.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            TextField
            {
                id: txtRegYear
                selectByMouse: true
                validator: IntValidator {bottom: 0; top: 9999;}
                placeholderText: "Any"

                anchors.left: lblRegMonth.right
                anchors.verticalCenter: lblRegYear.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
        }
    }

    Button
    {
        id: btnApplyFilter

        anchors.left: table.right
        anchors.right: parent.right
        anchors.bottom: btnAddResident.top
        anchors.margins: 20

        text: "Apply Filters"

        onClicked: internal.searchRequest()
    }
    Button
    {
        id: btnAddResident

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20

        text: "Register Resident"

        onClicked: backend.OpenAddResidentPanel()
    }
    Button
    {
        id: btnPrintList

        anchors.right: btnAddResident.left
        anchors.bottom: parent.bottom
        anchors.margins: 20

        text: "Print Displayed Residents"

        onClicked: printPopup.open()
    }
    Popup
    {
        id: printPopup
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
            id: popPrint
            color: "#1b222c"

            anchors.fill: parent

            Label
            {
                id: lblText
                text: qsTr("You are about to this document. Continue?")

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.margins: 40
            }
            Label
            {
                id: lblTitle
                text: qsTr("Enter Title of List <i>(Required)</i>")
                Material.foreground: Material.White

                anchors.left: txtTitle.left
                anchors.top: lblText.bottom
                anchors.topMargin: 50
            }
            TextField
            {
                id: txtTitle
                selectByMouse: true
                placeholderText: "Title of List"

                anchors.left: parent.left
                anchors.top: lblTitle.bottom
                anchors.right: parent.right
                anchors.leftMargin: 50
                anchors.rightMargin: 50

                width: 100
            }
            Label
            {
                id: lblError
                font.pixelSize: 10
                text: qsTr("Missing required fields")
                Material.foreground: Material.Pink
                visible: false

                anchors.left: btnPopOK.left
                anchors.bottom: btnPopOK.top
            }
            Rectangle
            {
                id: btnPopOK
                color: "#3c3c3c"
                radius: 2
                height: 40
                
                anchors.left: parent.left
                anchors.right: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.margins: 20

                Label
                {
                    text: qsTr("Print")
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                PropertyAnimation {id: animationOKButtonHoverEnter; target: btnPopOK; property: "color"; to: "#b00041"; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {id: animationOKButtonHoverExit; target: btnPopOK; property: "color"; to: "#cf1e60"; duration: 1000; easing.type: Easing.OutQuint}
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
                        lblError.visible = false
                        lblTitle.Material.foreground = Material.White

                        if (txtTitle.text == "")
                        {
                            lblError.visible = true
                            lblTitle.Material.foreground = Material.Pink
                        }
                        else
                        {
                            backend.PrintCustomList(searchString, txtTitle.text)
                            printPopup.close()
                        }
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
                    onClicked: printPopup.close()
                }
            }
        }
    }
}