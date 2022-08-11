import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material

Rectangle
{
    id: row

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    property string categoryText: "Category"
    property string valueText: "00"
    property url imgSource: "../../images/demographics/default.png"

    height: 50
    color: "#12151c"

    Connections
    {
        target: backend
    }

    Rectangle
    {
        color: "#191d26"
        
        anchors.fill: parent
        anchors.margins: 2

        Rectangle
        {
            id: rectIcon
            color: "#191d26"

            width: 46
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom

            Image
            {
                id: imgIcon
                source: imgSource

                anchors.fill: parent
                anchors.margins: 5
            }
        }
        Label
        {
            id: txtCategory
            text: qsTr(categoryText)
            color: "#ffffff"
            font.pixelSize: 16

            anchors.left: rectIcon.right
            anchors.verticalCenter: parent.verticalCenter
        }
        Label
        {
            id: txtPosition
            text: qsTr("<b>" + valueText + "</b>")
            color: "#ffffff"
            font.pixelSize: 16
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.margins: 20
        }
    }
}