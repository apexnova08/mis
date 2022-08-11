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
            id: btnResidents
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
                text: qsTr("Residents")
                font.pixelSize: 20

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            PropertyAnimation
            {
                id: animationResidentsHoverEnterColor
                target: btnResidents
                property: "color"
                to: "#2b303f"
                duration: 500
                easing.type: Easing.OutQuint
            }
            PropertyAnimation
            {
                id: animationResidentsHoverExitColor
                target: btnResidents
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
                    if (btnResidents.isActive === false)
                    {
                        animationResidentsHoverExitColor.stop()
                        animationResidentsHoverEnterColor.running = true
                    }
                }
                onExited: animationResidentsHoverExitColor.running = true
                onClicked:
                {
                    if (btnResidents.isActive === false)
                    {
                        animationResidentsHoverExitColor.running = true
                        btnResidents.isActive = true
                        btnHouseholds.isActive = false

                        residentsActive.anchors.bottom = btnResidents.top
                        householdsActive.anchors.bottom = contentPages.top

                        animationHouseholdsActive.stop()
                        animationResidentsActive.running = true
                    }
                }
            }
        }
        Rectangle
        {
            id: btnHouseholds
            color: "#12151c"
            property bool isActive: false
            anchors.left: btnResidents.right
            anchors.top: parent.top
            anchors.topMargin: 20
            width: 120
            height: 40
            Label
            {
                text: qsTr("Archived")
                font.pixelSize: 20

                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
            }
            PropertyAnimation
            {
                id: animationHouseholdsHoverEnterColor
                target: btnHouseholds
                property: "color"
                to: "#2b303f"
                duration: 500
                easing.type: Easing.OutQuint
            }
            PropertyAnimation
            {
                id: animationHouseholdsHoverExitColor
                target: btnHouseholds
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
                    if (btnHouseholds.isActive === false)
                    {
                        animationHouseholdsHoverExitColor.stop()
                        animationHouseholdsHoverEnterColor.running = true
                    }
                }
                onExited: animationHouseholdsHoverExitColor.running = true
                onClicked:
                {
                    if (btnHouseholds.isActive === false)
                    {
                        animationHouseholdsHoverExitColor.running = true
                        btnHouseholds.isActive = true
                        btnResidents.isActive = false

                        householdsActive.anchors.bottom = btnHouseholds.top
                        residentsActive.anchors.bottom = contentPages.top

                        animationResidentsActive.stop()
                        animationHouseholdsActive.running = true
                    }
                }
            }
        }
        Rectangle
        {
            height: 2
            anchors.bottom: contentPages.top
            anchors.left: contentPages.left
            anchors.right: btnResidents.left
        }
        Rectangle
        {
            height: 2
            anchors.bottom: contentPages.top
            anchors.left: btnHouseholds.right
            anchors.right: contentPages.right
        }
        Rectangle
        {
            id: residentsActive
            height: 2
            anchors.bottom: btnResidents.top
            anchors.left: btnResidents.left
            anchors.right: btnResidents.right
        }
        Rectangle
        {
            id: householdsActive
            height: 2
            anchors.bottom: contentPages.top
            anchors.left: btnHouseholds.left
            anchors.right: btnHouseholds.right
        }

        Rectangle
        {
            id: contentPages
            color: "#12151c"
            z: 1

            anchors.top: btnResidents.bottom
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.rightMargin: 20
            anchors.bottomMargin: 20

            clip: true

            SequentialAnimation
            {
                id: animationResidentsActive
                PropertyAnimation {target: residentsList; property: "anchors.rightMargin"; to: -contentPages.width; duration: 500; easing.type: Easing.OutQuint}
                ParallelAnimation
                {
                    PropertyAnimation {target: residentsList; property: "anchors.right"; to: contentPages.right; duration: 0; easing.type: Easing.OutQuint}
                    PropertyAnimation {target: residentsList; property: "anchors.rightMargin"; to: 0; duration: 0; easing.type: Easing.OutQuint}
                }
            }
            SequentialAnimation
            {
                id: animationHouseholdsActive
                ParallelAnimation
                {
                    PropertyAnimation {target: residentsList; property: "anchors.right"; to: contentPages.left; duration: 0; easing.type: Easing.OutQuint}
                    PropertyAnimation {target: residentsList; property: "anchors.rightMargin"; to: -contentPages.width; duration: 0; easing.type: Easing.OutQuint}
                }
                PropertyAnimation {target: residentsList; property: "anchors.rightMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            Rectangle
            {
                id: residentsList

                width: parent.width
                height: parent.height
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.rightMargin: 0
                color: "#12151c"

                ResidentsListPage
                {
                    anchors.fill: parent
                }
            }
            Rectangle
            {
                id: householdsList

                width: parent.width
                height: parent.height
                anchors.top: parent.top
                anchors.left: residentsList.right
                anchors.bottom: parent.bottom
                color: "#12151c"

                ArchivedResidentsListPage
                {
                    anchors.fill: parent
                }
            }
        }
    }
}