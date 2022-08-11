import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "subpages"

Item
{
    Rectangle
    {
        id: rectangle
        color: "#191d26"
        anchors.fill: parent

        Rectangle
        {
            id: btnBorrowed
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
                text: qsTr("Lending of Items")
                font.pixelSize: 20

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            PropertyAnimation
            {
                id: animationBorrowedHoverEnterColor
                target: btnBorrowed
                property: "color"
                to: "#2b303f"
                duration: 500
                easing.type: Easing.OutQuint
            }
            PropertyAnimation
            {
                id: animationBorrowedHoverExitColor
                target: btnBorrowed
                property: "color"
                to: "#12151c"
                duration: 500
                easing.type: Easing.OutQuint
            }
            MouseArea
            {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered:
                {
                    if (btnBorrowed.isActive === false)
                    {
                        animationBorrowedHoverExitColor.stop()
                        animationBorrowedHoverEnterColor.running = true
                    }
                }
                onExited: animationBorrowedHoverExitColor.running = true
                onClicked:
                {
                    if (btnBorrowed.isActive === false)
                    {
                        animationBorrowedHoverExitColor.running = true
                        btnBorrowed.isActive = true
                        btnInventory.isActive = false

                        borrowedActive.anchors.bottom = btnBorrowed.top
                        inventoryActive.anchors.bottom = contentPages.top

                        animationInventoryActive.stop()
                        animationBorrowedActive.running = true
                    }
                }
            }
        }
        Rectangle
        {
            id: btnInventory
            color: "#12151c"
            property bool isActive: false
            anchors.left: btnBorrowed.right
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 150
            height: 40
            Label
            {
                text: qsTr("Inventory")
                font.pixelSize: 20

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            PropertyAnimation
            {
                id: animationInventoryHoverEnterColor
                target: btnInventory
                property: "color"
                to: "#2b303f"
                duration: 500
                easing.type: Easing.OutQuint
            }
            PropertyAnimation
            {
                id: animationInventoryHoverExitColor
                target: btnInventory
                property: "color"
                to: "#12151c"
                duration: 500
                easing.type: Easing.OutQuint
            }
            MouseArea
            {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor
                hoverEnabled: true
                onEntered:
                {
                    if (btnInventory.isActive === false)
                    {
                        animationInventoryHoverExitColor.stop()
                        animationInventoryHoverEnterColor.running = true
                    }
                }
                onExited: animationInventoryHoverExitColor.running = true
                onClicked:
                {
                    if (btnInventory.isActive === false)
                    {
                        animationInventoryHoverExitColor.running = true
                        btnInventory.isActive = true
                        btnBorrowed.isActive = false

                        inventoryActive.anchors.bottom = btnInventory.top
                        borrowedActive.anchors.bottom = contentPages.top

                        animationBorrowedActive.stop()
                        animationInventoryActive.running = true
                    }
                }
            }
        }
        Rectangle
        {
            height: 2
            anchors.bottom: contentPages.top
            anchors.left: contentPages.left
            anchors.right: btnBorrowed.left
        }
        Rectangle
        {
            height: 2
            anchors.bottom: contentPages.top
            anchors.left: btnInventory.right
            anchors.right: contentPages.right
        }
        Rectangle
        {
            id: borrowedActive
            height: 2
            anchors.bottom: btnBorrowed.top
            anchors.left: btnBorrowed.left
            anchors.right: btnBorrowed.right
        }
        Rectangle
        {
            id: inventoryActive
            height: 2
            anchors.bottom: contentPages.top
            anchors.left: btnInventory.left
            anchors.right: btnInventory.right
        }
        Rectangle
        {
            id: contentPages
            color: "#12151c"
            z: 1

            anchors.top: btnBorrowed.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.bottomMargin: 20

            clip: true

            SequentialAnimation
            {
                id: animationBorrowedActive
                PropertyAnimation {target: borrowedList; property: "anchors.rightMargin"; to: -contentPages.width; duration: 500; easing.type: Easing.OutQuint}
                ParallelAnimation
                {
                    PropertyAnimation {target: borrowedList; property: "anchors.right"; to: contentPages.right; duration: 0; easing.type: Easing.OutQuint}
                    PropertyAnimation {target: borrowedList; property: "anchors.rightMargin"; to: 0; duration: 0; easing.type: Easing.OutQuint}
                }
            }
            SequentialAnimation
            {
                id: animationInventoryActive
                ParallelAnimation
                {
                    PropertyAnimation {target: borrowedList; property: "anchors.right"; to: contentPages.left; duration: 0; easing.type: Easing.OutQuint}
                    PropertyAnimation {target: borrowedList; property: "anchors.rightMargin"; to: -contentPages.width; duration: 0; easing.type: Easing.OutQuint}
                }
                PropertyAnimation {target: borrowedList; property: "anchors.rightMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }

            Rectangle
            {
                id: borrowedList

                width: parent.width
                height: parent.height
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                color: "#12151c"

                BorrowedListPage
                {
                    anchors.fill: parent
                }
            }
            Rectangle
            {
                id: inventoryList

                width: parent.width
                height: parent.height
                anchors.top: parent.top
                anchors.left: borrowedList.right
                anchors.bottom: parent.bottom
                color: "#12151c"

                InventoryPage
                {
                    anchors.fill: parent
                }
            }
        }
    }
}