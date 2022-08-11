import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

ApplicationWindow
{
    id: appwindow

    width: 720
    height: 720

    visible: true
    title: qsTr("MIS")

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    Component.onCompleted:
    {
        x = Screen.width / 2 - width / 2
        y = Screen.height / 2 - height / 2
    }

    Button
    {
        id: btnEpic
        text: "VERY EPIC"

        anchors.left: parent.left
        anchors.top: parent.top
        
        anchors.margins: 20
    }
}