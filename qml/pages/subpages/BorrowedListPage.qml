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

    Connections
    {
        target: backend
    }
    QtObject
    {
        id: internal

        function searchRequest()
        {
            let searchString = "SELECT * FROM bitems WHERE "

            if (txtSearchName.text != "")
            {
                const names = txtSearchName.text.split(" ")
                for (let i = 0; i < names.length; i++)
                {
                    searchString = searchString + "(bItem LIKE '%" + names[i] + "%' OR "
                    searchString = searchString + "bResName LIKE '%" + names[i] + "%') AND "
                }
            }
            if (comboStatus.currentIndex != 0)
            {
                searchString = searchString + "bStatus = '" + comboStatus.currentValue + "' AND "
            }
            if (comboBiMonth.currentIndex != 0)
            {
                let str = comboBiMonth.currentIndex.toString()
                if (comboBiMonth.currentIndex <= 9)
                {
                    str = "0" + comboBiMonth.currentIndex.toString()
                }
                searchString = searchString + "bDate LIKE '%-" + str + "-%' AND "
            }
            if (comboBiDay.currentIndex != 0)
            {
                let str = comboBiDay.currentIndex.toString()
                if (comboBiDay.currentIndex <= 9)
                {
                    str = "0" + comboBiDay.currentIndex.toString()
                }
                searchString = searchString + "bDate LIKE '%-" + str + "' AND "
            }
            if (txtBiYear.text != "")
            {
                searchString = searchString + "bDate LIKE '" + txtBiYear.text + "-%' AND "
            }

            // Finalization
            if (searchString == "SELECT * FROM bitems WHERE ")
            {
                searchString = "SELECT * FROM bitems"
            }
            else
            {
                searchString = searchString.slice(0, -5)
            }
            backend.SearchBorrowedItem(searchString)
        }
    }

    BorrowedTable
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
        placeholderText: "Search by borrower's name or item..."

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

        text: qsTr("Filter Search")
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

                comboStatus.currentIndex = 0
                comboBiMonth.currentIndex = 0
                comboBiDay.currentIndex = 0
                txtBiYear.text = ""

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
            contentHeight: 320
            
            Label
            {
                id: lblStatus
                text: qsTr("Status:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            ComboBox
            {
                id: comboStatus
                model: ["Any", "Not yet returned", "Returned"]

                anchors.left: lblStatus.right
                anchors.verticalCenter: lblStatus.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblFDate
                text: qsTr("<b>Date Lent</b>")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblStatus.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 40
            }
            Label
            {
                id: lblBiMonth
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
                id: comboBiMonth
                model: ["Any", "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

                anchors.left: lblBiMonth.right
                anchors.verticalCenter: lblBiMonth.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblBiDay
                text: qsTr("Day:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblBiMonth.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            ComboBox
            {
                id: comboBiDay
                model: ["Any", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]

                anchors.left: lblBiMonth.right
                anchors.verticalCenter: lblBiDay.verticalCenter
                anchors.right: parent.right

                anchors.margins: 20
            }
            Label
            {
                id: lblBiYear
                text: qsTr("Year:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblBiDay.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            TextField
            {
                id: txtBiYear
                selectByMouse: true
                validator: IntValidator {bottom: 0; top: 9999;}
                placeholderText: "Any"

                anchors.left: lblBiMonth.right
                anchors.verticalCenter: lblBiYear.verticalCenter
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
        anchors.bottom: btnAddBorrowedItem.top
        anchors.margins: 20

        text: "Apply Filters"

        onClicked: internal.searchRequest()
    }
    Button
    {
        id: btnAddBorrowedItem

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20

        text: "Lend Item"

        onClicked: backend.OpenAddBorrowedItemPanel()
    }
}