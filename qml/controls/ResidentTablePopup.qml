import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Popup
{
    id: customPopup
    width: 630 //606 table width
    height: 500
    modal: true
    focus: true

    property string typeString: ""

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    anchors.centerIn: Overlay.overlay

    Overlay.modal: Rectangle
    {
        color: "#aacfdbe7"
    }

    onAboutToShow: backend.GetPopupResidents()
    onClosed:
    {
        backend.DestroyPopupResidentTable()
        scroll.ScrollBar.vertical.position = 0
    }

    QtObject
    {
        id: internal

        function searchRequest()
        {
            let searchString = "SELECT * FROM residents WHERE "

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

            // Finalization
            if (searchString == "SELECT * FROM residents WHERE ")
            {
                searchString = "SELECT * FROM residents"
            }
            else
            {
                searchString = searchString.slice(0, -5)
            }
            backend.SearchPopupResident(searchString)
        }
    }

    Connections
    {
        target: backend

        function onGetPopupResidents(pk, sName, fName, mName, nameExt, gender, age)
        {
            var component
            var cell
            component = Qt.createComponent("ResidentTablePopupRow.qml")
            cell = component.createObject(container, {"width": 606, "pk": pk, "sNameText": sName, "fNameText": fName, "mNameText": mName, "nameExtText": nameExt, "genderText": gender, "ageText": age, "typeString": typeString})
        }
        function onPopupResidentTableReturn()
        {
            customPopup.close()
        }
        function onSystemTimeOut()
        {
            customPopup.close()
        }
    }

    Rectangle
    {
        id: bg
        color: "#1b222c"

        anchors.fill: parent

        // Search
        TextField
        {
            id: txtSearchName
            selectByMouse: true
            placeholderText: "Search resident by name..."

            anchors.left: parent.left
            anchors.top: parent.top
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
                source: "../images/icons/search.png"
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

        // Table
        Rectangle
        {
            id: rectTable
            color: "#12151c"

            anchors.left: parent.left
            anchors.top: btnSearch.bottom
            anchors.right: parent.right
            anchors.bottom: btnBack.top

            anchors.topMargin: 20
            anchors.bottomMargin: 10

            Rectangle
            {
                id: cSName

                height: 30
                width: 150
                color: "#191d26"
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.margins: 1

                Label
                {
                    text: qsTr("Surname")
                    color: "#ffffff"
                    
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Rectangle
            {
                id: cFName

                height: 30
                width: 150
                color: "#191d26"
                anchors.left: cSName.right
                anchors.top: parent.top
                anchors.margins: 1

                Label
                {
                    text: qsTr("First Name")
                    color: "#ffffff"
                    
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Rectangle
            {
                id: cMName

                height: 30
                width: 150
                color: "#191d26"
                anchors.left: cFName.right
                anchors.top: parent.top
                anchors.margins: 1

                Label
                {
                    text: qsTr("Middle Name")
                    color: "#ffffff"
                    
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Rectangle
            {
                id: cGender

                height: 30
                width: 75
                color: "#191d26"
                anchors.left: cMName.right
                anchors.top: parent.top
                anchors.margins: 1

                Label
                {
                    text: qsTr("Sex")
                    color: "#ffffff"
                    
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            Rectangle
            {
                id: cAge

                height: 30
                width: 75
                color: "#191d26"
                anchors.left: cGender.right
                anchors.top: parent.top
                anchors.margins: 1

                Label
                {
                    text: qsTr("Age")
                    color: "#ffffff"
                    
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }
            ScrollView
            {
                id: scroll
                anchors.left: parent.left
                anchors.top: cSName.bottom
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.topMargin: 1
                anchors.bottomMargin: 1

                contentHeight: container.height

                Column
                {
                    id: container
                    clip: true
                }
            }
        }

        Button
        {
            id: btnBack
            text: "Back"

            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 10

            onClicked: customPopup.close()
        }
    }
}