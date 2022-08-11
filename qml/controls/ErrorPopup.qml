import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Popup
{
    id: errorPopup
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

    Connections
    {
        target: backend
        function onSystemTimeOut()
        {
            errorPopup.close()
        }
    }

    property string popText: ""

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
            anchors.bottom: parent.verticalCenter
            anchors.right: parent.right
            
            anchors.leftMargin: 20
            anchors.topMargin: 60
            anchors.rightMargin: 20
        }
        Label
        {
            id: lblWarning
            text: qsTr("Error: ")
            Material.foreground: Material.Pink

            anchors.left: lblText.left
            anchors.bottom: lblText.top
        }
        Rectangle
        {
            id: btnOK
            color: "#cf1e60"
            radius: 2
            height: 40
            
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 20

            Label
            {
                text: qsTr("OK")
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }

            PropertyAnimation {id: animationOKButtonHoverEnter; target: btnOK; property: "color"; to: "#b00041"; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {id: animationOKButtonHoverExit; target: btnOK; property: "color"; to: "#cf1e60"; duration: 1000; easing.type: Easing.OutQuint}
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
                onClicked: errorPopup.close()
            }
        }
    }
}