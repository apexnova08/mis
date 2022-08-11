import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "tables"

Rectangle
{
    id: rectangle
    color: "#12151c"

    Component.onCompleted: backend.DGetActivities()

    Connections
    {
        target: backend

        function onDGetActivitiesT(name)
        {
            if (lblT1.text == qsTr("<i>None</i>"))
            {
                lblT1.text = qsTr("<b><i>" + name + "</i></b>")
            }
            else
            {
                lblUpcoming.anchors.top = containerT.bottom
                lblT2.text = qsTr("<b><i>" + name + "</i></b>")
            }
        }
        function onDGetActivitiesU(name, date)
        {
            if (lblU1.text == qsTr("<i>None</i>"))
            {
                lblU1.text = qsTr("<i>" + date + " - " + name + "</i>")
            }
            else
            {
                lblU2.text = qsTr("<i>" + date + " - " + name + "</i>")
            }
        }
    }

    Label
    {
        id: lblTitle

        text: qsTr("<b>Activities and Events</b>")
        font.pixelSize: 20

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.margins: 20
    }

    Label
    {
        id: lblToday
        text: qsTr("<i>Today:    </i>")
        font.pixelSize: 15

        anchors.left: parent.left
        anchors.top: lblTitle.bottom
        anchors.leftMargin: 20
        anchors.topMargin: 10
    }

    Column
    {
        id: containerT

        anchors.top: lblToday.top
        anchors.left: lblToday.right
        anchors.right: parent.right
        anchors.leftMargin: 20
        
        Label
        {
            id: lblT1
            text: qsTr("<i>None</i>")
            font.pixelSize: 15
        }
        Label
        {
            id: lblT2
            text: qsTr("")
            font.pixelSize: 15
        }
    }

    Label
    {
        id: lblUpcoming
        text: qsTr("<i>Upcoming:    </i>")
        font.pixelSize: 15

        anchors.left: parent.left
        anchors.top: lblToday.bottom
        anchors.leftMargin: 20
        anchors.topMargin: 20
    }
    Column
    {
        id: containerU

        anchors.top: lblUpcoming.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.leftMargin: 50
        
        Label
        {
            id: lblU1
            text: qsTr("<i>None</i>")
            font.pixelSize: 15
        }
        Label
        {
            id: lblU2
            text: qsTr("")
            font.pixelSize: 15
        }
    }
}