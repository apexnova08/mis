import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "tables"
import "../../controls"

Rectangle
{
    id: rectangle
    color: "#12151c"
    anchors.fill: parent

    property string name: ""
    property string address: ""
    property string contact: ""

    Component.onCompleted: backend.GetBarangayInfo()
    
    QtObject
    {
        id: internal

        function valuesChanged()
        {
            if (txtAddress.text == address && txtContact.text == contact)
            {
                return false
            }
            else
            {
                return true
            }
        }
        function cancelRequest()
        {
            if (valuesChanged() == false)
            {
                backend.PopupFunc("BARANGAY CANCEL EDIT")
            }
            else
            {
                cancelEditBarangayPopup.open()
            }
        }
        function editRequest()
        {
            clearErrors()
            if (valuesChanged() == false)
            {
                lblError.text = qsTr("No changes were made")
                lblError.visible = true
            }
            else
            {
                editBarangayPopup.open()
            }
        }
        function clearErrors()
        {
            lblError.visible = false
        }
    }
    Connections
    {
        target: backend

        function onGetBarangayInfo(bName, bAddress, bContact)
        {
            name = bName
            address = bAddress
            contact = bContact
        }
        function onBarangayCancelEdit()
        {
            btnEdit.text = "Edit"

            txtAddress.text = address
            txtContact.text = contact

            rectInfoEdit.visible = false
            rectInfoView.visible = true
            btnCancel.visible = false

            lblError.visible = false
        }
        function onEditBarangay()
        {
            btnEdit.text = "Edit"

            rectInfoEdit.visible = false
            rectInfoView.visible = true
            btnCancel.visible = false

            lblError.visible = false

            let updateString = "UPDATE barangay SET ";
            if (txtAddress.text != address)
            {
                updateString = updateString + "bgyAddress = '" + txtAddress.text + "', "
            }
            if (txtContact.text != contact)
            {
                updateString = updateString + "bgyContact = '" + txtContact.text + "', "
            }
            updateString = updateString.slice(0, -2)

            backend.EditBarangayInfo(updateString)
        }
    }

    Label
    {
        id: lblBName

        text: qsTr("<b>BARANGAY 40 GUMAMELA - CAVITE CITY</b>")
        font.pixelSize: 20

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.topMargin: 20
    }

    Rectangle
    {
        id: rectInfoView
        color: "#12151c"

        anchors.left: parent.left
        anchors.top: lblBName.bottom
        anchors.right: btnEdit.left
        anchors.bottom: parent.bottom
        anchors.topMargin: 20

        visible: true
        
        Label
        {
            id: lblTitleV
            text: qsTr("<b><i>Barangay Information</i></b>")
            font.pixelSize: 15

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 20
        }
        Label
        {
            id: lblAddressV
            text: qsTr("<i>Address:    </i>")
            font.pixelSize: 15

            anchors.left: parent.left
            anchors.top: lblTitleV.bottom
            anchors.topMargin: 10
        }
        Label
        {
            id: lblAddressVal
            text: qsTr(address)
            font.pixelSize: 15

            anchors.left: lblContactV.right
            anchors.verticalCenter: lblAddressV.verticalCenter
            anchors.margins: 20
        }
        Label
        {
            id: lblContactV
            text: qsTr("<i>Contact No.:    </i>")
            font.pixelSize: 15

            anchors.left: parent.left
            anchors.top: lblAddressV.bottom
            anchors.topMargin: 5
        }
        Label
        {
            id: lblContactVal
            text: qsTr(contact)
            font.pixelSize: 15

            anchors.left: lblContactV.right
            anchors.verticalCenter: lblContactV.verticalCenter
            anchors.margins: 20
        }
    }
    Rectangle
    {
        id: rectInfoEdit
        color: "#12151c"

        anchors.left: parent.left
        anchors.top: lblBName.bottom
        anchors.right: btnEdit.left
        anchors.bottom: parent.bottom
        anchors.topMargin: 20

        visible: false
        
        Label
        {
            id: lblTitleE
            text: qsTr("<b><i>Barangay Information</i></b>")
            font.pixelSize: 15

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.topMargin: 20
        }
        Label
        {
            id: lblAddressE
            text: qsTr("<i>Address:    </i>")
            font.pixelSize: 15

            anchors.left: parent.left
            anchors.top: lblTitleE.bottom
            anchors.topMargin: 20
        }
        TextField
        {
            id: txtAddress
            text: qsTr(address)
            selectByMouse: true
            placeholderText: "<i>Address</i>"

            anchors.left: lblContactE.right
            anchors.verticalCenter: lblAddressE.verticalCenter
            anchors.right: parent.right
            anchors.margins: 20
        }
        Label
        {
            id: lblContactE
            text: qsTr("<i>Contact No.:    </i>")
            font.pixelSize: 15

            anchors.left: parent.left
            anchors.top: lblAddressE.bottom
            anchors.topMargin: 20
        }
        TextField
        {
            id: txtContact
            text: qsTr(contact)
            selectByMouse: true
            placeholderText: "<i>Contact Number</i>"

            anchors.left: lblContactE.right
            anchors.verticalCenter: lblContactE.verticalCenter
            anchors.right: parent.right
            anchors.margins: 20
        }
    }

    Label
    {
        id: lblError
        font.pixelSize: 10
        text: qsTr("")
        Material.foreground: Material.Pink
        visible: false

        anchors.right: btnEdit.left
        anchors.bottom: btnEdit.bottom
        anchors.rightMargin: 20
    }
    Button
    {
        id: btnEdit
        text: "Edit"

        anchors.right: parent.right
        anchors.bottom: parent.bottom

        onClicked:
        {
            if (btnEdit.text == "Edit")
            {
                btnEdit.text = "Done"

                rectInfoEdit.visible = true
                rectInfoView.visible = false
                btnCancel.visible = true
            }
            else
            {
                lblError.visible = false
                if (txtAddress.text == "" || txtContact.text == "")
                {
                    lblError.text = qsTr("<i>Missing required fields</i>")
                    lblError.visible = true
                }
                else
                {
                    internal.editRequest()
                }
            }
        }
    }
    Button
    {
        id: btnCancel
        text: "Cancel"
        visible: false

        anchors.right: parent.right
        anchors.bottom: btnEdit.top

        onClicked: internal.cancelRequest()
    }

    CustomPopup
    {
        id: editBarangayPopup
        popText: "Update Barangay information?"
        popFunc: "BARANGAY EDIT"
    }
    CustomPopup
    {
        id: cancelEditBarangayPopup
        popText: "You are about to cancel updating the Barangay's information. Continue?"
        popWarningText: "No changes will be made"

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "BARANGAY CANCEL EDIT"
        isWarning: true
    }
}