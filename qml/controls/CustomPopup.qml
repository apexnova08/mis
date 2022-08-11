import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Popup
{
    id: customPopup
    width: 500
    height: 300
    modal: true
    focus: true

    Material.theme: Material.Dark
    anchors.centerIn: Overlay.overlay
    Overlay.modal: Rectangle
    {
        color: "#aacfdbe7"
    }
    Component.onCompleted:
    {
        if (isWarning == true)
        {
            colorBar.visible = true
            lblWarning.visible = true
        }
        if (isNote == true)
        {
            colorBar.visible = true
            colorBar.color = "#e4ba00"
        }
    }
    Connections
    {
        target: backend

        function onSystemTimeOut()
        {
            customPopup.close()
        }
    }

    property bool isWarning: false
    property bool isNote: false
    property string popText: ""
    property string popWarningText: ""
    property string popFunc: ""

    property color popOKButtonColor: "#3c3c3c"
    property color popOKButtonColorHover: "#5a5a5a"
    property string popOKButtonText: "OK"

    property color popBackButtonColor: "#3c3c3c"
    property color popBackButtonColorHover: "#5a5a5a"
    property string popBackButtonText: "Back"

    Rectangle
    {
        id: bg
        color: "#1b222c"

        anchors.fill: parent

        Rectangle
        {
            id: colorBar
            color: "#cf1e60"
            height: 10
            visible: false

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
        }

        Label
        {
            id: lblText
            text: qsTr(popText)

            horizontalAlignment: Label.AlignHCenter
            wrapMode: Label.WordWrap

            anchors.left: parent.left
            anchors.top: colorBar.bottom
            anchors.right: parent.right
            
            anchors.leftMargin: 20
            anchors.topMargin: 60
            anchors.rightMargin: 20
        }
        Label
        {
            id: lblWarningText
            text: qsTr(popWarningText)

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
            anchors.margins: 20
        }
        Label
        {
            id: lblWarning
            text: qsTr("Warning: ")
            visible: false
            Material.foreground: Material.Pink

            anchors.left: lblWarningText.left
            anchors.bottom: lblWarningText.top
        }
        Rectangle
        {
            id: btnOK
            color: popOKButtonColor
            radius: 2
            height: 40
            
            anchors.left: parent.left
            anchors.right: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.margins: 20

            Label
            {
                text: qsTr(popOKButtonText)
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            PropertyAnimation {id: animationOKButtonHoverEnter; target: btnOK; property: "color"; to: popOKButtonColorHover; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {id: animationOKButtonHoverExit; target: btnOK; property: "color"; to: popOKButtonColor; duration: 1000; easing.type: Easing.OutQuint}
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                onEntered:
                {
                    animationOKButtonHoverExit.stop()
                    animationOKButtonHoverEnter.running = true
                }
                onExited: animationOKButtonHoverExit.running = true
                onClicked: 
                {
                    backend.PopupFunc(popFunc)
                    customPopup.close()
                }
            }
        }
        Rectangle
        {
            id: btnBack
            color: popBackButtonColor
            radius: 2
            height: 40
            
            anchors.left: parent.horizontalCenter
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 20

            Label
            {
                text: qsTr(popBackButtonText)
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            PropertyAnimation {id: animationBackButtonHoverEnter; target: btnBack; property: "color"; to: popBackButtonColorHover; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {id: animationBackButtonHoverExit; target: btnBack; property: "color"; to: popBackButtonColor; duration: 1000; easing.type: Easing.OutQuint}
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
                onEntered:
                {
                    animationBackButtonHoverExit.stop()
                    animationBackButtonHoverEnter.running = true
                }
                onExited: animationBackButtonHoverExit.running = true
                onClicked: customPopup.close()
            }
        }
    }
}