import QtQuick 2.15
import QtQuick.Controls 2.15

Rectangle
{
    id: btnTemplate

    property url btnImage: ""
    property string btnText: ""
    property string printPage: ""

    implicitWidth: 300
    implicitHeight: 450

    color: "#12151c"

    Connections
    {
        target: backend
    }

    PropertyAnimation
    {
        id: animationHoverEnter
        target: btnThumbnail
        property: "anchors.margins"
        to: 0
        duration: 500
        easing.type: Easing.OutQuint
    }
    PropertyAnimation
    {
        id: animationHoverExit
        target: btnThumbnail
        property: "anchors.margins"
        to: 20
        duration: 500
        easing.type: Easing.OutQuint
    }
    Rectangle
    {
        color: "#12151c"
        anchors.fill: parent
        anchors.bottomMargin: 20

        Image
        {
            id: btnThumbnail
            anchors.fill: parent
            anchors.margins: 20
            source: btnImage
        }
    }
    Rectangle
    {
        color: "#12151c"
        height: 20
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 20

        Label
        {
            text: qsTr("<b>" + btnText + "</b>")
            color: "White"
            font.pixelSize: 15

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
        }
    }
    
    MouseArea
    {
        id: mArea
        anchors.fill: parent
        hoverEnabled: true
        onEntered: 
        {
            animationHoverExit.stop()
            animationHoverEnter.running = true
        }
        onExited: animationHoverExit.running = true
        onClicked:
        {
            animationHoverExit.running = true
            backend.OpenPrintPanel(printPage)
        }
    }
}