import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Rectangle
{
    id: bTable
    color: "#12151c"

    Component.onCompleted:
    {
        backend.DGetOfficials()
    }

    Connections
    {
        target: backend
        
        function onDGetOfficials(pk, resPK, name, position, hasPFP)
        {
            if (position == "Chairman")
            {
                rChairman.pk = pk
                rChairman.resPK = resPK
                rChairman.nameText = name
                if (hasPFP == true)
                {
                    rChairman.imgSource = "../../../mis/pfp/" + resPK + ".png"
                }
            }
            if (position == "Secretary")
            {
                rSecretary.pk = pk
                rSecretary.resPK = resPK
                rSecretary.nameText = name
                if (hasPFP == true)
                {
                    rSecretary.imgSource = "../../../mis/pfp/" + resPK + ".png"
                }
            }
            if (position == "Treasurer")
            {
                rTreasurer.pk = pk
                rTreasurer.resPK = resPK
                rTreasurer.nameText = name
                if (hasPFP == true)
                {
                    rTreasurer.imgSource = "../../../mis/pfp/" + resPK + ".png"
                }
            }
            if (position == "Kagawad Appropriation")
            {
                rAppropriation.pk = pk
                rAppropriation.resPK = resPK
                rAppropriation.nameText = name
                if (hasPFP == true)
                {
                    rAppropriation.imgSource = "../../../mis/pfp/" + resPK + ".png"
                }
            }
            if (position == "Kagawad VAWC")
            {
                rVAWC.pk = pk
                rVAWC.resPK = resPK
                rVAWC.nameText = name
                if (hasPFP == true)
                {
                    rVAWC.imgSource = "../../../mis/pfp/" + resPK + ".png"
                }
            }
            if (position == "Kagawad EP")
            {
                rEP.pk = pk
                rEP.resPK = resPK
                rEP.nameText = name
                if (hasPFP == true)
                {
                    rEP.imgSource = "../../../mis/pfp/" + resPK + ".png"
                }
            }
            if (position == "Kagawad PO")
            {
                rPO.pk = pk
                rPO.resPK = resPK
                rPO.nameText = name
                if (hasPFP == true)
                {
                    rPO.imgSource = "../../../mis/pfp/" + resPK + ".png"
                }
            }
            if (position == "Kagawad CL")
            {
                rCL.pk = pk
                rCL.resPK = resPK
                rCL.nameText = name
                if (hasPFP == true)
                {
                    rCL.imgSource = "../../../mis/pfp/" + resPK + ".png"
                }
            }
            if (position == "Kagawad ECAT")
            {
                rECAT.pk = pk
                rECAT.resPK = resPK
                rECAT.nameText = name
                if (hasPFP == true)
                {
                    rECAT.imgSource = "../../../mis/pfp/" + resPK + ".png"
                }
            }
            if (position == "Kagawad HR")
            {
                rHR.pk = pk
                rHR.resPK = resPK
                rHR.nameText = name
                if (hasPFP == true)
                {
                    rHR.imgSource = "../../../mis/pfp/" + resPK + ".png"
                }
            }
            if (position == "SK Chairman")
            {
                rSK.pk = pk
                rSK.resPK = resPK
                rSK.nameText = name
                if (hasPFP == true)
                {
                    rSK.imgSource = "../../../mis/pfp/" + resPK + ".png"
                }
            }
        }
    }

    QtObject
    {
        id: internal

        property int rowNum: 0
    }
    

    Rectangle
    {
        id: rectTitleBar

        color: "#191d26"
        height: 50

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right

        Label
        {
            id: lblTitleBar

            text: qsTr("<b>Barangay Officials</b>")
            color: "#ffffff"
            font.pixelSize: 17
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
    }

    ScrollView
    {
        id: scroll
        anchors.left: parent.left
        anchors.top: rectTitleBar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 1
        anchors.bottomMargin: 1

        contentHeight: 880
        z: 1

        DOfficialsRow
        {
            id: rChairman
            positionText: "<i>Barangay Chairman</i>"
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
        }
        DOfficialsRow
        {
            id: rSecretary
            positionText: "<i>Barangay Secretary</i>"
            anchors.left: parent.left
            anchors.top: rChairman.bottom
            anchors.right: parent.right
        }
        DOfficialsRow
        {
            id: rTreasurer
            positionText: "<i>Barangay Treasurer</i>"
            anchors.left: parent.left
            anchors.top: rSecretary.bottom
            anchors.right: parent.right
        }
        DOfficialsRow
        {
            id: rAppropriation
            positionText: "<i>Kagawad - Appropriation</i>"
            anchors.left: parent.left
            anchors.top: rTreasurer.bottom
            anchors.right: parent.right
        }
        DOfficialsRow
        {
            id: rVAWC
            positionText: "<i>Kagawad - VAWC / Health and Social Services</i>"
            anchors.left: parent.left
            anchors.top: rAppropriation.bottom
            anchors.right: parent.right
        }
        DOfficialsRow
        {
            id: rEP
            positionText: "<i>Kagawad - Environmental Protection</i>"
            anchors.left: parent.left
            anchors.top: rVAWC.bottom
            anchors.right: parent.right
        }
        DOfficialsRow
        {
            id: rPO
            positionText: "<i>Kagawad - Peace and Order</i>"
            anchors.left: parent.left
            anchors.top: rEP.bottom
            anchors.right: parent.right
        }
        DOfficialsRow
        {
            id: rCL
            positionText: "<i>Kagawad - Cooperative and Livelihood</i>"
            anchors.left: parent.left
            anchors.top: rPO.bottom
            anchors.right: parent.right
        }
        DOfficialsRow
        {
            id: rECAT
            positionText: "<i>Kagawad - Education, Cultural Affairs and Tourism / Public Works</i>"
            anchors.left: parent.left
            anchors.top: rCL.bottom
            anchors.right: parent.right
        }
        DOfficialsRow
        {
            id: rHR
            positionText: "<i>Kagawad - Human Rights</i>"
            anchors.left: parent.left
            anchors.top: rECAT.bottom
            anchors.right: parent.right
        }
        DOfficialsRow
        {
            id: rSK
            positionText: "<i>SK Chairman Youth and Sports Development</i>"
            anchors.left: parent.left
            anchors.top: rHR.bottom
            anchors.right: parent.right
        }
    }
}