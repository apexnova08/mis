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

    Component.onCompleted: 
    {
        if (loggedInPK == 0)
        {
            btnAddBlotter.enabled = false
        }
        else
        {
            btnAddBlotter.enabled = true
        }
    }
    Connections
    {
        target: backend
    }
    QtObject
    {
        id: internal

        function searchRequest()
        {
            let searchString = "SELECT * FROM blotters WHERE "

            if (txtSearchName.text != "")
            {
                const names = txtSearchName.text.split(" ")
                for (let i = 0; i < names.length; i++)
                {
                    searchString = searchString + "(bloSuspect LIKE '%" + names[i] + "%' OR "
                    searchString = searchString + "bloTitle LIKE '%" + names[i] + "%') AND "
                }
            }
            if (comboFMonth.currentIndex != 0)
            {
                let str = comboFMonth.currentIndex.toString()
                if (comboFMonth.currentIndex <= 9)
                {
                    str = "0" + comboFMonth.currentIndex.toString()
                }
                searchString = searchString + "bloDate LIKE '%-" + str + "-%' AND "
            }
            if (comboFDay.currentIndex != 0)
            {
                let str = comboFDay.currentIndex.toString()
                if (comboFDay.currentIndex <= 9)
                {
                    str = "0" + comboFDay.currentIndex.toString()
                }
                searchString = searchString + "bloDate LIKE '%-" + str + "' AND "
            }
            if (txtFYear.text != "")
            {
                searchString = searchString + "bloDate LIKE '" + txtFYear.text + "-%' AND "
            }

            // Finalization
            if (searchString == "SELECT * FROM blotters WHERE ")
            {
                searchString = "SELECT * FROM blotters"
            }
            else
            {
                searchString = searchString.slice(0, -5)
            }
            backend.SearchBlotter(searchString)
        }
    }

    BlottersTable
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
        placeholderText: "Search by suspect name or incident..."

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

        text: qsTr("Filter Blotters")
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

                comboFMonth.currentIndex = 0
                comboFDay.currentIndex = 0
                txtFYear.text = ""

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
            contentHeight: 250

            Label
            {
                id: lblFDate
                text: qsTr("<b>Date Submitted</b>")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblFMonth
                text: qsTr("Month:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblFDate.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            ComboBox
            {
                id: comboFMonth
                model: ["Any", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

                anchors.left: lblFMonth.right
                anchors.verticalCenter: lblFMonth.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblFDay
                text: qsTr("Day:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblFMonth.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            ComboBox
            {
                id: comboFDay
                model: ["Any", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]

                anchors.left: lblFMonth.right
                anchors.verticalCenter: lblFDay.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblFYear
                text: qsTr("Year:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblFDay.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            TextField
            {
                id: txtFYear
                selectByMouse: true
                validator: IntValidator {bottom: 0; top: 9999;}
                placeholderText: "Any"

                anchors.left: lblFMonth.right
                anchors.verticalCenter: lblFYear.verticalCenter
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
        anchors.bottom: btnAddBlotter.top
        anchors.margins: 20

        text: "Apply Filters"

        onClicked: internal.searchRequest()
    }
    Button
    {
        id: btnAddBlotter
        
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20

        text: "Submit Blotter"

        onClicked: backend.OpenAddBlotterPanel()
    }
}