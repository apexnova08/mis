import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Item {
    Rectangle {
        id: rectangle
        color: "#191d26"
        anchors.fill: parent

        Rectangle
        {
            id: titleTab
            color: "#12151c"
            property bool isActive: true
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 200
            height: 40
            Label
            {
                text: qsTr("Add Resident")
                font.pixelSize: 20

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
        }
        Rectangle
        {
            height: 2
            anchors.bottom: content.top
            anchors.left: content.left
            anchors.right: titleTab.left
        }
        Rectangle
        {
            height: 2
            anchors.bottom: content.top
            anchors.left: titleTab.right
            anchors.right: content.right
        }
        Rectangle
        {
            height: 2
            anchors.bottom: titleTab.top
            anchors.left: titleTab.left
            anchors.right: titleTab.right
        }

        Rectangle
        {
            id: content
            color: "#12151c"
            z: 1

            anchors.top: titleTab.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.bottomMargin: 20

            clip: true

            
        }
    }
}