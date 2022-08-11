import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Material

ApplicationWindow
{
    id: appwindow
    visible: true

    width: 300
    height: 250

    title: qsTr("MIS")

    flags: Qt.MinimizeButtonHint | Qt.CustomizeWindowHint | Qt.MSWindowsFixedSizeDialogHint

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    Component.onCompleted:
    {
        x = Screen.width / 2 - width / 2
        y = Screen.height / 2 - height / 2
    }

    Rectangle
    {
        color: "#12151c"
        anchors.fill: parent

        Label
        {
            text: "Application is already running"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 80
        }
        
        Button
        {
            id: btnOK
            text: "OK"
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.margins: 20

            onClicked: appwindow.close()
        }
    }
}