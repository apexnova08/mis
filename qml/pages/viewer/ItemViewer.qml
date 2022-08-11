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
    property int amount: 0
    property int cAmount: 0

    property bool nameChanged: false

    QtObject
    {
        id: internal

        function valuesChanged()
        {
            if (txtItemName.text != item || txtAmount.text != amount.toString())
            {
                return true
            }
            else
            {
                return false
            }
        }
        function cancelRequest()
        {
            if (valuesChanged() == false)
            {
                backend.PopupFunc("ITEM CANCEL EDIT")
            }
            else
            {
                cancelEditItemPopup.open()
            }
        }
        function editRequest()
        {
            if (valuesChanged() == true)
            {
                if (item == txtItemName.text)
                {
                    nameChanged = false
                    editItemPopup.open()
                }
                else
                {
                    nameChanged = true
                    editItemNamePopup.open()
                }
            }
            else
            {
                lblError.text = qsTr("<i>No changes were made</i>")
                lblError.visible = true
            }
        }
        function clearErrors()
        {
            lblItemName.Material.foreground = Material.White
            lblAmount.Material.foreground = Material.White
            lblNumError.visible = false
            lblError.visible = false
        }
        function clearFields()
        {
            clearErrors()

            txtItemName.text = ""
            txtAmount.text = ""
            lblCAmountVal.text = ""
            lblBAmountVal.text = ""

            infoContainer.ScrollBar.vertical.position = 0
        }
    }
    Connections
    {
        target: backend

        function onGetItem(pk, item, amount, cAmount)
        {
            itemViewer.pk = pk
            itemViewer.item = item
            itemViewer.amount = amount
            itemViewer.cAmount = cAmount

            txtItemName.text = item
            txtAmount.text = amount.toString()
            lblCAmountVal.text = (amount - cAmount).toString()
            lblBAmountVal.text = cAmount.toString()
        }

        function onEditItemCancelRequest()
        {
            internal.cancelRequest()
        }
        function onEditItem()
        {
            backend.EditItem(pk, txtItemName.text, txtAmount.text, nameChanged)
        }
        function onCloseItemViewer()
        {
            internal.clearFields()
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
            id: lblTitleBar

            text: qsTr("<b>View / Edit Item</b>")
            color: "#ffffff"
            font.pixelSize: 17
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
    }

    Rectangle
    {
        id: rectItemInfo

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
            contentHeight: 150

            Label
            {
                id: lblItemName

                text: qsTr("Item Name:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            TextField
            {
                id: txtItemName
                selectByMouse: true
                placeholderText: "Item Name"

                anchors.left: lblAmount.right
                anchors.right: parent.right
                anchors.verticalCenter: lblItemName.verticalCenter
            
                anchors.leftMargin: 20
                anchors.rightMargin: 50
            }
            Label
            {
                id: lblAmount

                text: qsTr("Total Amount:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblItemName.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 40
            }
            TextField
            {
                id: txtAmount
                selectByMouse: true
                validator: IntValidator {bottom: 0; top: 9999;}
                horizontalAlignment: TextInput.AlignHCenter
                placeholderText: "Total Amount"

                anchors.left: lblAmount.right
                anchors.right: parent.horizontalCenter
                anchors.verticalCenter: lblAmount.verticalCenter
            
                anchors.margins: 20
            }
            Label
            {
                id: lblCAmount

                text: qsTr("In Stock:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.verticalCenter: lblAmount.verticalCenter
                anchors.left: parent.horizontalCenter
                anchors.margins: 20
            }
            Label
            {
                id: lblCAmountVal

                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.left: lblBAmount.right
                anchors.verticalCenter: lblCAmount.verticalCenter
                anchors.margins: 20
            }
            Label
            {
                id: lblBAmount

                text: qsTr("Borrowed:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblCAmount.bottom
                anchors.left: parent.horizontalCenter
                anchors.leftMargin: 20
                anchors.topMargin: 10
            }
            Label
            {
                id: lblBAmountVal

                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.left: lblBAmount.right
                anchors.verticalCenter: lblBAmount.verticalCenter
                anchors.margins: 20
            }
            Label
            {
                id: lblNumError
                font.pixelSize: 10
                text: qsTr("Cannot be lower than borrowed amount")
                Material.foreground: Material.Pink
                visible: false

                anchors.horizontalCenter: txtAmount.horizontalCenter
                anchors.top: txtAmount.bottom
            }
        }

        // Bottom Controls
        Label
        {
            id: lblError
            font.pixelSize: 10
            text: qsTr("Missing required fields")
            Material.foreground: Material.Pink
            visible: false

            anchors.left: btnEditItem.left
            anchors.bottom: btnEditItem.top
        }
        Button
        {
            id: btnEditItem
            text: "Update"

            anchors.left: parent.left
            anchors.bottom: parent.bottom
            
            anchors.margins: 20

            onClicked:
            {
                internal.clearErrors()
                if (txtItemName.text == "" || txtAmount.text == "")
                {
                    lblError.text = qsTr("<i>Missing required fields</i>")
                    lblError.visible = true

                    if (txtItemName.text == "")
                    {
                        lblItemName.Material.foreground = Material.Pink
                    }
                    if (txtAmount.text == "")
                    {
                        lblAmount.Material.foreground = Material.Pink
                    }
                }
                else if(parseInt(txtAmount.text) < cAmount)
                {
                    lblNumError.visible = true
                }
                else
                {
                    internal.editRequest()
                }
            }
        }
        Button
        {
            id: btnCancel
            text: "Back"

            anchors.left: btnEditItem.right
            anchors.bottom: parent.bottom

            anchors.margins: 20

            onClicked: internal.cancelRequest()
        }
    }
    CustomPopup
    {
        id: editItemPopup
        popText: "You are about to update this item's data. Continue?"
        popFunc: "ITEM EDIT"
    }
    CustomPopup
    {
        id: editItemNamePopup
        popText: "You are about to update this item's data including the <b>ITEM NAME</b>. Continue?"
        popWarningText: "<b>ALL SERVICE RECORDS</b> with this item will also be updated."

        popFunc: "ITEM EDIT"
        isNote: true
    }
    CustomPopup
    {
        id: cancelEditItemPopup
        popText: "You are about to cancel updating this item's data. Continue?"
        popWarningText: "No changes will be made"

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "ITEM CANCEL EDIT"
        isWarning: true
    }
}