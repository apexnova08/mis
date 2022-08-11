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

    clip: true

    Component.onCompleted: 
    {
        if (loggedInPosition != "Chairman")
        {
            rectBusiness.enabled = false
            rectBusiness.visible = false
            rectBusinessContainer.enabled = false
            rectBusinessContainer.visible = false

            scroll.scrollSize = 1000
            scroll.contentHeight = 1000
        }
        else
        {
            rectBusiness.enabled = true
            rectBusiness.visible = true
            rectBusinessContainer.enabled = true
            rectBusinessContainer.visible = true

            scroll.scrollSize = 1500
            scroll.contentHeight = 1500
        }
    }

    Connections
    {
        target: backend

        function onOpenPrintPanel(page)
        {
            if (page == "LISTPWD")
            {
                printPopup.popFunc = "PRINT " + page
                printPopup.open()
            }
            if (page == "LISTSENIOR")
            {
                printPopup.popFunc = "PRINT " + page
                printPopup.open()
            }
            if (page == "LISTPENSIONER")
            {
                printPopup.popFunc = "PRINT " + page
                printPopup.open()
            }
        }
        function onPrintDocument(page)
        {
            if (page == "LISTPWD")
            {
                backend.PrintPWDList()
            }
            if (page == "LISTSENIOR")
            {
                backend.PrintSeniorList()
            }
            if (page == "LISTPENSIONER")
            {
                backend.PrintPensionerList()
            }
        }
    }

    ParallelAnimation
    {
        id: animationResidencyOpen
        NumberAnimation {target: rectResidency; property: "height"; to: 450; duration: 500; easing.type: Easing.OutQuint}
        NumberAnimation {target: arrowResidency; property: "rotation"; to: 0; duration: 500; easing.type: Easing.OutQuint}
        NumberAnimation {target: scroll; property: "contentHeight"; to: scroll.scrollSize; duration: 500; easing.type: Easing.OutQuint}
    }
    ParallelAnimation
    {
        id: animationResidencyClose
        NumberAnimation {target: rectResidency; property: "height"; to: 0; duration: 500; easing.type: Easing.OutQuint}
        NumberAnimation {target: arrowResidency; property: "rotation"; to: -90; duration: 500; easing.type: Easing.OutQuint}
        NumberAnimation {target: scroll; property: "contentHeight"; to: scroll.scrollSize; duration: 500; easing.type: Easing.OutQuint}
    }
    ParallelAnimation
    {
        id: animationBusinessOpen
        NumberAnimation {target: rectBusiness; property: "height"; to: 450; duration: 500; easing.type: Easing.OutQuint}
        NumberAnimation {target: arrowBusiness; property: "rotation"; to: 0; duration: 500; easing.type: Easing.OutQuint}
        NumberAnimation {target: scroll; property: "contentHeight"; to: scroll.scrollSize; duration: 500; easing.type: Easing.OutQuint}
    }
    ParallelAnimation
    {
        id: animationBusinessClose
        NumberAnimation {target: rectBusiness; property: "height"; to: 0; duration: 500; easing.type: Easing.OutQuint}
        NumberAnimation {target: arrowBusiness; property: "rotation"; to: -90; duration: 500; easing.type: Easing.OutQuint}
        NumberAnimation {target: scroll; property: "contentHeight"; to: scroll.scrollSize; duration: 500; easing.type: Easing.OutQuint}
    }
    ParallelAnimation
    {
        id: animationReportsOpen
        NumberAnimation {target: rectReports; property: "height"; to: 450; duration: 500; easing.type: Easing.OutQuint}
        NumberAnimation {target: arrowReports; property: "rotation"; to: 0; duration: 500; easing.type: Easing.OutQuint}
        NumberAnimation {target: scroll; property: "contentHeight"; to: scroll.scrollSize; duration: 500; easing.type: Easing.OutQuint}
    }
    ParallelAnimation
    {
        id: animationReportsClose
        NumberAnimation {target: rectReports; property: "height"; to: 0; duration: 500; easing.type: Easing.OutQuint}
        NumberAnimation {target: arrowReports; property: "rotation"; to: -90; duration: 500; easing.type: Easing.OutQuint}
        NumberAnimation {target: scroll; property: "contentHeight"; to: scroll.scrollSize; duration: 500; easing.type: Easing.OutQuint}
    }

    ScrollView
    {
        id: scroll

        property int scrollSize: 0

        anchors.fill: parent

        Column
        {
            id: container
            anchors.fill: parent

            clip: true

            Rectangle
            {
                color: "#12151c"
                height: 50
                anchors.left: parent.left
                anchors.right: parent.right

                Image
                {
                    id: arrowResidency
                    source: "../../images/icons/arrow1.png"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 22
                }
                Label
                {
                    id: lblResidency
                    text: qsTr("<b>Residency</b>")
                    color: "#ffffff"
                    font.pixelSize: 18
                    anchors.left: arrowResidency.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                }
                Rectangle
                {
                    color: "#c5c5c5"
                    height: 1
                    anchors.left: lblResidency.right
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                    anchors.rightMargin: 50
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    if (arrowResidency.rotation == 0)
                    {
                        scroll.scrollSize = scroll.scrollSize - 450
                        animationResidencyClose.running = true
                    }
                    else
                    {
                        scroll.scrollSize = scroll.scrollSize + 450
                        animationResidencyOpen.running = true
                    }
                }
            }
            Rectangle
            {
                id: rectResidency
                color: "#12151c"
                height: 450
                anchors.left: parent.left
                anchors.right: parent.right

                clip: true

                PrintTemplateButton
                {
                    id: btnCertification

                    btnImage: "../images/docx/bgycertification.png"
                    btnText: "Barangay Certificate"
                    printPage: "BGYCERTIFICATE"

                    anchors.left: parent.left
                    anchors.top: parent.top
                }
                PrintTemplateButton
                {
                    id: btnClearance

                    btnImage: "../images/docx/bgyclearance.png"
                    btnText: "Barangay Clearance"
                    printPage: "BGYCLEARANCE"

                    anchors.left: btnCertification.right
                    anchors.top: parent.top
                }
                PrintTemplateButton
                {
                    id: btnIndigency

                    btnImage: "../images/docx/bgyindigency.png"
                    btnText: "Barangay Indigency"
                    printPage: "BGYINDIGENCY"

                    anchors.left: btnClearance.right
                    anchors.top: parent.top
                }
            }
            Rectangle
            {
                id: rectBusinessContainer
                color: "#12151c"
                height: 50
                anchors.left: parent.left
                anchors.right: parent.right

                Image
                {
                    id: arrowBusiness
                    source: "../../images/icons/arrow1.png"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 22
                }
                Label
                {
                    id: lblBusiness
                    text: qsTr("<b>Business</b>")
                    color: "#ffffff"
                    font.pixelSize: 18
                    anchors.left: arrowBusiness.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                }
                Rectangle
                {
                    color: "#c5c5c5"
                    height: 1
                    anchors.left: lblBusiness.right
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                    anchors.rightMargin: 50
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    if (arrowBusiness.rotation == 0)
                    {
                        scroll.scrollSize = scroll.scrollSize - 450
                        animationBusinessClose.running = true
                    }
                    else
                    {
                        scroll.scrollSize = scroll.scrollSize + 450
                        animationBusinessOpen.running = true
                    }
                }
            }
            Rectangle
            {
                id: rectBusiness
                color: "#12151c"
                height: 450
                anchors.left: parent.left
                anchors.right: parent.right

                clip: true

                PrintTemplateButton
                {
                    id: btnBusinessClearance

                    btnImage: "../images/docx/businessclearance.png"
                    btnText: "Business Clearance"
                    printPage: "BSNCLEARANCE"

                    anchors.left: parent.left
                    anchors.top: parent.top
                }
            }
            Rectangle
            {
                color: "#12151c"
                height: 50
                anchors.left: parent.left
                anchors.right: parent.right

                Image
                {
                    id: arrowReports
                    source: "../../images/icons/arrow1.png"
                    anchors.left: parent.left
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 22
                }
                Label
                {
                    id: lblReports
                    text: qsTr("<b>Reports</b>")
                    color: "#ffffff"
                    font.pixelSize: 18
                    anchors.left: arrowReports.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                }
                Rectangle
                {
                    color: "#c5c5c5"
                    height: 1
                    anchors.left: lblReports.right
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.leftMargin: 20
                    anchors.rightMargin: 50
                }
                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    if (arrowReports.rotation == 0)
                    {
                        scroll.scrollSize = scroll.scrollSize - 450
                        animationReportsClose.running = true
                    }
                    else
                    {
                        scroll.scrollSize = scroll.scrollSize + 450
                        animationReportsOpen.running = true
                    }
                }
            }
            Rectangle
            {
                id: rectReports
                color: "#12151c"
                height: 450
                anchors.left: parent.left
                anchors.right: parent.right

                clip: true

                PrintTemplateButton
                {
                    id: btnPWD

                    btnImage: "../images/docx/listPWD.png"
                    btnText: "PWD List"
                    printPage: "LISTPWD"

                    anchors.left: parent.left
                    anchors.top: parent.top
                }
                PrintTemplateButton
                {
                    id: btnSenior

                    btnImage: "../images/docx/listSenior.png"
                    btnText: "Senior Citizen List"
                    printPage: "LISTSENIOR"

                    anchors.left: btnPWD.right
                    anchors.top: parent.top
                }
                PrintTemplateButton
                {
                    id: btnPensioner

                    btnImage: "../images/docx/listPensioners.png"
                    btnText: "Pensioners List"
                    printPage: "LISTPENSIONER"

                    anchors.left: btnSenior.right
                    anchors.top: parent.top
                }
            }
        }
    }
    CustomPopup
    {
        id: printPopup
        popText: "You are about to print this document. Continue?"
    }
}