import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
import "../../controls"

Rectangle
{
    id: systemViewer

    width: 700
    color: "#1b222c"

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    QtObject
    {
        id: internal
    }
    Connections
    {
        target: backend
        function onLogin(bool, pk, resPK, position)
        {
            if (bool === true && position != "None")
            {
                if (pk == 0)
                {
                    btnBackup.enabled = false
                    btnRestore.enabled = false
                }
                else
                {
                    btnBackup.enabled = true
                    btnRestore.enabled = true
                }
            }
        }
        function onOpenSystemSettings(auditString)
        {
            lblAudit.text = auditString
        }
        function onCloseSystemSettings()
        {
            lblBackedup.visible = false
            lblExported.visible = false
        }
        function onBackupData(returnStr)
        {
            if (returnStr == "DATA BACKUP")
            {
                backupVerifyPass.popFunc = "DATA BACKUP"
                backupVerifyPass.open()
            }
            else
            {
                backupVerifyPass.popFunc = "DATA RESTORE"
                backupVerifyPass.open()
            }
        }
        function onVerifyPassword(bool, returnStr)
        {
            if (bool == true && returnStr == "DATA BACKUP")
            {
                backend.BackupDatabase()
                lblBackedup.visible = true
            }
            if (bool == true && returnStr == "DATA RESTORE")
            {
                backend.RestoreDatabase()
            }
        }
        function onExportAudit()
        {
            backend.ExportAudit()
            lblExported.visible = true
        }
    }

    Rectangle
    {
        id: rectTitleBar

        color: "#12171f"
        height: 50

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right

        anchors.margins: 10

        Label
        {
            id: lblTitleBar

            text: qsTr("<b>System Settings</b>")
            color: "#ffffff"
            font.pixelSize: 17
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
    }

    Rectangle
    {
        id: rectAccountInfo

        color: "#12171f"
        anchors.left: parent.left
        anchors.top: rectTitleBar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        anchors.margins: 10

        ScrollView
        {
            id: infoContainer

            anchors.fill: parent
            anchors.bottomMargin: 100
            contentHeight: 330

            
        }

        Label
        {
            id: lblBackupTitle
            text: qsTr("<b><i>Backup and Restore</i></b>")
            color: "#ffffff"
            font.pixelSize: 17
            
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.margins: 20
        }
        Button
        {
            id: btnBackup
            text: "Backup Data"

            anchors.left: parent.left
            anchors.top: lblBackupTitle.bottom
            anchors.margins: 20

            onClicked:
            {
                backupPopup.popText = "You are about to create a backup of the system's current data. Continue?"
                backupPopup.popWarningText = "Your last backup file will be deleted and replaced by this one."
                backupPopup.popFunc = "DATA BACKUP"
                backupPopup.open()
            }
        }
        Button
        {
            id: btnRestore
            text: "Restore Data"

            anchors.left: btnBackup.right
            anchors.verticalCenter: btnBackup.verticalCenter
            anchors.margins: 20

            onClicked:
            {
                backupPopup.popText = "You are about to restore the last backup data and replace the current system's data. Proceeding with this action will log you out of the system. Continue?"
                backupPopup.popWarningText = "Current system's data will be lost and replaced by the backup data."
                backupPopup.popFunc = "DATA RESTORE"
                backupPopup.open()
            }
        }
        Label
        {
            id: lblBackedup
            text: qsTr("<i>Data successfully backed up.</i>")
            color: "#ffffff"
            visible: false
            
            anchors.verticalCenter: btnBackup.verticalCenter
            anchors.left: btnRestore.right
            anchors.margins: 20
        }
        Label
        {
            id: lblAuditTitle
            text: qsTr("<b><i>Audit Log</i></b>")
            color: "#ffffff"
            font.pixelSize: 17
            
            anchors.top: btnBackup.bottom
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.topMargin: 40
        }
        
        Rectangle
        {
            id: rectAudit
            color: "#1b222c"

            anchors.left: parent.left
            anchors.top: lblAuditTitle.bottom
            anchors.right: parent.right
            anchors.bottom: btnExportAudit.top
            anchors.leftMargin: 20
            anchors.topMargin: 20
            anchors.rightMargin: 50
            anchors.bottomMargin: 20

            ScrollView
            {
                id: scrollAudit
                
                anchors.fill: parent
                anchors.margins: 5

                Label
                {
                    id: lblAudit

                    font.family: "Courier New"
                    text: qsTr("")
                    color: "#ffffff"
                    font.pixelSize: 16
                    width: rectAudit.width - 40

                    anchors.left: parent.left
                    anchors.top: parent.top

                    wrapMode: Label.WordWrap
                }
            }
        }
        Button
        {
            id: btnExportAudit
            text: "Export Audit Log"

            anchors.right: parent.right
            anchors.bottom: btnBack.top

            anchors.bottomMargin: 20
            anchors.rightMargin: 50
            onClicked: exportPopup.open()
        }
        Label
        {
            id: lblExported
            text: qsTr("<i>Audit log exported on user0/Documents.</i>")
            color: "#ffffff"
            visible: false
            
            anchors.verticalCenter: btnExportAudit.verticalCenter
            anchors.right: btnExportAudit.left
            anchors.margins: 20
        }

        // Bottom Controls
        Button
        {
            id: btnBack
            text: "Back"

            anchors.left: parent.left
            anchors.bottom: parent.bottom

            anchors.margins: 20

            onClicked: backend.CloseSystemSettings()
        }
    }
    CustomPopup
    {
        id: exportPopup
        popText: "Export a current copy of the audit log to this computer?"
        popFunc: "EXPORT AUDIT LOG"
    }
    CustomPopup
    {
        id: backupPopup

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"
        
        isWarning: true
    }
    VerifyPasswordPopup
    {
        id: backupVerifyPass
    }
}