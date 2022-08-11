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
            id: btnPrinting
            color: "#12151c"
            property bool isActive: true
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 300
            height: 40
            Label
            {
                text: qsTr("Certificates and Documents")
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
            anchors.right: btnPrinting.left
        }
        Rectangle
        {
            height: 2
            anchors.bottom: contentPages.top
            anchors.left: btnPrinting.right
            anchors.right: contentPages.right
        }
        Rectangle
        {
            id: itemsActive
            height: 2
            anchors.bottom: btnPrinting.top
            anchors.left: btnPrinting.left
            anchors.right: btnPrinting.right
        }
        Rectangle
        {
            id: contentPages
            color: "#12151c"
            z: 1

            anchors.top: btnPrinting.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.bottomMargin: 20

            clip: true

            Rectangle
            {
                id: printingListPage

                anchors.fill: parent
                anchors.margins: 10

                color: "#12151c"
                
                PrintingListPage
                {
                    anchors.fill: parent
                }
            }
        }
    }
}