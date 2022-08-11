import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Controls.Material
import "controls"
import "pages/viewer"
import "pages/printviewer"

ApplicationWindow
{
    id: appwindow

    width: 1280
    height: 720

    visible: true
    title: qsTr("MIS")

    flags: Qt.MinimizeButtonHint | Qt.CustomizeWindowHint | Qt.MSWindowsFixedSizeDialogHint

    property alias mainPage: stackView.currentItem

    property bool loggedIn: false
    property int loggedInPK: 0
    property int loggedInResPK: 0
    property string loggedInPosition: ""

    property string registerTurnOver: ""
    property string registerAccountPK: ""
    property string registerAccountPosition: ""
    property string registerAccountName: ""

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    Component.onCompleted:
    {
        x = Screen.width / 2 - width / 2
        y = Screen.height / 2 - height / 2

        btnDashboard.isActive = true
        stackView.push(Qt.resolvedUrl("pages/dashboardPage.qml"))
        loginStackView.push(Qt.resolvedUrl("pages/loginPage.qml"))
    }

    Connections
    {
        target: backend

        function onLogin(bool, pk, resPK, position)
        {
            if (bool === true && position != "None")
            {
                loggedInPK = pk
                loggedInResPK = resPK
                loggedInPosition = position

                if (pk == 0)
                {
                    btnManagement.isEnabled = false
                    btnManagement.visible = false
                    btnPrinting.isEnabled = false
                    btnPrinting.visible = false
                }
                else
                {
                    btnManagement.isEnabled = true
                    btnManagement.visible = true
                    btnPrinting.isEnabled = true
                    btnPrinting.visible = true
                }
                animationOnLogin.running = true
            }
        }
        function onLogout()
        {
            if (loggedIn == true)
            {
                animationOnLogout.running = true
            }
        }
        function onSystemTimeOut()
        {
            if (loggedIn == true)
            {
                internal.closePanels()
                animationOnLogout.running = true
            }
        }
        function onForgotPassword()
        {
            loginStackView.replace(Qt.resolvedUrl("pages/forgotPasswordPage.qml"))
        }
        function onOpenRegisterPanel(turnOver, rpk, position, name)
        {
            registerTurnOver = turnOver
            registerAccountPK = rpk
            registerAccountPosition = position
            registerAccountName = name

            loginStackView.replace(Qt.resolvedUrl("pages/registerPage.qml"))
            animationOnLogout.running = true
        }
        function onGotoLogin()
        {
            loginStackView.replace(Qt.resolvedUrl("pages/loginPage.qml"))
        }

        // System Settings Functions
        function onOpenSystemSettings()
        {
            animationOpenSystemSettings.running = true
            systemSettingsContainer.isActive = true
        }
        function onCloseSystemSettings()
        {
            animationCloseSystemSettings.running = true
            systemSettingsContainer.isActive = false
        }

        // Resident Viewer Functions
        function onResidentViewerChanged()
        {
            animationOpenResidentViewer.running = true
            residentViewerContainer.isActive = true
        }
        function onCloseResidentViewer()
        {
            animationCloseResidentViewer.running = true
            residentViewerContainer.isActive = false
        }
        function onResidentArchived()
        {
            backend.UpdateResidentTable()
            backend.UpdateArchivedResidentTable()

            animationCloseResidentViewer.running = true
            residentViewerContainer.isActive = false
        }

        // Resident Adder Functions
        function onOpenAddResident()
        {
            animationOpenAddResidentViewer.running = true
            addResidentViewerContainer.isActive = true
        }
        function onResidentAdded()
        {
            backend.UpdateResidentTable()
            animationCloseAddResidentViewer.running = true
            addResidentViewerContainer.isActive = false
        }
        function onCancelAddResident()
        {
            animationCloseAddResidentViewer.running = true
            addResidentViewerContainer.isActive = false
        }

        // Resident Editor Functions
        function onOpenEditResident(pk, sName, fName, mName, nameExt, age, gender, birthYear, birthMonth, birthDay, birthPlace, civilStatus, citizenship, lot, street, householdLot, householdBlock, position, regYear, regMonth, regDay, pwd, voter, mNumber, permanent, vaccine, booster, occupation)
        {
            animationOpenEditResidentViewer.running = true
            residentViewerContainer.isActive = false
            editResidentViewerContainer.isActive = true
        }
        function onCancelEditResident()
        {
            animationCloseEditResidentViewer.running = true
            editResidentViewerContainer.isActive = false
        }
        function onResidentEdited()
        {
            backend.UpdateResidentTable()
            animationCloseEditResidentViewer.running = true
            editResidentViewerContainer.isActive = false
        }

        // Archived Resident Functions
        function onOpenArchivedResident()
        {
            animationOpenArchivedResidentViewer.running = true
            archivedResidentViewerContainer.isActive = true
        }
        function onCloseArchivedResidentViewer()
        {
            animationCloseArchivedResidentViewer.running = true
            archivedResidentViewerContainer.isActive = false
        }

        // Residential Lot Functions
        function onOpenLotResidents(lot, block)
        {
            animationOpenResidentialLotViewer.running = true
            residentialLotViewerContainer.isActive = true
        }
        function onViewResidentFromLot()
        {
            animationOpenResidentViewerFromLot.running = true
            residentialLotViewerContainer.isActive = false
            residentViewerContainer.isActive = true
        }
        function onCloseLotResidents()
        {
            animationCloseResidentialLotViewer.running = true
            residentialLotViewerContainer.isActive = false
        }

        // Complaint Viewer Functions
        function onGetComplaint()
        {
            animationOpenComplaintViewer.running = true
            complaintViewerContainer.isActive = true
        }
        function onViewResidentFromComplaint()
        {
            animationOpenResidentViewerFromComplaint.running = true
            residentViewerContainer.isActive = true
            complaintViewerContainer.isActive = false
        }
        function onViewArchivedFromComplaint()
        {
            animationOpenArchivedViewerFromComplaint.running = true
            archivedResidentViewerContainer.isActive = true
            complaintViewerContainer.isActive = false
        }
        function onCloseComplaintViewer()
        {
            animationCloseComplaintViewer.running = true
            complaintViewerContainer.isActive = false
        }

        // Complaint Adder Functions
        function onOpenAddComplaint()
        {
            animationOpenAddComplaintViewer.running = true
            addComplaintViewerContainer.isActive = true
        }
        function onComplaintAdded()
        {
            backend.UpdateComplaintTable()
            animationCloseAddComplaintViewer.running = true
            addComplaintViewerContainer.isActive = false
        }
        function onCancelAddComplaint()
        {
            animationCloseAddComplaintViewer.running = true
            addComplaintViewerContainer.isActive = false
        }

        // Complaint Editor Functions
        function onOpenEditComplaint()
        {
            animationOpenEditComplaintViewer.running = true
            complaintViewerContainer.isActive = false
            editComplaintViewerContainer.isActive = true
        }
        function onCancelEditComplaint()
        {
            animationCloseEditComplaintViewer.running = true
            editComplaintViewerContainer.isActive = false
        }
        function onComplaintEdited()
        {
            backend.UpdateComplaintTable()
            animationCloseEditComplaintViewer.running = true
            editComplaintViewerContainer.isActive = false
        }

        // Blotter Viewer Functions
        function onGetBlotter()
        {
            animationOpenBlotterViewer.running = true
            blotterViewerContainer.isActive = true
        }
        function onViewResidentFromBlotter()
        {
            animationOpenResidentViewerFromBlotter.running = true
            residentViewerContainer.isActive = true
            blotterViewerContainer.isActive = false
        }
        function onViewArchivedFromBlotter()
        {
            animationOpenArchivedViewerFromBlotter.running = true
            archivedResidentViewerContainer.isActive = true
            blotterViewerContainer.isActive = false
        }
        function onCloseBlotterViewer()
        {
            animationCloseBlotterViewer.running = true
            blotterViewerContainer.isActive = false
        }

        // Blotter Adder Functions
        function onOpenAddBlotter()
        {
            animationOpenAddBlotterViewer.running = true
            addBlotterViewerContainer.isActive = true
        }
        function onBlotterAdded()
        {
            backend.UpdateBlotterTable()
            animationCloseAddBlotterViewer.running = true
            addBlotterViewerContainer.isActive = false
        }
        function onCancelAddBlotter()
        {
            animationCloseAddBlotterViewer.running = true
            addBlotterViewerContainer.isActive = false
        }

        // Borrowed Item Viewer Functions
        function onGetBorrowedItem()
        {
            animationOpenBorrowedItemViewer.running = true
            borrowedItemViewerContainer.isActive = true
        }
        function onViewResidentFromBorrowedItem()
        {
            animationOpenResidentViewerFromBorrowedItem.running = true
            residentViewerContainer.isActive = true
            borrowedItemViewerContainer.isActive = false
        }
        function onViewArchivedFromBorrowedItem()
        {
            animationOpenArchivedViewerFromBorrowedItem.running = true
            archivedResidentViewerContainer.isActive = true
            borrowedItemViewerContainer.isActive = false
        }
        function onCloseBorrowedItemViewer()
        {
            animationCloseBorrowedItemViewer.running = true
            borrowedItemViewerContainer.isActive = false
        }
        function onBorrowedItemReturned()
        {
            backend.UpdateItemTable()
            backend.UpdateBorrowedItemTable()
            animationCloseBorrowedItemViewer.running = true
            borrowedItemViewerContainer.isActive = false
        }

        // Borrowed Item Adder Functions
        function onOpenAddBorrowedItem()
        {
            animationOpenAddBorrowedItemViewer.running = true
            addBorrowedItemViewerContainer.isActive = true
        }
        function onBorrowedItemAdded()
        {
            backend.UpdateItemTable()
            backend.UpdateBorrowedItemTable()
            animationCloseAddBorrowedItemViewer.running = true
            addBorrowedItemViewerContainer.isActive = false
        }
        function onCancelAddBorrowedItem()
        {
            animationCloseAddBorrowedItemViewer.running = true
            addBorrowedItemViewerContainer.isActive = false
        }

        // Item Viewer Functions
        function onGetItem()
        {
            animationOpenItemViewer.running = true
            itemViewerContainer.isActive = true
        }
        function onCloseItemViewer()
        {
            animationCloseItemViewer.running = true
            itemViewerContainer.isActive = false
        }

        // Item Adder Functions
        function onOpenAddItem()
        {
            animationOpenAddItemViewer.running = true
            addItemViewerContainer.isActive = true
        }
        function onItemAdded()
        {
            backend.UpdateItemTable()
            animationCloseAddItemViewer.running = true
            addItemViewerContainer.isActive = false
        }
        function onCancelAddItem()
        {
            animationCloseAddItemViewer.running = true
            addItemViewerContainer.isActive = false
        }

        // Activity Viewer Functions
        function onGetActivity()
        {
            animationOpenActivityViewer.running = true
            activityViewerContainer.isActive = true
        }
        function onActivityEdited()
        {
            backend.UpdateActivityTable()
            animationCloseActivityViewer.running = true
            activityViewerContainer.isActive = false
        }
        function onCancelEditActivity()
        {
            animationCloseActivityViewer.running = true
            activityViewerContainer.isActive = false
        }
        
        // Activity Adder Functions
        function onOpenAddActivity()
        {
            animationOpenAddActivityViewer.running = true
            addActivityViewerContainer.isActive = true
        }
        function onActivityAdded()
        {
            backend.UpdateActivityTable()
            animationCloseAddActivityViewer.running = true
            addActivityViewerContainer.isActive = false
        }
        function onCancelAddActivity()
        {
            animationCloseAddActivityViewer.running = true
            addActivityViewerContainer.isActive = false
        }

        // Account Settings Functions
        function onViewAccountSettings()
        {
            animationOpenAccountViewer.running = true
            accountViewerContainer.isActive = true
        }
        function onAccountEdited()
        {
            backend.UpdateActivityTable()
            animationCloseAccountViewer.running = true
            accountViewerContainer.isActive = false
        }
        function onCancelEditAccount()
        {
            animationCloseAccountViewer.running = true
            accountViewerContainer.isActive = false
        }

        // Profile Picture
        function onPfpPickerActive(isActive)
        {
            if (isActive == true)
            {
                animationImagePickerActive.running = true
            }
            else
            {
                backend.UpdateOfficialsTable()
                animationImagePickerInactive.running = true
            }
        }

        // Print
        function onOpenPrintPanel(page)
        {
            if (page == "BGYCERTIFICATE")
            {
                animationOpenPrintBgyCertificate.running = true
                printBgyCertificateContainer.isActive = true
            }
            if (page == "BGYCLEARANCE")
            {
                animationOpenPrintBgyClearance.running = true
                printBgyClearanceContainer.isActive = true
            }
            if (page == "BGYCLEARANCEN"){}
            if (page == "BSNCLEARANCE")
            {
                animationOpenPrintBsnClearance.running = true
                printBsnClearanceContainer.isActive = true
            }
            if (page == "BGYINDIGENCY")
            {
                animationOpenPrintBgyIndigency.running = true
                printBgyIndigencyContainer.isActive = true
            }
        }

        function onClosePrintPanel(page)
        {
            if (page == "BGYCERTIFICATE")
            {
                animationClosePrintBgyCertificate.running = true
                printBgyCertificateContainer.isActive = false
            }
            if (page == "BGYCLEARANCE")
            {
                animationClosePrintBgyClearance.running = true
                printBgyClearanceContainer.isActive = false
            }
            if (page == "BGYCLEARANCEN"){}
            if (page == "BSNCLEARANCE")
            {
                animationClosePrintBsnClearance.running = true
                printBsnClearanceContainer.isActive = false
            }
            if (page == "BGYINDIGENCY")
            {
                animationClosePrintBgyIndigency.running = true
                printBgyIndigencyContainer.isActive = false
            }
        }
    }

    QtObject
    {
        id: internal

        function leftMenuSelect(btn)
        {
            if (btn.isActive == false)
            {
                btnDashboard.isActive = false
                btnManagement.isActive = false
                btnResidents.isActive = false
                btnMaps.isActive = false
                btnPrinting.isActive = false
                btnServices.isActive = false
                btnCases.isActive = false

                btn.isActive = true

                stackView.replace(Qt.resolvedUrl(btn.page))
            }
        }
        function closePanels()
        {            
            if (systemSettingsContainer.isActive == true)
            {
                backend.CloseSystemSettings()
            }
            if (residentViewerContainer.isActive == true)
            {
                backend.CloseResidentViewer()
            }
            if (addResidentViewerContainer.isActive == true)
            {
                backend.AddResidentCancelRequest()
            }
            if (editResidentViewerContainer.isActive == true)
            {
                backend.EditResidentCancelRequest()
            }
            if (archivedResidentViewerContainer.isActive == true)
            {
                backend.CloseArchivedResidentViewer()
            }
            if (residentialLotViewerContainer.isActive == true)
            {
                backend.CloseLotResidents()
            }
            if (complaintViewerContainer.isActive == true)
            {
                backend.CloseComplaintViewer()
            }
            if (addComplaintViewerContainer.isActive == true)
            {
                backend.AddComplaintCancelRequest()
            }
            if (editComplaintViewerContainer.isActive == true)
            {
                backend.EditComplaintCancelRequest()
            }
            if (blotterViewerContainer.isActive == true)
            {
                backend.CloseBlotterViewer()
            }
            if (addBlotterViewerContainer.isActive == true)
            {
                backend.AddBlotterCancelRequest()
            }
            if (borrowedItemViewerContainer.isActive == true)
            {
                backend.CloseBorrowedItemViewer()
            }
            if (addBorrowedItemViewerContainer.isActive == true)
            {
                backend.AddBorrowedItemCancelRequest()
            }
            if (itemViewerContainer.isActive == true)
            {
                backend.EditItemCancelRequest()
            }
            if (addItemViewerContainer.isActive == true)
            {
                backend.AddItemCancelRequest()
            }
            if (activityViewerContainer.isActive == true)
            {
                backend.EditActivityCancelRequest()
            }
            if (addActivityViewerContainer.isActive == true)
            {
                backend.AddActivityCancelRequest()
            }
            if (accountViewerContainer.isActive == true)
            {
                backend.EditAccountCancelRequest()
            }
            if (printBgyCertificateContainer.isActive == true)
            {
                backend.ClosePrintPanelRequest("BGYCERTIFICATE")
            }
            if (printBgyClearanceContainer.isActive == true)
            {
                backend.ClosePrintPanelRequest("BGYCLEARANCE")
            }
            if (printBsnClearanceContainer.isActive == true)
            {
                backend.ClosePrintPanelRequest("BSNCLEARANCE")
            }
            if (printBgyIndigencyContainer.isActive == true)
            {
                backend.ClosePrintPanelRequest("BGYINDIGENCY")
            }
        }
    }

    // Inactivity Timer
    Timer
    {
        interval: 1000
        running: true
        repeat: true
        onTriggered: backend.Timer()
    }

    //window controls
    ParallelAnimation
    {
        id: animationRestore
        NumberAnimation {target: appwindow; property: "width"; to: 1280; duration: 200; easing.type: Easing.OutQuint}
        NumberAnimation {target: appwindow; property: "height"; to: 720; duration: 200; easing.type: Easing.OutQuint}
        NumberAnimation {target: appwindow; property: "x"; to: Screen.width / 2 - 1280 / 2; duration: 200; easing.type: Easing.OutQuint}
        NumberAnimation {target: appwindow; property: "y"; to: Screen.height / 2 - 720 / 2; duration: 200; easing.type: Easing.OutQuint}
    }
    ParallelAnimation
    {
        id: animationMaximize
        NumberAnimation {target: appwindow; property: "width"; to: Screen.desktopAvailableWidth; duration: 200; easing.type: Easing.OutQuint}
        NumberAnimation {target: appwindow; property: "height"; to: Screen.desktopAvailableHeight; duration: 200; easing.type: Easing.OutQuint}
        NumberAnimation {target: appwindow; property: "x"; to: 0; duration: 200; easing.type: Easing.OutQuint}
        NumberAnimation {target: appwindow; property: "y"; to: 0; duration: 200; easing.type: Easing.OutQuint}
        PropertyAnimation {target: appwindow; property: "visibility"; to: Window.Maximized; duration: 200; easing.type: Easing.OutQuint}
    }

    Rectangle
    {
        id: imagePickerActive

        anchors.left: bg.left
        anchors.top: bg.bottom
        anchors.right: bg.right
        
        color: "#000000"
        height: bg.height
        opacity: 0

        z: 8

        ParallelAnimation
        {
            id: animationImagePickerActive

            PropertyAnimation {target: imagePickerActive; property: "anchors.top"; to: bg.top; duration: 0}
            PropertyAnimation {target: imagePickerActive; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationImagePickerInactive

            PropertyAnimation {target: imagePickerActive; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: imagePickerActive; property: "anchors.top"; to: bg.bottom; duration: 0}
        }
        MouseArea
        {
            anchors.fill: parent
            hoverEnabled: true

            onClicked: backend.CancelChangePFP()
        }
    }

    Rectangle
    {
        id: bg
        color: "#303030"
        border.color: "#202020"
        border.width: 1
        
        anchors.fill: parent
        
        z: 1

        Rectangle
        {
            id: topBar
            height: 30
            color: "#12151c"

            anchors.left: bg.left
            anchors.top: bg.top
            anchors.right: bg.right

            z: 7

            Image
            {
                id: toplogo
                width: topBar.height
                height: topBar.height
                anchors.left: topBar.left
                anchors.top: topBar.top
                anchors.leftMargin: 10

                source: "images/appicon.png"
            }
            Label
            {
                id: topBarLabel
                anchors.left: toplogo.right
                anchors.verticalCenter: topBar.verticalCenter
                anchors.leftMargin: 10
                text: qsTr("MIS")
                
                color: "white"
            }

            TopBarBtn
            {
                id: btnClose
                btnIcon: "../images/icons/close.png"
                btnHoverColor: "#ff3232"
                anchors.right: topBar.right

                MouseArea
                {
                    anchors.fill: parent
                    onClicked: appwindow.close()
                    cursorShape: Qt.PointingHandCursor
                }
            }
            TopBarBtn
            {
                id: btnMaximize
                btnIcon: "../images/icons/maximize2.png"
                anchors.right: btnClose.left

                MouseArea
                {
                    anchors.fill: parent
                    onClicked:
                    {
                        if (appwindow.visibility === 2)
                        {
                            animationMaximize.running = true
                            btnMaximize.btnIcon = "../images/icons/restore.png"
                        }
                        if (appwindow.visibility === 4)
                        {
                            appwindow.visibility = Window.Windowed
                            btnMaximize.btnIcon = "../images/icons/maximize2.png"
                            animationRestore.running = true
                        }
                    }
                    cursorShape: Qt.PointingHandCursor
                }
            }
            TopBarBtn
            {
                id: btnMinimize
                btnIcon: "../images/icons/minimize2.png"
                anchors.right: btnMaximize.left

                MouseArea
                {
                    anchors.fill: parent
                    onClicked: appwindow.visibility = Window.Minimized
                    cursorShape: Qt.PointingHandCursor
                }
            }
            
            MouseArea
            {
                property int offsetx: 0
                property int offsety: 0
                anchors.left: toplogo.right
                anchors.right: btnMinimize.left
                
                height: parent.height
                property variant clickPos: "1,1"

                onPressed:
                {
                    clickPos  = Qt.point(mouse.x, mouse.y)
                }

                onPositionChanged:
                {
                    var delta = Qt.point(mouse.x-clickPos.x, mouse.y-clickPos.y)
                    appwindow.x += delta.x;
                    appwindow.y += delta.y;
                }
            }
        }

        //Login
        Rectangle
        {
            id: login
            width: parent.width
            height: parent.height
            color: "#12151c"

            anchors.left: parent.left
            anchors.bottom: parent.bottom

            z: 6

            SequentialAnimation
            {
                id: animationOnLogin

                NumberAnimation {target: login; property: "anchors.bottomMargin"; to: bg.height; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: login; property: "anchors.bottom"; to: bg.top; duration: 0; easing.type: Easing.OutQuint}
                NumberAnimation {target: login; property: "anchors.bottomMargin"; to: 0; duration: 0; easing.type: Easing.OutQuint}
                
                onStarted:
                {
                    internal.leftMenuSelect(btnDashboard)
                    stackView.replace(Qt.resolvedUrl("pages/dashboardPage.qml"))
                    
                    sidePanel.width = 60
                    loggedIn = true
                }
            }
            SequentialAnimation
            {
                id: animationOnLogout
                
                NumberAnimation {target: login; property: "anchors.bottomMargin"; to: -bg.height; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: login; property: "anchors.bottom"; to: bg.bottom; duration: 0; easing.type: Easing.OutQuint}
                NumberAnimation {target: login; property: "anchors.bottomMargin"; to: 0; duration: 0; easing.type: Easing.OutQuint}

                onFinished:
                {
                    sidePanel.width = 60
                    loggedIn = false
                }
            }

            // Login Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }
            StackView
            {
                id: loginStackView
                anchors.fill: parent
                initialItem: Qt.resolvedUrl("pages/loginPage.qml")
            }
        }

        // Side Panel
        Rectangle
        {
            id: sidePanel
            width: 60
            color: "#1b222c"

            anchors.left: bg.left
            anchors.bottom: bg.bottom
            anchors.top: topBar.bottom

            clip: true
            z: 3
            
            PropertyAnimation
            {
                id: animationMenu
                target: sidePanel
                property: "width"
                to: if(sidePanel.width == 60) return 250; else return 60
                duration: 500
                easing.type: Easing.OutQuint
            }

            // Side Panel Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            LeftMenuBtn
            {
                id: btnMenu
                btnIcon: "../images/icons/menu.png"
                btnText: "<b>Menu</b>"

                anchors.left: parent.left
                anchors.top: parent.top
                anchors.bottomMargin: 20
                MouseArea
                {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: animationMenu.running = true
                }
            }
            
            Column
            {
                id: sidePanelMenu
                width: parent.width

                anchors.topMargin: 20
                anchors.top: btnMenu.bottom

                LeftMenuBtn
                {
                    id: btnDashboard
                    btnIcon: "../images/icons/home.png"
                    btnText: "Home | Dashboard"
                    page: "pages/dashboardPage.qml"
                    MouseArea
                    {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: internal.leftMenuSelect(btnDashboard)
                    }
                }
                LeftMenuBtn
                {
                    id: btnManagement
                    btnIcon: "../images/icons/laptop.png"
                    btnText: "Barangay Management"
                    page: "pages/managementPage.qml"
                    MouseArea
                    {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: internal.leftMenuSelect(btnManagement)
                    }
                }
                LeftMenuBtn
                {
                    id: btnResidents
                    btnIcon: "../images/icons/people.png"
                    btnText: "Residents"
                    page: "pages/residentsPage.qml"
                    MouseArea
                    {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: internal.leftMenuSelect(btnResidents)
                    }
                }
                LeftMenuBtn
                {
                    id: btnMaps
                    btnIcon: "../images/icons/location.png"
                    btnText: "Maps"
                    page: "pages/mapsPage.qml"
                    MouseArea
                    {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: internal.leftMenuSelect(btnMaps)
                    }
                }
                LeftMenuBtn
                {
                    id: btnPrinting
                    btnIcon: "../images/icons/print.png"
                    btnText: "Document Printing"
                    page: "pages/printingPage.qml"
                    MouseArea
                    {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: internal.leftMenuSelect(btnPrinting)
                    }
                }
                LeftMenuBtn
                {
                    id: btnServices
                    btnIcon: "../images/icons/services.png"
                    btnText: "Services"
                    page: "pages/servicesPage.qml"
                    MouseArea
                    {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: internal.leftMenuSelect(btnServices)
                    }
                }
                LeftMenuBtn
                {
                    id: btnCases
                    btnIcon: "../images/icons/logbook.png"
                    btnText: "Case Logbook"
                    page: "pages/casesPage.qml"
                    MouseArea
                    {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: internal.leftMenuSelect(btnCases)
                    }
                }
            }
            LeftMenuBtn
            {
                id: btnLogout
                btnIcon: "../images/icons/logout.png"
                btnText: "Logout"

                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                MouseArea
                {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: backend.Logout()
                }
            }
            LeftMenuBtn
            {
                id: btnSystem
                btnIcon: "../images/icons/settings.png"
                btnText: "System Settings"

                anchors.left: parent.left
                anchors.bottom: btnLogout.top
                MouseArea
                {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: backend.OpenSystemSettings()
                }
            }
        }

        // System Settings
        Rectangle
        {
            id: systemSettingsContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // System Settings Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            SystemSettings
            {
                id: sysSettings
                anchors.fill: parent
            }
        }
        
        // Resident Viewer
        Rectangle
        {
            id: residentViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Resident Viewer Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            ResidentViewer
            {
                id: resViewer
                anchors.fill: parent
            }
        }

        // Resident Adder
        Rectangle
        {
            id: addResidentViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Resident Adder Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            AddResidentViewer
            {
                id: addResViewer
                anchors.fill: parent
            }
        }

        // Resident Editor
        Rectangle
        {
            id: editResidentViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Resident Editor Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            EditResidentViewer
            {
                id: editResViewer
                anchors.fill: parent
            }
        }

        // Archived Resident Viewer
        Rectangle
        {
            id: archivedResidentViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Archived Resident Viewer Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            ArchivedResidentViewer
            {
                id: archivedResViewer
                anchors.fill: parent
            }
        }

        // Residential Lot Viewer
        Rectangle
        {
            id: residentialLotViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Residential Lot Viewer Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            ResidentialLotViewer
            {
                id: resLotViewer
                anchors.fill: parent
            }
        }

        // Complaint Viewer
        Rectangle
        {
            id: complaintViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Complaint Viewer Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            ComplaintViewer
            {
                id: comViewer
                anchors.fill: parent
            }
        }

        // Complaint Adder
        Rectangle
        {
            id: addComplaintViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Complaint Adder Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            AddComplaintViewer
            {
                id: addComViewer
                anchors.fill: parent
            }
        }

        // Complaint Editor
        Rectangle
        {
            id: editComplaintViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Complaint Editor Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            EditComplaintViewer
            {
                id: editComViewer
                anchors.fill: parent
            }
        }

        // Blotter Viewer
        Rectangle
        {
            id: blotterViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Blotter Viewer Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            BlotterViewer
            {
                id: bloViewer
                anchors.fill: parent
            }
        }

        // Blotter Adder
        Rectangle
        {
            id: addBlotterViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Blotter Adder Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            AddBlotterViewer
            {
                id: addBloViewer
                anchors.fill: parent
            }
        }

        // Borrowed Item Viewer
        Rectangle
        {
            id: borrowedItemViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Borrowed Item Viewer Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            BorrowedItemViewer
            {
                id: bitemViewer
                anchors.fill: parent
            }
        }

        // Borrowed Item Adder
        Rectangle
        {
            id: addBorrowedItemViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Borrowed Item Adder Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            AddBorrowedItemViewer
            {
                id: addBItemViewer
                anchors.fill: parent
            }
        }

        // Item Viewer
        Rectangle
        {
            id: itemViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Item Viewer Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            ItemViewer
            {
                id: itemViewer
                anchors.fill: parent
            }
        }

        // Item Adder
        Rectangle
        {
            id: addItemViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Item Adder Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            AddItemViewer
            {
                id: addItemViewer
                anchors.fill: parent
            }
        }

        // Activity Viewer
        Rectangle
        {
            id: activityViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Activity Viewer Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            ActivityViewer
            {
                id: actViewer
                anchors.fill: parent
            }
        }

        // Activity Adder
        Rectangle
        {
            id: addActivityViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Activity Adder Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            AddActivityViewer
            {
                id: addActViewer
                anchors.fill: parent
            }
        }

        // Account Settings
        Rectangle
        {
            id: accountViewerContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // Account Settings Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            AccountViewer
            {
                id: accViewer
                anchors.fill: parent
            }
        }

        // Print Barangay Certificate
        Rectangle
        {
            id: printBgyCertificateContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // // Print Barangay Certificate Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            PrintBgyCertificate
            {
                id: printBgyCertificate
                anchors.fill: parent
            }
        }

        // Print Barangay Clearance
        Rectangle
        {
            id: printBgyClearanceContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // // Print Barangay Clearance Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            PrintBgyClearance
            {
                id: printBgyClearance
                anchors.fill: parent
            }
        }

        // Print Business Clearance
        Rectangle
        {
            id: printBsnClearanceContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // // Print Business Clearance Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            PrintBsnClearance
            {
                id: printBsnClearance
                anchors.fill: parent
            }
        }

        // Print Barangay Indigency
        Rectangle
        {
            id: printBgyIndigencyContainer

            property bool isActive: false

            color: "#1b222c"
            width: 700
            anchors.left: bg.right
            anchors.top: contentPages.top
            anchors.bottom: bg.bottom
            anchors.leftMargin: 0

            z: 5

            // // Print Barangay Indigency Mouse Event Eater
            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true
            }

            PrintBgyIndigency
            {
                id: printBgyIndigency
                anchors.fill: parent
            }
        }

        // Viewer Mouse Event Eater
        Rectangle
        {
            id: viewerMouseEater

            anchors.left: bg.left
            anchors.top: contentPages.bottom
            anchors.right: bg.right
            
            color: "#000000"
            height: contentPages.height
            opacity: 0

            z: 4

            MouseArea
            {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: internal.closePanels()
            }
        }

        // System Settings Animation
        ParallelAnimation
        {
            id: animationOpenSystemSettings

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: systemSettingsContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseSystemSettings

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: systemSettingsContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Resident Viewer Animation
        ParallelAnimation
        {
            id: animationOpenResidentViewer

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: residentViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseResidentViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: residentViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Resident Adder Animation
        ParallelAnimation
        {
            id: animationOpenAddResidentViewer

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: addResidentViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseAddResidentViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: addResidentViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Resident Editor Animation
        ParallelAnimation
        {
            id: animationOpenEditResidentViewer

            PropertyAnimation {target: residentViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: editResidentViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseEditResidentViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: editResidentViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Archived Resident Viewer Animation
        ParallelAnimation
        {
            id: animationOpenArchivedResidentViewer

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: archivedResidentViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseArchivedResidentViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: archivedResidentViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Residential Lot Viewer Animation
        ParallelAnimation
        {
            id: animationOpenResidentialLotViewer

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: residentialLotViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        ParallelAnimation
        {
            id: animationOpenResidentViewerFromLot

            PropertyAnimation {target: residentialLotViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: residentViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseResidentialLotViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: residentialLotViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Complaint Viewer Animation
        ParallelAnimation
        {
            id: animationOpenComplaintViewer

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: complaintViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        ParallelAnimation
        {
            id: animationOpenResidentViewerFromComplaint

            PropertyAnimation {target: complaintViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: residentViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        ParallelAnimation
        {
            id: animationOpenArchivedViewerFromComplaint

            PropertyAnimation {target: complaintViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: archivedResidentViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseComplaintViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: complaintViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Complaint Adder Animation
        ParallelAnimation
        {
            id: animationOpenAddComplaintViewer

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: addComplaintViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseAddComplaintViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: addComplaintViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Complaint Editor Animation
        ParallelAnimation
        {
            id: animationOpenEditComplaintViewer

            PropertyAnimation {target: complaintViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: editComplaintViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseEditComplaintViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: editComplaintViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Blotter Viewer Animation
        ParallelAnimation
        {
            id: animationOpenBlotterViewer

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: blotterViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        ParallelAnimation
        {
            id: animationOpenResidentViewerFromBlotter

            PropertyAnimation {target: blotterViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: residentViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        ParallelAnimation
        {
            id: animationOpenArchivedViewerFromBlotter

            PropertyAnimation {target: blotterViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: archivedResidentViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseBlotterViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: blotterViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Blotter Adder Animation
        ParallelAnimation
        {
            id: animationOpenAddBlotterViewer

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: addBlotterViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseAddBlotterViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: addBlotterViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Borrowed Item Viewer Animation
        ParallelAnimation
        {
            id: animationOpenBorrowedItemViewer

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: borrowedItemViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        ParallelAnimation
        {
            id: animationOpenResidentViewerFromBorrowedItem

            PropertyAnimation {target: borrowedItemViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: residentViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        ParallelAnimation
        {
            id: animationOpenArchivedViewerFromBorrowedItem

            PropertyAnimation {target: borrowedItemViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: archivedResidentViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseBorrowedItemViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: borrowedItemViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Borrowed Item Adder Animation
        ParallelAnimation
        {
            id: animationOpenAddBorrowedItemViewer

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: addBorrowedItemViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseAddBorrowedItemViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: addBorrowedItemViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Item Viewer Animation
        ParallelAnimation
        {
            id: animationOpenItemViewer

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: itemViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseItemViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: itemViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Item Adder Animation
        ParallelAnimation
        {
            id: animationOpenAddItemViewer

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: addItemViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseAddItemViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: addItemViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Activity Viewer Animation
        ParallelAnimation
        {
            id: animationOpenActivityViewer

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: activityViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseActivityViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: activityViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Activity Adder Animation
        ParallelAnimation
        {
            id: animationOpenAddActivityViewer

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: addActivityViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseAddActivityViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: addActivityViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Account Settings Animation
        ParallelAnimation
        {
            id: animationOpenAccountViewer

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: accountViewerContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationCloseAccountViewer

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: accountViewerContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Print Barangay Certificate Animation
        ParallelAnimation
        {
            id: animationOpenPrintBgyCertificate

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: printBgyCertificateContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationClosePrintBgyCertificate

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: printBgyCertificateContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Print Barangay Clearance Animation
        ParallelAnimation
        {
            id: animationOpenPrintBgyClearance

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: printBgyClearanceContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationClosePrintBgyClearance

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: printBgyClearanceContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Print Business Clearance Animation
        ParallelAnimation
        {
            id: animationOpenPrintBsnClearance

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: printBsnClearanceContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationClosePrintBsnClearance

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: printBsnClearanceContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Print Barangay Indigency Animation
        ParallelAnimation
        {
            id: animationOpenPrintBgyIndigency

            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.top; duration: 0}
            PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0.5; duration: 500; easing.type: Easing.OutQuint}
            PropertyAnimation {target: printBgyIndigencyContainer; property: "anchors.leftMargin"; to: -700; duration: 500; easing.type: Easing.OutQuint}
        }
        SequentialAnimation
        {
            id: animationClosePrintBgyIndigency

            ParallelAnimation
            {
                PropertyAnimation {target: viewerMouseEater; property: "opacity"; to: 0; duration: 500; easing.type: Easing.OutQuint}
                PropertyAnimation {target: printBgyIndigencyContainer; property: "anchors.leftMargin"; to: 0; duration: 500; easing.type: Easing.OutQuint}
            }
            PropertyAnimation {target: viewerMouseEater; property: "anchors.top"; to: contentPages.bottom; duration: 0}
        }

        // Content Pages
        Rectangle
        {
            id: contentPages
            color: "#191d26"

            anchors.left: bg.left
            anchors.top: topBar.bottom
            anchors.right: bg.right
            anchors.bottom: bg.bottom

            anchors.leftMargin: 60
            z: 2

            StackView
            {
                id: stackView
                anchors.fill: parent
                initialItem: Qt.resolvedUrl("pages/dashboard.qml")
            }
        }
    }
}