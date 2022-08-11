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
            id: btnComplaints
            color: "#12151c"
            property bool isActive: true
            anchors.left: parent.left
            anchors.leftMargin: 100
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 120
            height: 40
            Label
            {
                text: qsTr("Complaints")
                font.pixelSize: 20

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            PropertyAnimation
            {
                id: animationComplaintsHoverEnterColor
                target: btnComplaints
                property: "color"
                to: "#2b303f"
                duration: 500
                easing.type: Easing.OutQuint
            }
            PropertyAnimation
            {
                id: animationComplaintsHoverExitColor
                target: btnComplaints
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
                    if (btnComplaints.isActive === false)
                    {
                        animationComplaintsHoverExitColor.stop()
                        animationComplaintsHoverEnterColor.running = true
                    }
                }
                onExited: animationComplaintsHoverExitColor.running = true
                onClicked:
                {
                    if (btnComplaints.isActive === false)
                    {
                        animationComplaintsHoverExitColor.running = true
                        btnComplaints.isActive = true
                        btnBlotters.isActive = false

                        complaintsActive.anchors.bottom = btnComplaints.top
                        blottersActive.anchors.bottom = contentPages.top

                        animationBlottersActive.stop()
                        animationComplaintsActive.running = true
                    }
                }
            }
        }
        Rectangle
        {
            id: btnBlotters
            color: "#12151c"
            property bool isActive: false
            anchors.left: btnComplaints.right
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 120
            height: 40
            Label
            {
                text: qsTr("Blotters")
                font.pixelSize: 20

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            PropertyAnimation
            {
                id: animationBlottersHoverEnterColor
                target: btnBlotters
                property: "color"
                to: "#2b303f"
                duration: 500
                easing.type: Easing.OutQuint
            }
            PropertyAnimation
            {
                id: animationBlottersHoverExitColor
                target: btnBlotters
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
                    if (btnBlotters.isActive === false)
                    {
                        animationBlottersHoverExitColor.stop()
                        animationBlottersHoverEnterColor.running = true
                    }
                }
                onExited: animationBlottersHoverExitColor.running = true
                onClicked:
                {
                    if (btnBlotters.isActive === false)
                    {
                        animationBlottersHoverExitColor.running = true
                        btnBlotters.isActive = true
                        btnComplaints.isActive = false

                        blottersActive.anchors.bottom = btnBlotters.top
                        complaintsActive.anchors.bottom = contentPages.top

                        animationComplaintsActive.stop()
                        animationBlottersActive.running = true
                    }
                }
            }
        }
        Rectangle
        {
            height: 2
            anchors.bottom: contentPages.top
            anchors.left: contentPages.left
            anchors.right: btnComplaints.left
        }
        Rectangle
        {
            height: 2
            anchors.bottom: contentPages.top
            anchors.left: btnBlotters.right
            anchors.right: contentPages.right
        }
        Rectangle
        {
            id: complaintsActive
            height: 2
            anchors.bottom: btnComplaints.top
            anchors.left: btnComplaints.left
            anchors.right: btnComplaints.right
        }
        Rectangle
        {
            id: blottersActive
            height: 2
            anchors.bottom: contentPages.top
            anchors.left: btnBlotters.left
            anchors.right: btnBlotters.right
        }

        Rectangle
        {
            id: contentPages
            color: "#12151c"
            z: 1

            anchors.top: btnComplaints.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.bottomMargin: 20

            clip: true

            SequentialAnimation
            {
                id: animationComplaintsActive
                PropertyAnimation {target: complaintsList; property: "anchors.rightMargin"; to: -contentPages.width; duration: 500; easing.type: Easing.OutQuint}
                ParallelAnimation
                {
                    PropertyAnimation {target: complaintsList; property: "anchors.right"; to: contentPages.right; duration: 0; easing.type: Easing.OutQuint}
                    PropertyAnimation {target: complaintsList; property: "anchors.rightMargin"; to: 0; duration: 0; easing.type: Easing.OutQuint}
                }
            }
            SequentialAnimation
            {
                id: animationBlottersActive
                ParallelAnimation
                {
                    PropertyAnimation {target: complaintsList; property: "anchors.right"; to: contentPages.left; duration: 0; easing.type: Easing.OutQuint}
                    PropertyAnimation {target: complaintsList; property: "anchors.rightMargin"; to: -contentPages.width; duration: 0; easing.type: Easing.OutQuint}
                }
                PropertyAnimation {target: complaintsList; property: "anchors.rightMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            Rectangle
            {
                id: complaintsList

                width: parent.width
                height: parent.height
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                color: "#12151c"

                ComplaintsListPage
                {
                    anchors.fill: parent
                }
            }
            Rectangle
            {
                id: blottersList

                width: parent.width
                height: parent.height
                anchors.top: parent.top
                anchors.left: complaintsList.right
                anchors.bottom: parent.bottom
                color: "#12151c"

                BlottersListPage
                {
                    anchors.fill: parent
                }
            }
        }
    }
}