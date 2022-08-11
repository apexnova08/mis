import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "tables"
import "../../controls"

Rectangle
{
    id: rectangle
    anchors.fill: parent
    color: "#12151c"

    property int tempPK: 0
    property string tempName: ""

    Connections
    {
        target: backend
    }

    Label
    {
        id: lblTitle

        text: qsTr("<b><i>Activities and Events</i></b>")
        font.pixelSize: 20

        anchors.left: parent.left
        anchors.top: parent.top
    }

    ActivitiesTable
    {
        id: table
        anchors.left: parent.left
        anchors.top: lblTitle.bottom
        anchors.right: parent.right
        anchors.bottom: btnAddActivity.top
        anchors.topMargin: 10
        anchors.bottomMargin: 20
    }

    Button
    {
        id: btnAddActivity
        text: "Add"

        anchors.right: parent.right
        anchors.bottom: parent.bottom

        onClicked: backend.OpenAddActivityPanel()
    }
}