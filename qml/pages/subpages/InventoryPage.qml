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
            let searchString = "SELECT * FROM items WHERE "

            if (txtSearchName.text != "")
            {
                const names = txtSearchName.text.split(" ")
                for (let i = 0; i < names.length; i++)
                {
                    searchString = searchString + "iName LIKE '%" + names[i] + "%' AND "
                }
            }

            // Finalization
            if (searchString == "SELECT * FROM items WHERE ")
            {
                searchString = "SELECT * FROM items"
            }
            else
            {
                searchString = searchString.slice(0, -5)
            }
            backend.SearchItem(searchString)
        }
    }

    ItemsTable
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
        placeholderText: "Search item by name..."

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

    Button
    {
        id: btnAddItem

        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: 20

        text: "Add Item"

        onClicked: backend.OpenAddItemPanel()
    }
}