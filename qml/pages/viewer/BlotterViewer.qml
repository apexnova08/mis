import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
import "../../controls"

Rectangle
{
    id: blotterViewer

    width: 700
    color: "#1b222c"

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    property int pk: 0
    property string resPK: ""
    property string suspect: ""
    property string submitter: ""
    property string date: ""
    property string title: ""
    property string details: ""
    property string subPK: ""

    Connections
    {
        target: backend
        function onGetBlotter(pk, resPK, suspect, submitter, date, title, details, subPK)
        {
            blotterViewer.pk = pk
            blotterViewer.resPK = resPK
            blotterViewer.suspect = suspect
            blotterViewer.submitter = submitter
            blotterViewer.date = date
            blotterViewer.title = title
            blotterViewer.details = details
            blotterViewer.subPK = subPK

            infoContainer.ScrollBar.vertical.position = 0
            infoContainer.contentHeight = lblTitleVal.height + lblDetailsVal.height + 150

            if (resPK != "")
            {
                lblSuspectVal.color = "#ffffaa"
            }
            else
            {
                lblSuspectVal.color = "#ffffff"
            }
            if (subPK != "")
            {
                lblSubmitterVal.color = "#ffffaa"
            }
            else
            {
                lblSubmitterVal.color = "#ffffff"
            }
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
            id: lblSubmitterBar

            text: qsTr("<b>Barangay Blotter</b>")
            color: "#ffffff"
            font.pixelSize: 17
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
    }
    Rectangle
    {
        id: rectComplaintInfo

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
            contentHeight: lblTitleVal.height + lblDetailsVal.height + 150

            // Name
            Label
            {
                id: lblSuspect

                text: qsTr("Suspect:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblSuspectVal

                text: qsTr(suspect)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblSuspect.verticalCenter
                anchors.left: lblSubmitter.right
                anchors.margins: 20

                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: if (resPK != ""){lblSuspectVal.font.underline = true}
                    onExited: lblSuspectVal.font.underline = false
                    
                    onClicked: if (resPK != ""){backend.ViewResidentFromBlotter(resPK)}
                }
            }
            Label
            {
                id: lblSubmitter

                text: qsTr("Submitted by:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblSuspect.bottom
                anchors.left: parent.left

                anchors.leftMargin: 20
                anchors.topMargin: 10
            }
            Label
            {
                id: lblSubmitterVal

                text: qsTr(submitter)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.verticalCenter: lblSubmitter.verticalCenter
                anchors.left: lblSubmitter.right
                anchors.margins: 20

                MouseArea
                {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: if (subPK != ""){lblSubmitterVal.font.underline = true}
                    onExited: lblSubmitterVal.font.underline = false
                    
                    onClicked: if (subPK != ""){backend.ViewResidentFromBlotter(subPK)}
                }
            }
            Label
            {
                id: lblDate

                text: qsTr("Submitted on:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblSubmitter.top
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
                anchors.left: lblSubmitter.right
                anchors.margins: 20
            }

            // Complaint Details
            Label
            {
                id: lblTitle

                text: qsTr("Blottered for:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblDate.bottom
                anchors.left: parent.left
                anchors.margins: 20
            }
            Label
            {
                id: lblTitleVal

                text: qsTr("<b>" + title + "</b>")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblTitle.top
                anchors.left: lblTitle.right
                anchors.right: parent.right
                anchors.leftMargin: 20
                anchors.rightMargin: 20

                wrapMode: Label.WordWrap
            }
            Label
            {
                id: lblDetails

                text: qsTr("Details:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblTitleVal.bottom
                anchors.left: parent.left
                anchors.leftMargin: 20
                anchors.topMargin: 10

                wrapMode: Label.WordWrap
            }
            Label
            {
                id: lblDetailsVal

                text: qsTr(details)
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: lblDetails.top
                anchors.left: lblDetails.right
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

            onClicked: backend.CloseBlotterViewer()
        }
    }
}