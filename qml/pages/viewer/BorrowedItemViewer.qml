import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
import "../../controls"

Rectangle
{
    id: itemViewer

    width: 700
    color: "#1b222c"

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    property int pk: 0
    property string item: ""
    property string quantity: ""
    property string date: ""
    property string status: ""
    property string borrower: ""
    property string resPK: ""
    property string remarks: ""

    property string itemPK: ""

    Connections
    {
        target: backend
        function onGetBorrowedItem(pk, item, quantity, date, status, borrower, resPK, remarks, itemPK)
        {
            itemViewer.pk = pk
            itemViewer.item = item
            itemViewer.quantity = quantity
            itemViewer.date = date
            if (status == "Not yet returned")
            {
                itemViewer.status = "<b>" + status + "</b>"
                btnReturned.enabled = true
            }
            else
            {
                itemViewer.status = status
                btnReturned.enabled = false
            }
            itemViewer.borrower = borrower
            itemViewer.resPK = resPK
            itemViewer.remarks = remarks

            infoContainer.ScrollBar.vertical.position = 0
            infoContainer.contentHeight = lblRemarksVal.height + 180

            if (resPK != "")
            {
                lblBorrowerVal.color = "#ffffaa"
            }
            else
            {
                lblBorrowerVal.color = "#ffffff"
            }

            itemViewer.itemPK = itemPK
        }
        function onReturnBorrowedItem()
        {
            backend.ReturnBorrowedItem(pk, itemPK, parseInt(quantity))
        }
    }

    Rectangle
    {
        id: rectTitleBar

        color: "#12171f"
        height: 50

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right

        anchors.margins: 10

        Label
        {
            id: lblDateBar

            text: qsTr("<b>Lent Item</b>")
            color: "#ffffff"
            font.pixelSize: 17
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
    }
    Rectangle
    {
        id: rectBorrowedItemInfo

        color: "#12171f"
        anchors.left: parent.left
        anchors.top: rectTitleBar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.margins: 10

        ScrollView
        {
            id: infoContainer

            anchors.fill: parent
            anchors.bottomMargin: 100
            contentHeight: lblRemarksVal.height + 180

            // Name
            Label
            {
                id: lblItem

                text: qsTr("Borrowed Item:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblItemVal

                text: qsTr(item)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblItem.verticalCenter
                anchors.left: lblItem.right
                anchors.margins: 20
            }
            Label
            {
                id: lblQuantity

                text: qsTr("Quantity:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblItem.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblQuantityVal

                text: qsTr("<b>" + quantity + "</b>")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblQuantity.verticalCenter
                anchors.left: lblItem.right
                anchors.margins: 20
            }
            Label
            {
                id: lblBorrower

                text: qsTr("Borrowed by:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblQuantity.bottom
                anchors.left: parent.left

                anchors.leftMargin: 20
                anchors.topMargin: 10
            }
            Label
            {
                id: lblBorrowerVal

                text: qsTr(borrower)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblBorrower.verticalCenter
                anchors.left: lblItem.right
                anchors.margins: 20

                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: if (resPK != ""){lblBorrowerVal.font.underline = true}
                    onExited: lblBorrowerVal.font.underline = false
                    
                    onClicked: if (resPK != ""){backend.ViewResidentFromBorrowedItem(resPK)}
                }
            }
            Label
            {
                id: lblDate

                text: qsTr("Date Borrowed:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblBorrower.top
                anchors.left: parent.left

                anchors.margins: 20
            }
            Label
            {
                id: lblDateVal

                text: qsTr(date)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblDate.verticalCenter
                anchors.left: lblDate.right
                anchors.margins: 20
            }
            Label
            {
                id: lblStatus

                text: qsTr("Status:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblDate.bottom
                anchors.left: parent.left

                anchors.leftMargin: 20
                anchors.topMargin: 10
            }
            Label
            {
                id: lblStatusVal

                text: qsTr(status)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblStatus.verticalCenter
                anchors.left: lblItem.right
                anchors.margins: 20
            }
            Label
            {
                id: lblRemarks

                text: qsTr("Additional Remarks:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblStatus.bottom
                anchors.left: parent.left

                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            Label
            {
                id: lblRemarksVal

                text: qsTr(remarks)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblRemarks.top
                anchors.left: lblRemarks.right
                anchors.right: parent.right
                anchors.leftMargin: 20
                anchors.rightMargin: 20

                wrapMode: Label.WordWrap
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

            onClicked: backend.CloseBorrowedItemViewer()
        }
        Button
        {
            id: btnReturned
            text: "Mark as Returned"

            anchors.left: btnBack.right
            anchors.bottom: parent.bottom
            anchors.margins: 20

            onClicked: itemReturnedPopup.open()
        }
    }

    CustomPopup
    {
        id: itemReturnedPopup
        popText: "You are about to mark this record as returned. Continue?"
        popFunc: "BORROWED ITEM RETURN"
    }
}