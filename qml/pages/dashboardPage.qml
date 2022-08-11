import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "subpages"

Item
{
    Component.onCompleted: backend.DGetBarangayInfo()

    Connections
    {
        target: backend

        function onDGetBarangayInfo(name, address, contact)
        {
            lblAddressVal.text = address
            lblContactVal.text = contact
        }
    }

    Rectangle
    {
        id: rectangle
        color: "#191d26"
        anchors.fill: parent

        Rectangle
        {
            color: "#ffffff"
            height: 2
            anchors.left: rectUser.left
            anchors.right: rectUser.right
            anchors.bottom: rectUser.top
        }
        Rectangle
        {
            color: "#ffffff"
            height: 2
            anchors.left: rectDemo.left
            anchors.right: rectDemo.right
            anchors.bottom: rectDemo.top
        }
        Rectangle
        {
            color: "#ffffff"
            height: 2
            anchors.left: rectEvents.left
            anchors.right: rectEvents.right
            anchors.bottom: rectEvents.top
        }
        Rectangle
        {
            color: "#ffffff"
            height: 2
            anchors.left: rectInfo.left
            anchors.right: rectInfo.right
            anchors.bottom: rectInfo.top
        }
        Rectangle
        {
            color: "#ffffff"
            height: 2
            anchors.left: rectOfficials.left
            anchors.right: rectOfficials.right
            anchors.bottom: rectOfficials.top
        }

        Rectangle
        {
            id: rectUser
            color: "#12151c"
            height: 100

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.horizontalCenter
            anchors.leftMargin: 20
            anchors.topMargin: 20
            anchors.rightMargin: 10

            DUserPage
            {
                anchors.fill: parent
            }
        }
        Rectangle
        {
            id: rectDemo
            color: "#12151c"

            anchors.left: parent.left
            anchors.top: rectUser.bottom
            anchors.right: parent.horizontalCenter
            anchors.bottom: rectEvents.top
            anchors.leftMargin: 20
            anchors.topMargin: 20
            anchors.rightMargin: 10
            anchors.bottomMargin: 20

            DDemographicsPage
            {
                anchors.fill: parent
                anchors.margins: 20
            }
        }
        Rectangle
        {
            id: rectEvents
            color: "#12151c"
            height: 200

            anchors.left: parent.left
            anchors.right: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.rightMargin: 10
            anchors.bottomMargin: 20

            DActivitiesPage
            {
                anchors.fill: parent
                anchors.margins: 20
            }
        }
        Rectangle
        {
            id: rectInfo
            color: "#12151c"
            height: 170

            anchors.left: parent.horizontalCenter
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.leftMargin: 10
            anchors.topMargin: 20
            anchors.rightMargin: 20

            Label
            {
                id: lblBName
                text: qsTr("<b>BARANGAY 40 GUMAMELA - CAVITE CITY</b>")
                font.pixelSize: 20

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.margins: 20
            }
            Label
            {
                id: lblTitle
                text: qsTr("<b><i>Barangay Information</i></b>")
                font.pixelSize: 15

                anchors.left: parent.left
                anchors.top: lblBName.bottom
                anchors.margins: 20
            }
            Label
            {
                id: lblAddress
                text: qsTr("<i>Address:    </i>")
                font.pixelSize: 15

                anchors.left: parent.left
                anchors.top: lblTitle.bottom
                anchors.leftMargin: 20
                anchors.topMargin: 10
            }
            Label
            {
                id: lblAddressVal
                text: qsTr("")
                font.pixelSize: 15

                anchors.left: lblContact.right
                anchors.verticalCenter: lblAddress.verticalCenter
                anchors.margins: 20
            }
            Label
            {
                id: lblContact
                text: qsTr("<i>Contact No.:    </i>")
                font.pixelSize: 15

                anchors.left: parent.left
                anchors.top: lblAddress.bottom
                anchors.leftMargin: 20
                anchors.topMargin: 5
            }
            Label
            {
                id: lblContactVal
                text: qsTr("")
                font.pixelSize: 15

                anchors.left: lblContact.right
                anchors.verticalCenter: lblContact.verticalCenter
                anchors.margins: 20
            }
        }
        Rectangle
        {
            id: rectOfficials
            color: "#12151c"

            anchors.left: parent.horizontalCenter
            anchors.top: rectInfo.bottom
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 10
            anchors.topMargin: 20
            anchors.rightMargin: 20
            anchors.bottomMargin: 20

            DOfficialsListPage
            {
                anchors.fill: parent
                anchors.margins: 20
            }
        }
    }
}