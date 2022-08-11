import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
import "../../controls"

Rectangle
{
    id: lotViewer

    width: 700
    color: "#1b222c"

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    property int pk: 0
    property string block: ""
    property string lot: ""

    Connections
    {
        target: backend

        function onGetLotHead(pk, name, info)
        {
            var component
            var cell
            component = Qt.createComponent("ResidentialLotResidents.qml")
            cell = component.createObject(container, {"width": rectResidentsList.width, "pk": pk, "nameText": name, "infoText": info, "isHead": true})
        }
        function onGetLotResidents(pk, name, info)
        {
            var component
            var cell
            component = Qt.createComponent("ResidentialLotResidents.qml")
            cell = component.createObject(container, {"width": rectResidentsList.width, "pk": pk, "nameText": name, "infoText": info})
        }
        function onOpenLotResidents(lot, block)
        {
            listContainer.ScrollBar.vertical.position = 0
            lotViewer.lot = lot
            lotViewer.block = block
        }
    }

    Rectangle
    {
        id: rectTitle

        color: "#12171f"
        height: 50

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right

        anchors.margins: 10

        Label
        {
            id: lblTitle

            text: qsTr("<b>Block " + block + " - Lot " + lot + " Residents</b>")
            color: "#ffffff"
            font.pixelSize: 17
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
    }
    Rectangle
    {
        id: rectResidentsList

        color: "#12171f"
        anchors.left: parent.left
        anchors.top: rectTitle.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.margins: 10

        ScrollView
        {
            id: listContainer

            anchors.fill: parent
            anchors.bottomMargin: 100
            contentHeight: container.height

            Column
            {
                id: container
                clip: true 
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

            onClicked: backend.CloseLotResidents()
        }
        Button
        {
            id: btnPrint
            text: "Print"

            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 20

            onClicked: backend.PrintHousehold(block, lot)
        }
    }
}