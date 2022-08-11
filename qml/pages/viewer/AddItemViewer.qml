import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
import "../../controls"

Rectangle
{
    id: addItemViewer

    width: 700
    color: "#1b222c"

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    QtObject
    {
        id: internal

        function cancelRequest()
        {
            if (txtItemName.text == "" && txtAmount.text == "")
            {
                backend.PopupFunc("ITEM CANCEL ADD")
            }
            else
            {
                cancelAddItemPopup.open()
            }
        }
        function clearErrors()
        {
            lblItemName.Material.foreground = Material.White
            lblAmount.Material.foreground = Material.White
            lblError.visible = false
        }
        function clearFields()
        {
            clearErrors()

            txtItemName.text = ""
            txtAmount.text = ""

            infoContainer.ScrollBar.vertical.position = 0
        }
    }
    Connections
    {
        target: backend

        function onAddItemCancelRequest()
        {
            internal.cancelRequest()
        }
        function onAddItem()
        {
            backend.AddItem(txtItemName.text, txtAmount.text)
        }
        function onCancelAddItem()
        {
            internal.clearFields()
        }
        function onItemAdded()
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

            text: qsTr("<b>Add Item</b>")
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
        }

        // Bottom Controls
        Label
        {
            id: lblError
            font.pixelSize: 10
            text: qsTr("Missing required fields")
            Material.foreground: Material.Pink
            visible: false

            anchors.left: btnAddItem.left
            anchors.bottom: btnAddItem.top
        }
        Button
        {
            id: btnAddItem
            text: "Add"

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

                    if (txtItemName.text == ""){lblItemName.Material.foreground = Material.Pink}
                    if (txtAmount.text == ""){lblAmount.Material.foreground = Material.Pink}
                }
                else
                {
                    addItemPopup.open()
                }
            }
        }
        Button
        {
            id: btnCancel
            text: "Cancel"

            anchors.left: btnAddItem.right
            anchors.bottom: parent.bottom

            anchors.margins: 20

            onClicked: internal.cancelRequest()
        }
    }
    CustomPopup
    {
        id: addItemPopup
        popText: "You are about to add this item. Continue?"
        popFunc: "ITEM ADD"
    }
    CustomPopup
    {
        id: cancelAddItemPopup
        popText: "You are about to cancel adding this item. Continue?"
        popWarningText: "Input data will be lost"

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "ITEM CANCEL ADD"
        isWarning: true
    }
}