import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "subpages"

Item
{
    Rectangle
    {
        id: rectangle
        color: "#191d26"
        anchors.fill: parent

        Rectangle
        {
            id: btnItems
            color: "#12151c"
            property bool isActive: true
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 250
            height: 40
            Label
            {
                text: qsTr("Barangay Management")
                font.pixelSize: 20

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        Rectangle
        {
            height: 2
            anchors.bottom: contentPages.top
            anchors.left: contentPages.left
            anchors.right: btnItems.left
        }
        Rectangle
        {
            height: 2
            anchors.bottom: contentPages.top
            anchors.left: btnItems.right
            anchors.right: contentPages.right
        }
        Rectangle
        {
            id: itemsActive
            height: 2
            anchors.bottom: btnItems.top
            anchors.left: btnItems.left
            anchors.right: btnItems.right
        }
        Rectangle
        {
            id: contentPages
            color: "#12151c"
            z: 1

            anchors.top: btnItems.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.bottomMargin: 20

            clip: true

            Rectangle
            {
                id: officialsPage

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.right: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.leftMargin: 20
                anchors.topMargin: 20
                anchors.rightMargin: 10
                anchors.bottomMargin: 20

                color: "#12151c"

                OfficialsListPage
                {
                    anchors.fill: parent
                }
            }
            Rectangle
            {
                id: barangayInfoPage
                height: 210

                anchors.left: parent.horizontalCenter
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.leftMargin: 10
                anchors.topMargin: 20
                anchors.rightMargin: 20
                
                color: "#12151c"

                BarangayInfoPage
                {
                    anchors.fill: parent
                }
            }
            Rectangle
            {
                id: activitiesPage

                anchors.left: parent.horizontalCenter
                anchors.top: barangayInfoPage.bottom
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.leftMargin: 10
                anchors.topMargin: 20
                anchors.rightMargin: 20
                anchors.bottomMargin: 20
                
                color: "#12151c"

                ActivitiesListPage
                {
                    anchors.fill: parent
                }
            }
        }
    }
}