import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
import "../../controls"

Rectangle
{
    id: addItemViewer

    width: 700
    color: "#1b222c"

    property string resPK: ""

    property variant pks: []
    property variant items: []
    property variant amounts: []

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    QtObject
    {
        id: internal

        function cancelRequest()
        {
            if (txtBorrower.text == "" && comboItem.currentIndex == -1 && txtQuantity.text == "" && txtRemarks.text == "")
            {
                backend.PopupFunc("BORROWED ITEM CANCEL ADD")
            }
            else
            {
                cancelAddBorrowedItemPopup.open()
            }
        }
        function clearErrors()
        {
            lblBorrower.Material.foreground = Material.White
            lblItem.Material.foreground = Material.White
            lblQuantity.Material.foreground = Material.White

            lblMissingFieldsError.visible = false
            lblNumError.visible = false
        }
        function clearFields()
        {
            clearErrors()

            resPK = ""

            txtBorrower.text = ""
            comboItem.currentIndex = -1
            txtQuantity.text = ""
            txtRemarks.text = ""

            infoContainer.ScrollBar.vertical.position = 0
            scrollRemarks.ScrollBar.vertical.position = 0
        }
    }

    Connections
    {
        target: backend

        function onOpenAddBorrowedItem(pks, items, amounts)
        {
            addItemViewer.pks = pks
            addItemViewer.items = items
            addItemViewer.amounts = amounts

            comboItem.model = items
            comboItem.currentIndex = -1
        }
        function onPopupResidentTableReturn(typeString, pk, name)
        {
            if (typeString == "BORROWED ITEM BORROWER")
            {
                txtBorrower.text = name
                resPK = pk
                txtBorrower.Material.foreground = Material.Yellow
            }
        }
        function onAddBorrowedItemCancelRequest()
        {
            internal.cancelRequest()
        }
        function onAddBorrowedItem()
        {
            backend.AddBorrowedItem(comboItem.currentValue, txtQuantity.text, txtBorrower.text, resPK, txtRemarks.text, pks[comboItem.currentIndex], parseInt(txtQuantity.text))
        }
        function onBorrowedItemAdded()
        {
            internal.clearFields()
        }
        function onCancelAddBorrowedItem()
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

            text: qsTr("<b>Lend Item</b>")
            color: "#ffffff"
            font.pixelSize: 17
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
    }
    Rectangle
    {
        id: rectBasicInfo

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
            contentHeight: 440
            

            Label
            {
                id: lblBorrower

                text: qsTr("Borrower:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            TextField
            {
                id: txtBorrower
                selectByMouse: true
                placeholderText: "Borrower's name"

                anchors.left: lblBorrower.right
                anchors.right: btnGetBorrower.left
                anchors.verticalCenter: lblBorrower.verticalCenter
            
                anchors.leftMargin: 50
                anchors.topMargin: 20
                anchors.rightMargin: 20

                onTextChanged:
                {
                    txtBorrower.Material.foreground = Material.White
                    resPK = ""
                }
            }
            Button
            {
                id: btnGetBorrower
                text: "Get from Residents"

                anchors.right: parent.right
                anchors.verticalCenter: lblBorrower.verticalCenter
                anchors.margins: 50

                onClicked:
                {
                    resPopup.typeString = "BORROWED ITEM BORROWER"
                    resPopup.open()
                }
            }
            Label
            {
                id: lblItem

                text: qsTr("Borrowed Item:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblBorrower.bottom
                anchors.left: parent.left

                anchors.leftMargin: 20
                anchors.topMargin: 30
            }
            ComboBox
            {
                id: comboItem
                currentIndex: -1
                displayText: currentIndex === -1 ? "Choose Item" : currentText

                anchors.left: lblBorrower.right
                anchors.right: parent.horizontalCenter
                anchors.verticalCenter: lblItem.verticalCenter

                anchors.leftMargin: 50
                anchors.topMargin: 20

                onCurrentIndexChanged:
                {
                    if (comboItem.currentIndex != -1)
                    {
                        lblCItem.text = qsTr("In Stock: <b> " + amounts[comboItem.currentIndex] + "</b>")
                    }
                    else
                    {
                        lblCItem.text = ""
                    }
                }
            }
            Label
            {
                id: lblCItem

                text: qsTr("In Stock: <b>20</b>")
                Material.foreground: Material.White
                font.pixelSize: 12
            
                anchors.horizontalCenter: comboItem.horizontalCenter
                anchors.top: comboItem.bottom
            }
            Label
            {
                id: lblQuantity

                text: qsTr("Quantity:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.left: parent.horizontalCenter
                anchors.verticalCenter: lblItem.verticalCenter
                anchors.margins: 20
            }
            TextField
            {
                id: txtQuantity
                selectByMouse: true
                validator: IntValidator {bottom: 0; top: 9999;}
                horizontalAlignment: TextInput.AlignHCenter
                placeholderText: "Quantity"

                anchors.left: lblQuantity.right
                anchors.right: parent.right
                anchors.verticalCenter: lblQuantity.verticalCenter
            
                anchors.leftMargin: 20
                anchors.rightMargin: 50
            }
            Label
            {
                id: lblNumError
                font.pixelSize: 10
                text: qsTr("Must be lower than amount in stock")
                Material.foreground: Material.Pink
                visible: false
            
                anchors.horizontalCenter: txtQuantity.horizontalCenter
                anchors.top: txtQuantity.bottom
            }
            Label
            {
                id: lblRemarks

                text: qsTr("Additional Remarks:     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: lblCItem.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 40
            }
            Rectangle
            {
                id: rectRemarks
                color: "#1b222c"

                anchors.left: lblRemarks.right
                anchors.right: parent.right
                anchors.top: lblRemarks.top
                height: 200

                anchors.leftMargin: 20
                anchors.rightMargin: 50

                ScrollView
                {
                    id: scrollRemarks
                    
                    anchors.fill: parent
                    anchors.margins: 5

                    TextArea
                    {
                        id: txtRemarks
                        selectByMouse: true
                        placeholderText: "Remarks"

                        wrapMode: TextArea.WordWrap
                    }
                }
            }
        }

        // Bottom Controls
        Label
        {
            id: lblMissingFieldsError
            font.italic: true
            font.pixelSize: 10
            text: "Missing required fields"
            Material.foreground: Material.Pink
            visible: false

            anchors.left: btnAddBorrowedItem.left
            anchors.bottom: btnAddBorrowedItem.top
        }

        Button
        {
            id: btnAddBorrowedItem
            text: "Lend Item"

            anchors.left: parent.left
            anchors.bottom: parent.bottom
            
            anchors.margins: 20

            onClicked:
            {
                internal.clearErrors()
                if (txtBorrower.text == "" || comboItem.currentIndex == -1 || txtQuantity.text == "")
                {
                    lblMissingFieldsError.visible = true
                    if (txtBorrower.text == ""){lblBorrower.Material.foreground = Material.Pink}
                    if (comboItem.currentIndex == -1){lblItem.Material.foreground = Material.Pink}
                    if (txtQuantity.text == ""){lblQuantity.Material.foreground = Material.Pink}
                }
                else if (parseInt(txtQuantity.text) > amounts[comboItem.currentIndex])
                {
                    lblNumError.visible = true
                }
                else
                {
                    addBorrowedItemPopup.open()
                }
            }
        }
        Button
        {
            id: btnCancel
            text: "Cancel"

            anchors.left: btnAddBorrowedItem.right
            anchors.bottom: parent.bottom

            anchors.margins: 20

            onClicked: internal.cancelRequest()
        }
    }

    CustomPopup
    {
        id: addBorrowedItemPopup
        popText: "Lend this item?"
        popFunc: "BORROWED ITEM ADD"
    }
    CustomPopup
    {
        id: cancelAddBorrowedItemPopup
        popText: "You are about to cancel lending item(s). Continue?"
        popWarningText: "Input data will be lost"

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "BORROWED ITEM CANCEL ADD"
        isWarning: true
    }
    ResidentTablePopup
    {
        id: resPopup
    }
}