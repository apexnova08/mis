import os
import sqlite3
import timer
import printdocx
import misc

import datetime as DateTime
from datetime import date
from datetime import datetime
import shutil
from tkinter.filedialog import askopenfilename
import os.path

from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QObject, Slot, Signal

dbPath = directory = os.getcwd() + "\mis\mis.db"

class LoggedIn:
    def __init__(self, pk, resPK, user):
        self.pk = pk
        self.resPK = resPK
        self.user = user

class Backend(QObject):

    def __init__(self):
        QObject.__init__(self)

    PFPClass = misc.PFP()

    loggedIn = LoggedIn

    login = Signal(bool, int, int, str)
    logout = Signal()
    systemTimeOut = Signal()
    forgotPassword = Signal()
    openRegisterPanel = Signal(str, str, str, str)
    usernameExists = Signal(bool)
    registerOfficialAccount = Signal()
    accountRegistered = Signal()
    gotoLogin = Signal()
    getSecurityQuestions = Signal(str, str)
    checkSecurityQuestions = Signal(bool)
    recoverAccount = Signal()
    viewAccountSettings = Signal(int, str, str, str, str)
    editAccountCancelRequest = Signal()
    cancelEditAccount = Signal()
    editAccountRequest = Signal()
    accountEdited = Signal()

    # Popup Resident Table
    getPopupResidents = Signal(int, str, str, str, str, str, str)
    destroyPopupResidentTable = Signal()
    popupResidentTableReturn = Signal(str, str, str)

    # System
    openSystemSettings = Signal(str)
    closeSystemSettings= Signal()
    backupData = Signal(str)
    exportAudit = Signal()

    # Residents Page
    getResidents = Signal(int, str, str, str, str)
    getArchivedResidents = Signal(int, str, str, str, str)
    destroyResidentTable = Signal(str)
    getResidentAddress = Signal(str, str, str)

    # Resident Viewer
    getResident = Signal(int, str, str, str, str, str, str, int, int, int, str, str, str, str, str, str, str, str, int, int, int, str, str, str, str, str, str, str, str, str)
    residentViewerChanged = Signal()
    closeResidentViewer = Signal()

    # Redundancy Checker
    residentExists = Signal(bool, str)
    houseHeadExists = Signal(bool, str)
    replaceHeadAdd = Signal()
    replaceHeadEdit = Signal()

    # Add Resident
    openAddResident = Signal()
    getCurrentYear = Signal(int)
    addResidentCancelRequest = Signal()
    cancelAddResident = Signal()
    addResident = Signal()
    residentAdded = Signal()

    # Edit Resident
    openEditResident = Signal(int, str, str, str, str, int, str, int, int, int, str, str, str, str, str, str, str, str, int, int, int, str, str, str, str, str, str, str, str, str)
    editResidentCancelRequest = Signal()
    editResident = Signal()
    cancelEditResident = Signal()
    residentEdited = Signal()

    # Archive Resident
    archiveResident = Signal()
    residentArchived = Signal()
    getArchivedResident = Signal(int, str, str, str, str, int, str, str, str, str, str, str, str, str, str, str, str, str, str, str, str, str, str, str, str, str)
    openArchivedResident = Signal()
    closeArchivedResidentViewer = Signal()

    # Resident Lot
    openLotResidents = Signal(str, str)
    getLotHead = Signal(int, str, str)
    getLotResidents = Signal(int, str, str)
    destroyResidentialLot = Signal()
    viewResidentFromLot = Signal()
    closeLotResidents = Signal()

    # Complaints Table
    getComplaints = Signal(int, str, str, str, str)
    destroyComplaintTable = Signal()

    # Complaint Viewer
    getComplaint = Signal(int, str, str, str, str, str, str, str, str, str, str, str, str, str, str)
    viewResidentFromComplaint = Signal()
    viewArchivedFromComplaint = Signal()
    closeComplaintViewer = Signal()

    # Add Complaint
    openAddComplaint = Signal()
    addComplaintCancelRequest = Signal()
    addComplaint = Signal()
    cancelAddComplaint = Signal()
    complaintAdded = Signal()

    # Edit Complaint
    openEditComplaint = Signal(int, str, str, str, str, str, str, str, str, str, str, str, str)
    editComplaintCancelRequest = Signal()
    cancelEditComplaint = Signal()
    editComplaint = Signal()
    complaintEdited = Signal()

    # Blotter Table
    getBlotters = Signal(int, str, str, str)
    destroyBlotterTable = Signal()

    # Blotter Viewer
    getBlotter = Signal(int, str, str, str, str, str, str, str)
    viewResidentFromBlotter = Signal()
    viewArchivedFromBlotter = Signal()
    closeBlotterViewer = Signal()

    # Add Blotter
    openAddBlotter = Signal()
    addBlotterCancelRequest = Signal()
    addBlotter = Signal()
    cancelAddBlotter = Signal()
    blotterAdded = Signal()

    # Borrowed Items Table
    getBorrowedItems = Signal(int, str, str, str, str, str)
    destroyBorrowedItemsTable = Signal()

    # Borrowed Item Viewer
    getBorrowedItem = Signal(int, str, str, str, str, str, str, str, str)
    viewResidentFromBorrowedItem = Signal()
    viewArchivedFromBorrowedItem = Signal()
    closeBorrowedItemViewer = Signal()
    returnBorrowedItem = Signal()
    borrowedItemReturned = Signal()

    # Add Borrowed Item
    openAddBorrowedItem = Signal(list, list, list)
    addBorrowedItemCancelRequest = Signal()
    addBorrowedItem = Signal()
    cancelAddBorrowedItem = Signal()
    borrowedItemAdded = Signal()

    # Items Table
    getItems = Signal(int, str, int, int)
    destroyItemsTable = Signal()

    # Item Viewer
    getItem = Signal(int, str, int, int)
    editItemCancelRequest = Signal()
    closeItemViewer = Signal()
    editItem = Signal()

    # Add Item
    openAddItem = Signal()
    addItemCancelRequest = Signal()
    addItem = Signal()
    cancelAddItem = Signal()
    itemAdded = Signal()

    # Officials
    getOfficials = Signal(int, int, str, str, bool)
    destroyOfficialTable = Signal()
    addOfficial = Signal(str)
    getOfficialPosition = Signal(str, str)
    officialHasAccount = Signal(bool, str, int, str)
    editOfficials = Signal()
    cancelEditOfficials = Signal()
    verifyPassword = Signal(bool, str)
    officialDismissRequest = Signal(str)
    turnOverRequest = Signal()
    pfpPickerActive = Signal(bool)

    # Archived Officials
    getArchivedOfficials = Signal(int, str, str, str)
    destroyArchivedOfficialsTable = Signal()

    # Barangay Info
    getBarangayInfo = Signal(str, str, str)
    barangayCancelEdit = Signal()
    editBarangay = Signal()

    # Activities
    getActivities = Signal(int, str, str)
    getActivity = Signal(int, str, str, int, int, str, str)
    destroyActivityTable = Signal()

    # Edit Activity
    editActivityCancelRequest = Signal()
    cancelEditActivity = Signal()
    editActivity = Signal()
    activityEdited = Signal()

    # Add Activity
    openAddActivity = Signal()
    addActivityCancelRequest = Signal()
    cancelAddActivity = Signal()
    addActivity = Signal()
    activityAdded = Signal()

    # Dashboard
    dGetAccountInfo = Signal(str, str)
    dGetBarangayInfo = Signal(str, str, str)
    dGetOfficials = Signal(int, int, str, str, bool)
    dGetActivitiesT = Signal(str)
    dGetActivitiesU = Signal(str, str)
    dGetDemographics = Signal(str, str, str, str, str, str, str, str, str)

    # Print
    openPrintPanel = Signal(str)
    closePrintPanelRequest = Signal(str)
    closePrintPanel = Signal(str)
    printDocument = Signal(str)

    @Slot(str, str)
    def Login(self, strUser, strPass):
        b = False
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM accounts WHERE acUser =  '" + strUser + "' AND acPass = '" + strPass + "'")
        for x in cursor:
            LoggedIn.pk = str(x[0])
            LoggedIn.resPK = x[1]
            LoggedIn.user = x[4]

            b = True
            self.login.emit(b, x[0], x[1], x[3])
        if (b == False):
            self.login.emit(b, 0, 0, '')
        db.close()

    @Slot()
    def Logout(self):
        self.logout.emit()

    @Slot()
    def Timer(self):
        if (timer.get_idle_duration() >= 300):
            self.cancelEditAccount.emit()
            self.cancelAddResident.emit()
            self.cancelEditResident.emit()
            self.cancelAddComplaint.emit()
            self.cancelEditComplaint.emit()
            self.cancelAddBlotter.emit()
            self.cancelAddBorrowedItem.emit()
            self.cancelEditOfficials.emit()
            self.barangayCancelEdit.emit()
            self.cancelEditActivity.emit()
            self.cancelAddActivity.emit()
            self.systemTimeOut.emit()
            self.closePrintPanel.emit("BGYCERTIFICATE")
            self.closePrintPanel.emit("BGYCLEARANCE")
            self.closePrintPanel.emit("BSNCLEARANCE")
            self.closePrintPanel.emit("BGYINDIGENCY")

    @Slot()
    def ForgotPassword(self):
        self.forgotPassword.emit()

    @Slot(str)
    def CheckIfUsernameExists(self, username):
        b = False
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT COUNT(*) FROM accounts WHERE acUser = '" + username + "'")
        for x in cursor:
            if (x[0] > 0):
                b = True
        self.usernameExists.emit(b)
        db.close()

    @Slot(str, str, str, str, str, str, str, str, str, str)
    def RegisterOfficialAccount(self, turnOver, pk, name, position, username, password, q1, a1, q2, a2):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        if (turnOver == "YES"):
            cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Turned over the system to " + name + "')")
            db.commit()
            cursor.execute("SELECT * FROM officials")
            c = list(cursor)
            for x in c:
                cursor.execute("INSERT INTO officials_archived (oaResPK, oaName, oaPosition, oaEDate, oaDDate) VALUES (" + str(x[1]) + ", '" + x[2] + "', '" + x[3] + "', '" + x[4] + "', '" + str(date.today()) + "')")
                db.commit()
                cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Dismissed " + x[2] + " from their position as " + GetGUIPosition(x[3]) + "')")
                db.commit()
            cursor.execute("DELETE FROM officials")
            db.commit()
            cursor.execute("DELETE FROM accounts WHERE NOT acPK = 0")
            db.commit()
        cursor.execute("INSERT INTO accounts (acResPK, acName, acPosition, acUser, acPass, acSecQ1, acSecA1, acSecQ2, acSecA2) VALUES (" + str(pk) + ", '" + name + "', '" + GetDBPosition(position) + "', '" + username + "', '" + password + "', '" + q1 + "', '" + a1 + "', '" + q2 + "', '" + a2 + "')")
        db.commit()
        cursor.execute("INSERT INTO officials (oResPK, oName, oPosition, oDate) VALUES (" + str(pk) + ", '" + name + "', '" + GetDBPosition(position) + "', '" + str(date.today()) + "')")
        db.commit()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + username + "', 'Created account as " +  GetGUIPosition(GetDBPosition(position)) + " (" + name + ")')")
        db.commit()
        self.gotoLogin.emit()
        db.close()

    @Slot(str)
    def GetSecurityQuestions(self, username):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM accounts WHERE acUser = '" + username + "'")
        for x in cursor:
            self.getSecurityQuestions.emit(x[6], x[8])
        db.close()

    @Slot(str, str, str)
    def CheckSecurityQuestions(self, username, a1, a2):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT COUNT(*) FROM accounts WHERE acUser = '" + username + "' AND acSecA1 LIKE '" + a1 + "' AND acSecA2 LIKE '" + a2 + "'")
        for x in cursor:
            if (x[0] > 0):
                self.checkSecurityQuestions.emit(True)
            else:
                self.checkSecurityQuestions.emit(False)
        db.close()

    @Slot(str, str)
    def ChangeOfficialPassword(self, username, password):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("UPDATE accounts SET acPass = '" + password + "' WHERE acUser = '" + username + "'")
        db.commit()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + username + "', 'Forgot their password and successfully updated it')")
        db.commit()
        db.close()
        self.gotoLogin.emit()

    @Slot(int)
    def ViewAccountSettings(self, pk):
        aUser = ""
        aPass = ""
        bUser = ""
        bPass = ""
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM accounts")
        for x in cursor:
            if (int(x[0]) == pk):
                aUser = x[4]
                aPass = x[5]
            if (int(x[0]) == 0):
                bUser = x[4]
                bPass = x[5]
        self.viewAccountSettings.emit(pk, aUser, aPass, bUser, bPass)
        db.close()

    @Slot()
    def EditAccountCancelRequest(self):
        self.editAccountCancelRequest.emit()

    @Slot(int, str, str, str, str)
    def EditAccount(self, pk, aUser, aPass, bUser, bPass):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("UPDATE accounts SET acUser = '" + aUser + "', acPass = '" + aPass + "' WHERE acPK = " + str(pk))
        db.commit()
        cursor.execute("UPDATE accounts SET acUser = '" + bUser + "', acPass = '" + bPass + "' WHERE acPK = 0")
        db.commit()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Updated their account successfully')")
        db.commit()
        db.close()
        self.accountEdited.emit()

    @Slot(int, str, str)
    def VerifyPassword(self, pk, password, returnStr):
        b = False
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT COUNT(*) FROM accounts WHERE acPK = '" + str(pk) + "' AND acPass = '" + password + "'")
        for x in cursor:
            if (x[0] > 0):
                b = True
        self.verifyPassword.emit(b, returnStr)
        db.close()

    #Popup Functions
    @Slot(str)
    def PopupFunc(self, returnStr):
        if (returnStr == "REPLACE HEAD ADD"):
            self.replaceHeadAdd.emit()
        if (returnStr == "REPLACE HEAD EDIT"):
            self.replaceHeadEdit.emit()

        if (returnStr == "RESIDENT ADD"):
            self.addResident.emit()
        if (returnStr == "RESIDENT CANCEL ADD"):
            self.cancelAddResident.emit()
        if (returnStr == "RESIDENT EDIT"):
            self.editResident.emit()
        if (returnStr == "RESIDENT CANCEL EDIT"):
            self.cancelEditResident.emit()
        if (returnStr == "RESIDENT ARCHIVE"):
            self.archiveResident.emit()

        if (returnStr == "COMPLAINT ADD"):
            self.addComplaint.emit()
        if (returnStr == "COMPLAINT CANCEL ADD"):
            self.cancelAddComplaint.emit()
        if (returnStr == "COMPLAINT EDIT"):
            self.editComplaint.emit()
        if (returnStr == "COMPLAINT CANCEL EDIT"):
            self.cancelEditComplaint.emit()
        if (returnStr == "BLOTTER ADD"):
            self.addBlotter.emit()
        if (returnStr == "BLOTTER CANCEL ADD"):
            self.cancelAddBlotter.emit()

        if (returnStr == "BORROWED ITEM RETURN"):
            self.returnBorrowedItem.emit()
        if (returnStr == "BORROWED ITEM ADD"):
            self.addBorrowedItem.emit()
        if (returnStr == "BORROWED ITEM CANCEL ADD"):
            self.cancelAddBorrowedItem.emit()

        if (returnStr == "ITEM ADD"):
            self.addItem.emit()
        if (returnStr == "ITEM CANCEL ADD"):
            self.cancelAddItem.emit()
        if (returnStr == "ITEM EDIT"):
            self.editItem.emit()
        if (returnStr == "ITEM CANCEL EDIT"):
            self.closeItemViewer.emit()

        if (returnStr.split(" ")[0] == "OFFICIAL" and returnStr.split(" ")[1] == "ADD"):
            self.addOfficial.emit(returnStr)
        if (returnStr.split(" ")[0] == "OFFICIAL" and returnStr.split(" ")[1] == "CREATE" and returnStr.split(" ")[2] == "ACCOUNT"):
            strArray = returnStr.split(" ")
            y = 0
            for x in strArray:
                if (y > 5):
                    strArray[5] = strArray[5] + " " + x
                y = y + 1
            db = sqlite3.connect(dbPath)
            cursor = db.cursor()
            cursor.execute("SELECT * FROM residents WHERE resPK = " + str(strArray[4]))
            for x in cursor:
                self.openRegisterPanel.emit(strArray[3], strArray[4], strArray[5], FMSNameConvert(x[1], x[2], x[3], x[4]))
            db.close()
        if (returnStr == "OFFICIAL ACCOUNT ADD"):
            self.registerOfficialAccount.emit()
        if (returnStr == "ACCOUNT RECOVER"):
            self.recoverAccount.emit()
        if (returnStr == "GOTO LOGIN"):
            self.gotoLogin.emit()
        if (returnStr.startswith("OFFICIAL DISMISS REQUEST ") == True):
            self.officialDismissRequest.emit(returnStr)
        if (returnStr == "TURNOVER SYSTEM REQUEST"):
            self.turnOverRequest.emit()
        if (returnStr == "BARANGAY CANCEL EDIT"):
            self.barangayCancelEdit.emit()
        if (returnStr == "BARANGAY EDIT"):
            self.editBarangay.emit()
        if (returnStr == "ACTIVITY CANCEL EDIT"):
            self.cancelEditActivity.emit()
        if (returnStr == "ACTIVITY EDIT"):
            self.editActivity.emit()
        if (returnStr == "ACTIVITY CANCEL ADD"):
            self.cancelAddActivity.emit()
        if (returnStr == "ACTIVITY ADD"):
            self.addActivity.emit()
        if (returnStr == "ACCOUNT CANCEL EDIT"):
            self.cancelEditAccount.emit()
        if (returnStr == "ACCOUNT EDIT"):
            self.editAccountRequest.emit()
        if (returnStr.startswith("DATA") == True):
            self.backupData.emit((returnStr))
        if (returnStr == "EXPORT AUDIT LOG"):
            self.exportAudit.emit()
        
        if (returnStr.split(" ")[0] == "PRINT" and returnStr.split(" ")[1] == "CANCEL"):
            self.closePrintPanel.emit(returnStr.split(" ")[2])
        if (returnStr.split(" ")[0] == "PRINT" and returnStr.split(" ")[1] != "CANCEL"):
            self.printDocument.emit(returnStr.split(" ")[1])
    
    @Slot(str, int, str, str, str, str)
    def PopupResidentTableReturn(self, typeString, pk, sName, fName, mName, nameExt):
        if (typeString.split(" ")[0] == "OFFICIAL" or typeString.split(" ")[0] == "PRINT"):
            self.popupResidentTableReturn.emit(typeString, str(pk), FMSNameConvert(sName, fName, mName, nameExt))
        else:
            self.popupResidentTableReturn.emit(typeString, str(pk), SFMNameConvert(sName, fName, mName, nameExt))

    @Slot()
    def GetPopupResidents(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM residents ORDER BY resSName ASC, resFName ASC, resMName ASC")
        for x in cursor:
            self.getPopupResidents.emit(x[0], x[1], x[2], x[3], x[4], x[6][0], str(x[5]))
        db.close()
    
    @Slot()
    def DestroyPopupResidentTable(self):
        self.destroyPopupResidentTable.emit()

    @Slot(str)
    def SearchPopupResident(self, searchString):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        self.destroyPopupResidentTable.emit()
        cursor.execute(searchString)
        for x in cursor:
            nameExt = ""
            if (x[4] != ""):
                nameExt = " " + x[4]
            self.getPopupResidents.emit(x[0], x[1], x[2], x[3], nameExt, x[6][0], str(x[5]))
        db.close()

    @Slot()
    def OpenSystemSettings(self):
        auditString= ""
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM audit ORDER BY adPK DESC")
        for x in cursor:
            auditString = auditString + "[" + x[2] + "]" + "[" + x[3] + "]" + "[" + x[1] + "]" + "[" + x[4] + "]" + "[" + x[5] + "]\n"
        db.close()
        self.openSystemSettings.emit(auditString)
    
    @Slot()
    def BackupDatabase(self):
        shutil.copy(os.getcwd() + "\mis\mis.db", os.getcwd() + "\mis\\db\\backup.db")

    @Slot()
    def RestoreDatabase(self):
        shutil.copy(os.getcwd() + "\mis\\db\\backup.db", os.getcwd() + "\mis\mis.db")
        self.closeSystemSettings.emit()
        self.logout.emit()

    @Slot()
    def ExportAudit(self):
        f = open(os.path.join(os.path.join(os.environ['USERPROFILE']), 'Documents') + "\\audit log " + GetNowString() + ".txt","w+")
        auditString= ""
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM audit ORDER BY adPK DESC")
        for x in cursor:
            auditString = auditString + "[" + x[2] + "]" + "[" + x[3] + "]" + "[" + x[1] + "]" + "[" + x[4] + "]" + "[" + x[5] + "]\n"
        f.write(auditString)
        db.close()
        f.close()

    @Slot()
    def CloseSystemSettings(self):
        self.closeSystemSettings.emit()

    @Slot()
    def GetResidents(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM residents ORDER BY resSName ASC, resFName ASC, resMName ASC")
        for x in cursor:
            self.getResidents.emit(x[0], x[1], x[2] + " " + x[4], x[3], x[11] + " " + x[12] + " street")
        db.close()

    @Slot(str, str)
    def GetResidentAddress(self, pk, typeString):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM residents WHERE resPK = " + pk)
        for x in cursor:
            self.getResidentAddress.emit(pk, x[11] + " " + x[12] + " Street", typeString)
        db.close()

    @Slot(int)
    def GetResident(self, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM residents WHERE resPK = " + str(pk))
        for x in cursor:
            bdate = datetime.strptime(x[7], '%Y-%m-%d')
            rdate = datetime.strptime(x[16], '%Y-%m-%d')
            self.getResident.emit(x[0], x[1], x[2], x[3], x[4], str(x[5]), x[6], int(bdate.strftime('%Y')), int(bdate.strftime('%m')), int(bdate.strftime('%d')), x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15], int(rdate.strftime('%Y')), int(rdate.strftime('%m')), int(rdate.strftime('%d')), x[17], x[18], x[19], x[20], x[21], x[22], x[23], x[24], x[25])
        db.close()
        self.residentViewerChanged.emit()

    @Slot()
    def GetArchivedResidents(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM archived_residents ORDER BY aresSName ASC, aresFName ASC, aresMName ASC")
        for x in cursor:
            adate = x[17].split("-")
            self.getArchivedResidents.emit(x[0], x[1], x[2] + " " + x[4], x[3], GetMonth(adate[1]) + " " + adate[2] + ", " + adate[0])
        db.close()

    @Slot()
    def CloseResidentViewer(self):
        self.closeResidentViewer.emit()

    @Slot()
    def UpdateResidentTable(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        self.destroyResidentTable.emit("RESIDENT")
        cursor.execute("SELECT * FROM residents ORDER BY resSName ASC, resFName ASC, resMName ASC")
        for x in cursor:
            self.getResidents.emit(x[0], x[1], x[2] + " " + x[4], x[3], x[11] + " " + x[12] + " street")
        db.close()

    @Slot(str, str, str, int)
    def checkHeadIfExists(self, block, lot, typeString, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT COUNT(*) FROM residents WHERE resHouseholdBlock = '" + block + "' AND resHouseholdLot = '" + lot + "' AND resHead = 'Yes' AND NOT resPK = " + str(pk))
        for x in cursor:
            if (x[0] > 0):
                self.houseHeadExists.emit(True, typeString)
            else:
                self.houseHeadExists.emit(False, typeString)
        db.close()
    
    @Slot(str, str, str, str, str, str)
    def CheckResIfExists(self, sName, fName, mname, bDate, bPlace, typeString):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT COUNT(*) FROM residents WHERE resSName = '" + sName + "' AND resFName = '" + fName + "' AND resMName = '" + mname + "' AND resBirthDate = '" + bDate + "' AND resBirthPlace = '" + bPlace + "'")
        for x in cursor:
            if (x[0] > 0):
                self.residentExists.emit(True, typeString)
            else:
                self.residentExists.emit(False, typeString)
        db.close()

    @Slot()
    def OpenAddResidentPanel(self):
        self.openAddResident.emit()

    @Slot()
    def GetCurrentYear(self):
        self.getCurrentYear.emit(date.today().year)

    @Slot()
    def AddResidentCancelRequest(self):
        self.addResidentCancelRequest.emit()

    @Slot(str, str, str, str, str, str, str, str, str, str, str, str, str, str, str, str, str, str, str, str, str, str, str, str, str)
    def AddResident(self, sName, fName, mName, nameExt, age, gender, bMonth, bDay, bYear, bPlace, civilStatus, citizenship, pwd, voter, lot, street, hLot, hBlock, mNumber, permanent, vaccine, booster, occupation, head, pensioner):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        if (head == "Yes"):
            cursor.execute("SELECT * FROM residents WHERE resHouseholdBlock = '" + hBlock + "' AND resHouseholdLot = '" + hLot + "' AND resHead = 'Yes'")
            for x in cursor:
                cursor.execute("UPDATE residents SET resHead = 'No' WHERE resPK = " + str(x[0]) + ";")
                db.commit()
        cursor.execute("INSERT INTO residents (resSName, resFName, resMName, resNameExt, resAge, resGender, resBirthDate, resBirthPlace, resCivilStatus, resCitizenship, resLot, resStreet, resHouseholdLot, resHouseholdBlock, resPosition, resDateRegistered, resPWD, resVoter, resMNumber, resPerm, resVaccine, resBooster, resOccupation, resHead, resPensioner) VALUES ('" + sName + "', '" + fName + "', '" + mName + "', '" + nameExt + "', '" + age + "', '" + gender + "', '" + bYear + "-" + bMonth + "-" + bDay + "', '" + bPlace + "', '" + civilStatus + "', '" + citizenship + "', '" + lot + "', '" + street + "', '" + hLot + "', '" + hBlock + "', 'Resident', '" + str(date.today()) + "', '" + pwd + "', '" + voter + "', '" + mNumber + "', '" + permanent + "', '" + vaccine + "', '" + booster + "', '" + occupation + "', '" + head + "', '" + pensioner + "')")
        db.commit()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Added resident " + SFMNameConvert(sName, fName, mName, nameExt) + "')")
        db.commit()
        db.close()
        self.residentAdded.emit()

    @Slot(int, str, str, str, str, str, str, int, int, int, str, str, str, str, str, str, str, str, int, int, int, str, str, str, str, str, str, str, str, str)
    def OpenEditResidentPanel(self, pk, sName, fName, mName, nameExt, age, gender, birthYear, birthMonth, birthDay, birthPlace, civilStatus, citizenship, lot, street, householdLot, householdBlock, position, regYear, regMonth, regDay, pwd, voter, mNumber, permanent, vaccine, booster, occupation, head, pensioner):
        self.openEditResident.emit(pk, sName, fName, mName, nameExt, int(age), gender, birthYear, birthMonth, birthDay, birthPlace, civilStatus, citizenship, lot, street, householdLot, householdBlock, position, regYear, regMonth, regDay, pwd, voter, mNumber, permanent, vaccine, booster, occupation, head, pensioner)

    @Slot()
    def EditResidentCancelRequest(self):
        self.editResidentCancelRequest.emit()

    @Slot(str, str, str, str, str, str, str, str, int)
    def EditResident(self, stringQuery, head, hLot, hBlock, sName, fName, mName, nameExt, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        if (head == "Yes"):
            cursor.execute("SELECT * FROM residents WHERE resHouseholdBlock = '" + hBlock + "' AND resHouseholdLot = '" + hLot + "' AND resHead = 'Yes'")
            for x in cursor:
                cursor.execute("UPDATE residents SET resHead = 'No' WHERE resPK = " + str(x[0]) + ";")
                db.commit()
        cursor.execute(stringQuery)
        db.commit()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Updated resident " + SFMNameConvert(sName, fName, mName, nameExt) + " [" + str(pk) + "]')")
        db.commit()
        db.close()
        self.residentEdited.emit()

    @Slot(int, str)
    def ArchiveResident(self, pk, reason):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM residents WHERE resPK = " + str(pk))
        for x in cursor:
            cursor.execute("INSERT INTO archived_residents (aResPK, aresSName, aresFName, aresMName, aresNameExt, aresAge, aresGender, aresBirthDate, aresBirthPlace, aresCivilStatus, aresCitizenship, aresLot, aresStreet, aresHouseholdLot, aresHouseholdBlock, aresPosition, aresDateRegistered, aresDateArchived, aresPWD, aresVoter, aresMNumber, aresPerm, aresVaccine, aresBooster, aresOccupation, aresReason) VALUES (" + str(x[0]) + ", '" + x[1] + "', '" + x[2] + "', '" + x[3] + "', '" + x[4] + "', '" + str(x[5]) + "', '" + x[6] + "', '" + x[7] + "', '" + x[8] + "', '" + x[9] + "', '" + x[10] + "', '" + x[11] + "', '" + x[12] + "', '" + x[13] + "', '" + x[14] + "', '" + x[15] + "', '" + x[16] + "', '" + str(date.today()) + "', '" + x[17] + "', '" + x[18] + "', '" + x[19] + "', '" + x[20] + "', '" + x[21] + "', '" + x[22] + "', '" + x[23] + "', '" + reason + "')")
            db.commit()
            cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Archived resident " + SFMNameConvert(x[1], x[2], x[3], x[4]) + " [" + str(pk) + "]')")
            db.commit()
        cursor.execute("DELETE FROM residents WHERE resPK = " + str(pk))
        db.commit()
        db.close()
        self.residentArchived.emit()
    
    @Slot(int)
    def GetArchivedResident(self, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM archived_residents WHERE aresPK = " + str(pk))
        for x in cursor:
            bdate = x[7].split("-")
            rdate = x[16].split("-")
            adate = x[17].split("-")
            self.getArchivedResident.emit(x[0], x[1], x[2], x[3], x[4], x[5], x[6], GetMonth(bdate[1]) + " " + bdate[2] + ", " + bdate[0], x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15], GetMonth(rdate[1]) + " " + rdate[2] + ", " + rdate[0], GetMonth(adate[1]) + " " + adate[2] + ", " + adate[0], x[18], x[19], x[20], x[21], x[22], x[23], x[24], x[25])
        db.close()
        self.openArchivedResident.emit()

    @Slot()
    def CloseArchivedResidentViewer(self):
        self.closeArchivedResidentViewer.emit()

    @Slot()
    def UpdateArchivedResidentTable(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        self.destroyResidentTable.emit("ARCHIVED")
        cursor.execute("SELECT * FROM archived_residents ORDER BY aresSName ASC, aresFName ASC, aresMName ASC")
        for x in cursor:
            bdate = x[17].split("-")
            self.getArchivedResidents.emit(x[0], x[1], x[2] + " " + x[4], x[3], GetMonth(bdate[1]) + " " + bdate[2] + ", " + bdate[0])
        db.close()

    @Slot(int)
    def GetResidentBoth(self, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM residents WHERE resPK = " + str(pk))
        for x in cursor:
            bdate = datetime.strptime(x[7], '%Y-%m-%d')
            rdate = datetime.strptime(x[16], '%Y-%m-%d')
            self.getResident.emit(x[0], x[1], x[2], x[3], x[4], str(x[5]), x[6], int(bdate.strftime('%Y')), int(bdate.strftime('%m')), int(bdate.strftime('%d')), x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15], int(rdate.strftime('%Y')), int(rdate.strftime('%m')), int(rdate.strftime('%d')), x[17], x[18], x[19], x[20], x[21], x[22], x[23], x[24], x[25])
            self.residentViewerChanged.emit()
        cursor.execute("SELECT * FROM archived_residents WHERE aresPK = " + str(pk))
        for x in cursor:
            bdate = x[7].split("-")
            rdate = x[16].split("-")
            adate = x[17].split("-")
            self.getArchivedResident.emit(x[0], x[1], x[2], x[3], x[4], x[5], x[6], GetMonth(bdate[1]) + " " + bdate[2] + ", " + bdate[0], x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15], GetMonth(rdate[1]) + " " + rdate[2] + ", " + rdate[0], GetMonth(adate[1]) + " " + adate[2] + ", " + adate[0], x[18], x[19], x[20], x[21], x[22], x[23], x[24], x[25])
        db.close()

    @Slot(str)
    def SearchResident(self, searchString):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        self.destroyResidentTable.emit("RESIDENT")
        cursor.execute(searchString +  " ORDER BY resSName ASC, resFName ASC, resMName ASC")
        for x in cursor:
            self.getResidents.emit(x[0], x[1], x[2] + " " + x[4], x[3], x[11] + " " + x[12] + " street")
        db.close()
    
    @Slot(str)
    def SearchArchivedResident(self, searchString):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        self.destroyResidentTable.emit("ARCHIVED")
        cursor.execute(searchString  +  " ORDER BY aresSName ASC, aresFName ASC, aresMName ASC")
        for x in cursor:
            bdate = x[17].split("-")
            self.getArchivedResidents.emit(x[0], x[1], x[2] + " " + x[4], x[3], GetMonth(bdate[1]) + " " + bdate[2] + ", " + bdate[0])
        db.close()
    
    @Slot(str, str)
    def GetLotResidents(self, lot, block):
        self.destroyResidentialLot.emit()
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM residents WHERE resHouseholdLot = '" + lot + "' AND resHouseholdBlock = '" + block + "' AND resHead = 'Yes'")
        for x in cursor:
            self.getLotHead.emit(x[0], x[1] + ", " + x[2] + " " + x[4] + " " + x[3], x[6] + ", " + str(x[5]) + " years old")
        cursor.execute("SELECT * FROM residents WHERE resHouseholdLot = '" + lot + "' AND resHouseholdBlock = '" + block + "' AND resHead = 'No' ORDER BY resSName ASC, resFName ASC, resMName ASC")
        for x in cursor:
            self.getLotResidents.emit(x[0], x[1] + ", " + x[2] + " " + x[4] + " " + x[3], x[6] + ", " + str(x[5]) + " years old")
        db.close()
        self.openLotResidents.emit(lot, block)

    @Slot(int)
    def GetLotResident(self, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM residents WHERE resPK = " + str(pk))
        for x in cursor:
            bdate = datetime.strptime(x[7], '%Y-%m-%d')
            rdate = datetime.strptime(x[16], '%Y-%m-%d')
            self.getResident.emit(x[0], x[1], x[2], x[3], x[4], str(x[5]), x[6], int(bdate.strftime('%Y')), int(bdate.strftime('%m')), int(bdate.strftime('%d')), x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15], int(rdate.strftime('%Y')), int(rdate.strftime('%m')), int(rdate.strftime('%d')), x[17], x[18], x[19], x[20], x[21], x[22], x[23], x[24], x[25])
        db.close()
        self.viewResidentFromLot.emit()

    @Slot()
    def CloseLotResidents(self):
        self.closeLotResidents.emit()

    @Slot()
    def GetComplaints(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM complaints ORDER BY comDate DESC, comStatus DESC")
        for x in cursor:
            self.getComplaints.emit(x[0], x[1], x[2], x[10], x[11])
        db.close()
    
    @Slot()
    def UpdateComplaintTable(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        self.destroyComplaintTable.emit()
        cursor.execute("SELECT * FROM complaints ORDER BY comDate DESC, comStatus DESC")
        for x in cursor:
            self.getComplaints.emit(x[0], x[1], x[2], x[10], x[11])
        db.close()

    @Slot(int)
    def GetComplaint(self, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM complaints WHERE comPK = " + str(pk))
        for x in cursor:
            m1Date = ""
            m2Date = ""
            m3Date = ""
            cDate = x[3].split("-")

            if (x[5] != ""):
                m1Date = GetMonth(x[5].split("-")[1]) + " " + x[5].split("-")[2] + ", " + x[5].split("-")[0]
            if (x[7] != ""):
                m2Date = GetMonth(x[7].split("-")[1]) + " " + x[7].split("-")[2] + ", " + x[7].split("-")[0]
            if (x[9] != ""):
                m3Date = GetMonth(x[9].split("-")[1]) + " " + x[9].split("-")[2] + ", " + x[9].split("-")[0]
            self.getComplaint.emit(x[0], x[1], x[2], GetMonth(cDate[1]) + " " + cDate[2] + ", " + cDate[0], x[4], m1Date, x[6], m2Date, x[8], m3Date, x[10], x[11], x[12], x[13], x[14])
        db.close()

    @Slot(str)
    def ViewResidentFromComplaint(self, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM residents WHERE resPK = " + str(pk))
        for x in cursor:
            bdate = datetime.strptime(x[7], '%Y-%m-%d')
            rdate = datetime.strptime(x[16], '%Y-%m-%d')
            self.getResident.emit(x[0], x[1], x[2], x[3], x[4], str(x[5]), x[6], int(bdate.strftime('%Y')), int(bdate.strftime('%m')), int(bdate.strftime('%d')), x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15], int(rdate.strftime('%Y')), int(rdate.strftime('%m')), int(rdate.strftime('%d')), x[17], x[18], x[19], x[20], x[21], x[22], x[23], x[24], x[25])
            self.viewResidentFromComplaint.emit()
        cursor.execute("SELECT * FROM archived_residents WHERE aresPK = " + str(pk))
        for x in cursor:
            bdate = x[7].split("-")
            rdate = x[16].split("-")
            adate = x[17].split("-")
            self.getArchivedResident.emit(x[0], x[1], x[2], x[3], x[4], x[5], x[6], GetMonth(bdate[1]) + " " + bdate[2] + ", " + bdate[0], x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15], GetMonth(rdate[1]) + " " + rdate[2] + ", " + rdate[0], GetMonth(adate[1]) + " " + adate[2] + ", " + adate[0], x[18], x[19], x[20], x[21], x[22], x[23], x[24], x[25])
            self.viewArchivedFromComplaint.emit()
        db.close()

    @Slot()
    def CloseComplaintViewer(self):
        self.closeComplaintViewer.emit()

    @Slot()
    def OpenAddComplaintPanel(self):
        self.openAddComplaint.emit()

    @Slot()
    def AddComplaintCancelRequest(self):
        self.addComplaintCancelRequest.emit()

    @Slot(str, str, str, str, str, str)
    def AddComplaint(self, complainant, defendant, title, details, comPK, defPK):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("INSERT INTO complaints (comComplainant, comDefendant, comDate, comMeet1, comMeet1Date, comMeet2, comMeet2Date, comMeet3, comMeet3Date, comStatus, comTitle, comDetails, comCPK, comDPK) VALUES ('" + complainant + "', '" + defendant + "', '" + str(date.today()) + "', '', '', '', '', '', '', 'Unsettled', '" + title + "', '" + details + "', '" + comPK + "', '" + defPK + "')")
        db.commit()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Filed a complaint " + title + " for " + complainant + " against " + defendant + "')")
        db.commit()
        db.close()
        self.complaintAdded.emit()

    @Slot(int)
    def OpenEditComplaintPanel(self, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM complaints WHERE comPK = " + str(pk))
        for x in cursor:
            m1Date = ""
            m2Date = ""
            m3Date = ""
            cDate = x[3].split("-")

            if (x[5] != ""):
                m1Date = GetMonth(x[5].split("-")[1]) + " " + x[5].split("-")[2] + ", " + x[5].split("-")[0]
            if (x[7] != ""):
                m2Date = GetMonth(x[7].split("-")[1]) + " " + x[7].split("-")[2] + ", " + x[7].split("-")[0]
            if (x[9] != ""):
                m3Date = GetMonth(x[9].split("-")[1]) + " " + x[9].split("-")[2] + ", " + x[9].split("-")[0]
            self.openEditComplaint.emit(x[0], x[1], x[2], GetMonth(cDate[1]) + " " + cDate[2] + ", " + cDate[0], x[4], m1Date, x[6], m2Date, x[8], m3Date, x[10], x[11], x[12])
        db.close()

    @Slot()
    def EditComplaintCancelRequest(self):
        self.editComplaintCancelRequest.emit()

    @Slot(int, str, str, str)
    def EditComplaint(self, pk, details, meet, meetVal):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        if (meet == ""):
            cursor.execute("UPDATE complaints SET" + details[:-1] + " WHERE comPK = " + str(pk) + ";")
        elif (meetVal == "Unsettled"):
            cursor.execute("UPDATE complaints SET" + details + " " + meet + " = 'Unsettled', " + meet + "Date = '" + str(date.today()) + "' WHERE comPK = " + str(pk) + ";")
        elif (meetVal == "Settled" or meetVal == "Filed for action"):
            cursor.execute("UPDATE complaints SET" + details + " " + meet + " = '" + meetVal + "', " + meet + "Date = '" + str(date.today()) + "', comStatus = '" + meetVal + "' WHERE comPK = " + str(pk) + ";")
        db.commit()
        cursor.execute("SELECT * FROM complaints WHERE comPK = " + str(pk))
        for x in cursor:
            cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Updated complaint " + x[11] + " for " + x[1] + " against " + x[2] + "')")
            db.commit()
        db.close()
        self.complaintEdited.emit()

    @Slot(str)
    def SearchComplaint(self, searchString):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        self.destroyComplaintTable.emit()
        cursor.execute(searchString + " ORDER BY comDate DESC, comStatus DESC")
        for x in cursor:
            self.getComplaints.emit(x[0], x[1], x[2], x[10], x[11])
        db.close()

    @Slot()
    def GetBlotters(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM blotters ORDER BY bloDate DESC")
        for x in cursor:
            blDate = x[4].split("-")
            self.getBlotters.emit(x[0], x[2], GetMonth(blDate[1]) + " " + blDate[2] + ", " + blDate[0], x[5])
        db.close()

    @Slot()
    def UpdateBlotterTable(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        self.destroyBlotterTable.emit()
        cursor.execute("SELECT * FROM blotters ORDER BY bloDate DESC")
        for x in cursor:
            blDate = x[4].split("-")
            self.getBlotters.emit(x[0], x[2], GetMonth(blDate[1]) + " " + blDate[2] + ", " + blDate[0], x[5])
        db.close()

    @Slot(int)
    def GetBlotter(self, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM blotters WHERE bloPK = " + str(pk))
        for x in cursor:
            blDate = x[4].split("-")
            self.getBlotter.emit(x[0], x[1], x[2], x[3], GetMonth(blDate[1]) + " " + blDate[2] + ", " + blDate[0], x[5], x[6], x[7])
        db.close()

    @Slot(int)
    def ViewResidentFromBlotter(self, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM residents WHERE resPK = " + str(pk))
        for x in cursor:
            bdate = datetime.strptime(x[7], '%Y-%m-%d')
            rdate = datetime.strptime(x[16], '%Y-%m-%d')
            self.getResident.emit(x[0], x[1], x[2], x[3], x[4], str(x[5]), x[6], int(bdate.strftime('%Y')), int(bdate.strftime('%m')), int(bdate.strftime('%d')), x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15], int(rdate.strftime('%Y')), int(rdate.strftime('%m')), int(rdate.strftime('%d')), x[17], x[18], x[19], x[20], x[21], x[22], x[23], x[24], x[25])
            self.viewResidentFromBlotter.emit()
        cursor.execute("SELECT * FROM archived_residents WHERE aresPK = " + str(pk))
        for x in cursor:
            bdate = x[7].split("-")
            rdate = x[16].split("-")
            adate = x[17].split("-")
            self.getArchivedResident.emit(x[0], x[1], x[2], x[3], x[4], x[5], x[6], GetMonth(bdate[1]) + " " + bdate[2] + ", " + bdate[0], x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15], GetMonth(rdate[1]) + " " + rdate[2] + ", " + rdate[0], GetMonth(adate[1]) + " " + adate[2] + ", " + adate[0], x[18], x[19], x[20], x[21], x[22], x[23], x[24], x[25])
            self.viewArchivedFromBlotter.emit()
        db.close()

    @Slot()
    def CloseBlotterViewer(self):
        self.closeBlotterViewer.emit()

    @Slot()
    def OpenAddBlotterPanel(self):
        self.openAddBlotter.emit()

    @Slot()
    def AddBlotterCancelRequest(self):
        self.addBlotterCancelRequest.emit()

    @Slot(str, str, str, str, str, str)
    def AddBlotter(self, resPK, suspect, submitter, title, details, subPK):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("INSERT INTO blotters (bloResPK, bloSuspect, bloSubmitter, bloDate, bloTitle, bloDetails, bloSubPK) VALUES ('" + resPK + "', '" + suspect + "', '" + submitter + "', '" + str(date.today()) + "', '" + title + "', '" + details + "', '" + subPK + "')")
        db.commit()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Recorded a blotter " + title + " for " + submitter + " against " + suspect + "')")
        db.commit()
        db.close()
        self.blotterAdded.emit()

    @Slot(str)
    def SearchBlotter(self, searchString):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        self.destroyBlotterTable.emit()
        cursor.execute(searchString + " ORDER BY bloDate DESC")
        for x in cursor:
            blDate = x[4].split("-")
            self.getBlotters.emit(x[0], x[2], GetMonth(blDate[1]) + " " + blDate[2] + ", " + blDate[0], x[5])
        db.close()

    @Slot()
    def GetBorrowedItems(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM bitems ORDER BY bStatus ASC, bDate ASC")
        for x in cursor:
            biDate = x[3].split("-")
            self.getBorrowedItems.emit(x[0], x[5], x[1], str(x[2]), x[4], GetMonth(biDate[1]) + " " + biDate[2] + ", " + biDate[0])
        db.close()

    @Slot()
    def UpdateBorrowedItemTable(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        self.destroyBorrowedItemsTable.emit()
        cursor.execute("SELECT * FROM bitems ORDER BY bStatus ASC, bDate ASC")
        for x in cursor:
            biDate = x[3].split("-")
            self.getBorrowedItems.emit(x[0], x[5], x[1], str(x[2]), x[4], GetMonth(biDate[1]) + " " + biDate[2] + ", " + biDate[0])
        db.close()

    @Slot(int)
    def GetBorrowedItem(self, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM bitems WHERE bPK = " + str(pk))
        for x in cursor:
            biDate = x[3].split("-")
            status = x[4]
            if (status == "Returned"):
                d = x[8].split("-")
                status = x[4] + " on " + GetMonth(d[1]) + " " + d[2] + ", " + d[0]
            self.getBorrowedItem.emit(x[0], x[1], str(x[2]), GetMonth(biDate[1]) + " " + biDate[2] + ", " + biDate[0], status, x[5], x[6], x[7], x[9])
        db.close()

    @Slot()
    def CloseBorrowedItemViewer(self):
        self.closeBorrowedItemViewer.emit()

    @Slot(int)
    def ViewResidentFromBorrowedItem(self, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM residents WHERE resPK = " + str(pk))
        for x in cursor:
            bdate = datetime.strptime(x[7], '%Y-%m-%d')
            rdate = datetime.strptime(x[16], '%Y-%m-%d')
            self.getResident.emit(x[0], x[1], x[2], x[3], x[4], str(x[5]), x[6], int(bdate.strftime('%Y')), int(bdate.strftime('%m')), int(bdate.strftime('%d')), x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15], int(rdate.strftime('%Y')), int(rdate.strftime('%m')), int(rdate.strftime('%d')), x[17], x[18], x[19], x[20], x[21], x[22], x[23], x[24], x[25])
            self.viewResidentFromBorrowedItem.emit()
        cursor.execute("SELECT * FROM archived_residents WHERE aresPK = " + str(pk))
        for x in cursor:
            bdate = x[7].split("-")
            rdate = x[16].split("-")
            adate = x[17].split("-")
            self.getArchivedResident.emit(x[0], x[1], x[2], x[3], x[4], x[5], x[6], GetMonth(bdate[1]) + " " + bdate[2] + ", " + bdate[0], x[8], x[9], x[10], x[11], x[12], x[13], x[14], x[15], GetMonth(rdate[1]) + " " + rdate[2] + ", " + rdate[0], GetMonth(adate[1]) + " " + adate[2] + ", " + adate[0], x[18], x[19], x[20], x[21], x[22], x[23], x[24], x[25])
            self.viewArchivedFromBorrowedItem.emit()
        db.close()

    @Slot(int, str, int)
    def ReturnBorrowedItem(self, pk, ipk, bamount):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("UPDATE bitems SET bStatus = 'Returned', bRDate = '" + str(date.today()) + "' WHERE bPK = " + str(pk))
        db.commit()
        cursor.execute("UPDATE items SET iCAmount = iCAmount - " + str(bamount) + " WHERE iPK = " + str(ipk))
        db.commit()
        db.close()
        self.borrowedItemReturned.emit()

    @Slot()
    def OpenAddBorrowedItemPanel(self):
        pks = []
        items = []
        amounts = []
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM items WHERE iAmount > 0 ORDER BY iName ASC")
        for x in cursor:
            pks.append(x[0])
            items.append(x[1])
            amounts.append(x[2] - x[3])
        db.close()
        self.openAddBorrowedItem.emit(pks, items, amounts)

    @Slot()
    def AddBorrowedItemCancelRequest(self):
        self.addBorrowedItemCancelRequest.emit()

    @Slot(str, str, str, str, str, int, str)
    def AddBorrowedItem(self, item, quantity, borrower, resPK, remarks, ipk, bamount):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("INSERT INTO bitems (bItem, bQuantity, bDate, bStatus, bResName, bResPK, bRemarks, bRDate, biPK) VALUES ('" + item + "', '" + quantity + "', '" + str(date.today()) + "', 'Not yet returned', '" + borrower + "', '" + resPK + "', '" + remarks + "', '', '" + str(ipk) + "')")
        db.commit()
        cursor.execute("UPDATE items SET iCAmount = iCAmount + " + bamount + " WHERE iPK = " + str(ipk))
        db.commit()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Lent " + quantity + " " + item + " to " + borrower + "')")
        db.commit()
        db.close()
        self.borrowedItemAdded.emit()

    @Slot(str)
    def SearchBorrowedItem(self, searchString):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        self.destroyBorrowedItemsTable.emit()
        cursor.execute(searchString + " ORDER BY bStatus ASC, bDate ASC")
        for x in cursor:
            biDate = x[3].split("-")
            self.getBorrowedItems.emit(x[0], x[5], x[1], str(x[2]), x[4], GetMonth(biDate[1]) + " " + biDate[2] + ", " + biDate[0])
        db.close()

    @Slot()
    def GetItems(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM items ORDER BY iName ASC")
        for x in cursor:
            self.getItems.emit(x[0], x[1], x[2], x[2] - x[3])
        db.close()

    @Slot()
    def UpdateItemTable(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        self.destroyItemsTable.emit()
        cursor.execute("SELECT * FROM items ORDER BY iName ASC")
        for x in cursor:
            self.getItems.emit(x[0], x[1], x[2], x[2] - x[3])
        db.close()

    @Slot(int)
    def GetItem(self, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM items WHERE iPK = " + str(pk))
        for x in cursor:
            self.getItem.emit(x[0], x[1], x[2], x[3])
        db.close()

    @Slot()
    def EditItemCancelRequest(self):
        self.editItemCancelRequest.emit()

    @Slot(int, str, str, bool)
    def EditItem(self, pk, item, amount, nameChanged):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        oldName = ""
        cursor.execute("SELECT * FROM items WHERE iPK = " + str(pk))
        for x in cursor:
            oldName = x[1]
        cursor.execute("UPDATE items SET iName = '" + item + "', iAmount = " + amount + " WHERE iPK = " + str(pk))
        db.commit()
        if (nameChanged == True):
            cursor.execute("UPDATE bitems SET bItem = '" + item + "' WHERE biPK = " + str(pk))
            db.commit()
            cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Updated Item (" + oldName + " - now " + item + ") data')")
            db.commit()
        else:
            cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Updated Item (" + oldName + ") data')")
            db.commit()
        self.UpdateBorrowedItemTable()
        self.UpdateItemTable()
        self.closeItemViewer.emit()
        db.close()

    @Slot()
    def OpenAddItemPanel(self):
        self.openAddItem.emit()
    
    @Slot()
    def AddItemCancelRequest(self):
        self.addItemCancelRequest.emit()

    @Slot(str, str)
    def AddItem(self, item, amount):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("INSERT INTO items (iName, iAmount, iCAmount) VALUES ('" + item + "', " + amount + ", 0)")
        db.commit()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Added a new Item (" + item + ")')")
        db.commit()
        self.UpdateItemTable()
        self.itemAdded.emit()
        db.close()

    @Slot(str)
    def SearchItem(self, searchString):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        self.destroyItemsTable.emit()
        cursor.execute(searchString + " ORDER BY iName ASC")
        for x in cursor:
            self.getItems.emit(x[0], x[1], x[2], x[2] - x[3])
        db.close()

    @Slot()
    def GetOfficials(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM officials")
        for x in cursor:
            hasPFP = False
            if (os.path.exists("mis/pfp/" + str(x[1]) + ".png") == True):
                hasPFP = True
            self.getOfficials.emit(x[0], x[1], x[2], x[3], hasPFP)
        db.close()

    @Slot()
    def UpdateOfficialsTable(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        self.destroyOfficialTable.emit()
        cursor.execute("SELECT * FROM officials")
        for x in cursor:
            hasPFP = False
            if (os.path.exists("mis/pfp/" + str(x[1]) + ".png") == True):
                hasPFP = True
            self.getOfficials.emit(x[0], x[1], x[2], x[3], hasPFP)
        db.close()

    @Slot(int, str)
    def GetOfficialPosition(self, pk, eString):
        position = "None"
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM officials WHERE oResPK = " + str(pk))
        for x in cursor:
            position = x[3]
        db.close()
        self.getOfficialPosition.emit(GetGUIPosition(position), eString)

    '''@Slot(int, str)
    def CheckIfOfficialHasAccount(self, pk, eString):
        b = False
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT COUNT(*) FROM officials WHERE oResPK = " + str(pk))
        for x in cursor:
            if (x[0] > 0):
                b = True
        cursor.execute("SELECT * FROM residents WHERE resPK = " + str(pk))
        for x in cursor:
            self.officialHasAccount.emit(b, eString, pk, FMSNameConvert(x[1], x[2], x[3], x[4]))
        db.close()'''

    @Slot(int, str, str)
    def ElectOfficial(self, pk, eString, name):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("INSERT INTO officials (oResPK, oName, oPosition, oDate) VALUES ('" + str(pk) + "', '" + name + "', '" + GetDBPosition(eString) + "', '" + str(date.today()) + "')")
        db.commit()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Elected " + name + " as " + GetGUIPosition(GetDBPosition(eString)) + "')")
        db.commit()
        db.close()
        self.UpdateOfficialsTable()

    @Slot()
    def EditOfficials(self):
        self.editOfficials.emit()

    @Slot()
    def CancelEditOfficials(self):
        self.cancelEditOfficials.emit()

    @Slot(int, str)
    def DismissOfficial(self, pk, position):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        if (position == "<i>Barangay Chairman</i>" or position == "<i>Barangay Secretary</i>"):
            cursor.execute("DELETE FROM accounts WHERE acResPK = " + str(pk))
            db.commit()
        cursor.execute("SELECT * FROM officials WHERE oResPK = " + str(pk))
        c = list(cursor)
        for x in c:
            cursor.execute("INSERT INTO officials_archived (oaResPK, oaName, oaPosition, oaEDate, oaDDate) VALUES (" + str(x[1]) + ", '" + x[2] + "', '" + x[3] + "', '" + x[4] + "', '" + str(date.today()) + "')")
            db.commit()
            cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Dismissed " + x[2] + " from their position as " + GetGUIPosition(x[3]) + "')")
            db.commit()
        cursor.execute("DELETE FROM officials WHERE oResPK = " + str(pk))
        db.commit()
        db.close()
        self.UpdateOfficialsTable()
        self.UpdateArchivedOfficialsTable()

    @Slot()
    def GetArchivedOfficials(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM officials_archived ORDER BY oaPK DESC")
        for x in cursor:
            eDate = x[4].split("-")
            dDate = x[5].split("-")
            tDate = GetMonth(eDate[1]) + " " + eDate[0] + " - " + GetMonth(dDate[1]) + " " + dDate[0]
            self.getArchivedOfficials.emit(x[1], x[2], GetGUIPosition(x[3]), tDate)
        db.close()

    @Slot()
    def UpdateArchivedOfficialsTable(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        self.destroyArchivedOfficialsTable.emit()
        cursor.execute("SELECT * FROM officials_archived ORDER BY oaPK DESC")
        for x in cursor:
            eDate = x[4].split("-")
            dDate = x[5].split("-")
            tDate = GetMonth(eDate[1]) + " " + eDate[0] + " - " + GetMonth(dDate[1]) + " " + dDate[0]
            self.getArchivedOfficials.emit(x[1], x[2], GetGUIPosition(x[3]), tDate)
        db.close()

    @Slot(int)
    def ChangePFP(self, pk):
        self.pfpPickerActive.emit(True)
        self.PFPClass.ChangePFPStart(pk)
    
    @Slot()
    def CancelChangePFP(self):
        self.pfpPickerActive.emit(False)
        self.PFPClass.ChangePFPStop()
        

    '''@Slot(int)
    def TurnOverSystem(self, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("UPDATE officials SET oPosition = 'None'")
        db.commit()
        cursor.execute("UPDATE officials SET oPosition = 'Chairman' WHERE oResPK = " + str(pk))
        db.commit()
        db.close()
        self.logout.emit()'''

    @Slot()
    def GetBarangayInfo(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM barangay")
        for x in cursor:
            self.getBarangayInfo.emit(x[0], x[1], x[2])
        db.close()

    @Slot(str)
    def EditBarangayInfo(self, updateString):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute(updateString)
        db.commit()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Updated Barangay Info')")
        db.commit()
        db.close()
        self.GetBarangayInfo()

    @Slot()
    def GetActivities(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM activities ORDER BY aDate ASC")
        for x in cursor:
            aDate = x[2].split("-")
            self.getActivities.emit(x[0], x[1], GetMonth(aDate[1]) + " " + aDate[2] + ", " + aDate[0])
        db.close()

    @Slot()
    def UpdateActivityTable(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        self.destroyActivityTable.emit()
        cursor.execute("SELECT * FROM activities ORDER BY aDate ASC")
        for x in cursor:
            aDate = x[2].split("-")
            self.getActivities.emit(x[0], x[1], GetMonth(aDate[1]) + " " + aDate[2] + ", " + aDate[0])
        db.close()

    @Slot(int)
    def GetActivity(self, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM activities WHERE aPK = " + str(pk))
        for x in cursor:
            adate = x[2].split("-")
            self.getActivity.emit(x[0], x[1], adate[0], int(adate[1]), int(adate[2]), x[3], x[4])
        db.close()

    @Slot()
    def EditActivityCancelRequest(self):
        self.editActivityCancelRequest.emit()

    @Slot(int, str, str, str, str)
    def EditActivity(self, pk, name, adate, repeat, sched):
        d = adate
        if (repeat == "Yes"):
            d = date.today()
            if (date.today().weekday() <= int(sched[len(sched) - 1])):
                for x in sched:
                    if (date.today().weekday() <= int(x)):
                        while d.weekday() != int(x):
                            d = d + DateTime.timedelta(1)
                        break
            else:
                while d.weekday() != int(sched[0]):
                    d = d + DateTime.timedelta(1)
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("UPDATE activities SET aName = '" + name + "', aDate = '" + str(d) + "', aRepeat = '" + repeat + "', aSched = '" + sched + "' WHERE aPK = " + str(pk))
        db.commit()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Updated activity " + name + " set on " + str(d) + "')")
        db.commit()
        db.close()
        self.activityEdited.emit()
    
    @Slot()
    def OpenAddActivityPanel(self):
        self.openAddActivity.emit()

    @Slot()
    def AddActivityCancelRequest(self):
        self.addActivityCancelRequest.emit()

    @Slot(str, str, str, str)
    def AddActivity(self, name, adate, repeat, sched):
        d = adate
        if (repeat == "Yes"):
            d = date.today()
            if (date.today().weekday() <= int(sched[len(sched) - 1])):
                for x in sched:
                    if (date.today().weekday() <= int(x)):
                        while d.weekday() != int(x):
                            d = d + DateTime.timedelta(1)
                        break
            else:
                while d.weekday() != int(sched[0]):
                    d = d + DateTime.timedelta(1)
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("INSERT INTO activities (aName, aDate, aRepeat, aSched) VALUES ('" + name + "', '" + str(d) + "', '" + repeat + "', '" + sched + "')")
        db.commit()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Added a new activity " + name + " set on " + str(d) + "')")
        db.commit()
        db.close()
        self.activityAdded.emit()

    @Slot(int)
    def DGetAccountInfo(self, pk):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM accounts WHERE acPK = " + str(pk))
        for x in cursor:
            self.dGetAccountInfo.emit(x[2], GetGUIPosition(x[3]))
        db.close()

    @Slot()
    def DGetBarangayInfo(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM barangay")
        for x in cursor:
            self.dGetBarangayInfo.emit(x[0], x[1], x[2])
        db.close()

    @Slot()
    def DGetOfficials(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM officials")
        for x in cursor:
            hasPFP = False
            if (os.path.exists("mis/pfp/" + str(x[1]) + ".png") == True):
                hasPFP = True
            self.dGetOfficials.emit(x[0], x[1], x[2], x[3], hasPFP)
        db.close()

    @Slot()
    def DGetActivities(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM activities WHERE aDate = '" + str(date.today()) + "' ORDER BY aDate ASC LIMIT 2")
        for x in cursor:
            self.dGetActivitiesT.emit(x[1])
        cursor.execute("SELECT * FROM activities WHERE aDate > '" + str(date.today()) + "' ORDER BY aDate ASC LIMIT 2")
        for x in cursor:
            aDate = x[2].split("-")
            self.dGetActivitiesU.emit(x[1], GetMonth(aDate[1]) + " " + aDate[2] + ", " + aDate[0])
        db.close()

    @Slot()
    def DGetDemographics(self):
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT COUNT(*) FROM residents")
        for x in cursor:
            total = str(x[0])
        cursor.execute("SELECT COUNT(*) FROM residents WHERE resGender = 'Male'")
        for x in cursor:
            male = str(x[0])
        cursor.execute("SELECT COUNT(*) FROM residents WHERE resGender = 'Female'")
        for x in cursor:
            female = str(x[0])
        cursor.execute("SELECT COUNT(*) FROM residents WHERE resPWD = 'Yes'")
        for x in cursor:
            pwd = str(x[0])
        cursor.execute("SELECT COUNT(*) FROM residents WHERE resAge >= 60")
        for x in cursor:
            senior = str(x[0])
        cursor.execute("SELECT COUNT(*) FROM residents WHERE resVoter = 'Yes'")
        for x in cursor:
            voter = str(x[0])
        cursor.execute("SELECT COUNT(*) FROM residents WHERE resPerm = 'Yes'")
        for x in cursor:
            permanent = str(x[0])
        cursor.execute("SELECT COUNT(*) FROM residents WHERE resVaccine = 'Yes'")
        for x in cursor:
            vaccine = str(x[0])
        cursor.execute("SELECT COUNT(*) FROM residents WHERE resBooster = 'Yes'")
        for x in cursor:
            booster = str(x[0])
        self.dGetDemographics.emit(total, male, female, pwd, senior, voter, permanent, vaccine, booster)
        db.close()

    @Slot(str)
    def OpenPrintPanel(self, page):
        self.openPrintPanel.emit(page)

    @Slot(str)
    def ClosePrintPanelRequest(self, page):
        self.closePrintPanelRequest.emit(page)

    @Slot(str, str)
    def PrintBgyCertificate(self, pk, purpose):
        printdocx.PrintBgyCertificate(pk, purpose)
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM residents WHERE resPK = " + pk)
        for x in cursor:
            cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Printed Barangay Certificate for " + SFMNameConvert(x[1], x[2], x[3], x[4]) + "')")
            db.commit()
        db.close()
        self.closePrintPanel.emit("BGYCERTIFICATE")
    
    @Slot(str, str)
    def PrintBgyClearance(self, pk, purpose):
        printdocx.PrintBgyClearance(pk, purpose)
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM residents WHERE resPK = " + pk)
        for x in cursor:
            cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Printed Barangay Clearance for " + SFMNameConvert(x[1], x[2], x[3], x[4]) + "')")
            db.commit()
        db.close()
        self.closePrintPanel.emit("BGYCLEARANCE")

    @Slot(str, str, str, str)
    def PrintBsnClearance(self, rName, rAddress, bName, bAddress):
        printdocx.PrintBsnClearance(rName, rAddress, bName, bAddress)
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Printed Business Clearance for " + bName + ", owned by " + rName + "')")
        db.commit()
        db.close()
        self.closePrintPanel.emit("BSNCLEARANCE")

    @Slot(str, str)
    def PrintBgyIndigency(self, pk, purpose):
        printdocx.PrintBgyIndigency(pk, purpose)
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("SELECT * FROM residents WHERE resPK = " + pk)
        for x in cursor:
            cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Printed Barangay Indigency for " + SFMNameConvert(x[1], x[2], x[3], x[4]) + "')")
            db.commit()
        db.close()
        self.closePrintPanel.emit("BGYINDIGENCY")

    @Slot()
    def PrintPWDList(self):
        printdocx.PrintPWDList()
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Printed List of PWD')")
        db.commit()
        db.close()
    
    @Slot()
    def PrintSeniorList(self):
        printdocx.PrintSeniorList()
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Printed List of Senior Citizen')")
        db.commit()
        db.close()
    
    @Slot()
    def PrintPensionerList(self):
        printdocx.PrintPensionerList()
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Printed List of Pensioner')")
        db.commit()
        db.close()

    @Slot(str, str)
    def PrintCustomList(self, searchString, title):
        printdocx.PrintCustomList(searchString, title)
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Printed Custom List of Residents')")
        db.commit()
        db.close()

    @Slot(str, str,)
    def PrintHousehold(self, block, lot):
        printdocx.PrintHousehold(block, lot)
        self.closeLotResidents.emit()
        db = sqlite3.connect(dbPath)
        cursor = db.cursor()
        cursor.execute("INSERT INTO audit (adResPK, adDate, adTime, adUser, adAction) VALUES ('" + str(LoggedIn.resPK) + "', '" + str(date.today()) + "', '" + str(datetime.now().strftime("%H:%M")) + "', '" + LoggedIn.user + "', 'Printed Record of Household for Block " + block + " Lot " + lot + "')")
        db.commit()
        db.close()

'''
if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    windLogin = LoginWindow()
    engine.rootContext().setContextProperty("backend", windLogin)

    engine.load(os.path.join(os.path.dirname(__file__), "qml/login.qml"))

    if not engine.rootObjects():
        sys.exit(-1)

    sys.exit(app.exec())
'''
def GetMonth(monthNum):
    if (len(monthNum) == 1):
        monthNum = "0" + monthNum
    if (monthNum == "01"):
        return "January"
    if (monthNum == "02"):
        return "February"
    if (monthNum == "03"):
        return "March"
    if (monthNum == "04"):
        return "April"
    if (monthNum == "05"):
        return "May"
    if (monthNum == "06"):
        return "June"
    if (monthNum == "07"):
        return "July"
    if (monthNum == "08"):
        return "August"
    if (monthNum == "09"):
        return "September"
    if (monthNum == "10"):
        return "October"
    if (monthNum == "11"):
        return "November"
    if (monthNum == "12"):
        return "December"

#def GetDayNum(day)

def SFMNameConvert(sName, fName, mName, nameExt):
    if (mName != ""):
        m = mName.split(" ")
        mName = ""
        for c in m:
            mName = mName + c[0] + "."
        mName = " " + mName
    if (nameExt != ""):
        nameExt = " " + nameExt
    name = sName + ", " + fName + nameExt + mName
    return name

def FMSNameConvert(sName, fName, mName, nameExt):
    if (mName != ""):
        m = mName.split(" ")
        mName = ""
        for c in m:
            mName = mName + c[0] + "."
        mName = " " + mName
    if (nameExt != ""):
        nameExt = ", " + nameExt
    name = fName + mName + " " + sName + nameExt
    return name

def GetDBPosition(guiPos):
    if (guiPos == "<i>Barangay Chairman</i>"):
        return "Chairman"
    if (guiPos == "<i>Barangay Secretary</i>"):
        return "Secretary"
    if (guiPos == "<i>Barangay Treasurer</i>"):
        return "Treasurer"
    if (guiPos == "<i>Kagawad - Appropriation</i>"):
        return "Kagawad Appropriation"
    if (guiPos == "<i>Kagawad - VAWC / Health and Social Services</i>"):
        return "Kagawad VAWC"
    if (guiPos == "<i>Kagawad - Environmental Protection</i>"):
        return "Kagawad EP"
    if (guiPos == "<i>Kagawad - Peace and Order</i>"):
        return "Kagawad PO"
    if (guiPos == "<i>Kagawad - Cooperative and Livelihood</i>"):
        return "Kagawad CL"
    if (guiPos == "<i>Kagawad - Education, Cultural Affairs and Tourism / Public Works</i>"):
        return "Kagawad ECAT"
    if (guiPos == "<i>Kagawad - Human Rights</i>"):
        return "Kagawad HR"
    if (guiPos == "<i>SK Chairman Youth and Sports Development</i>"):
        return "SK Chairman"

def GetGUIPosition(dbPos):
    if (dbPos == "None"):
        return "None"
    if (dbPos == "Barangay Account"):
        return "Barangay Official"
    if (dbPos == "Chairman"):
        return "Barangay Chairman"
    if (dbPos == "Secretary"):
        return "Barangay Secretary"
    if (dbPos == "Treasurer"):
        return "Barangay Treasurer"
    if (dbPos =="Kagawad Appropriation"):
        return "Kagawad - Appropriation"
    if (dbPos == "Kagawad VAWC"):
        return "Kagawad - VAWC / Health and Social Services"
    if (dbPos == "Kagawad EP"):
        return "Kagawad - Environmental Protection"
    if (dbPos == "Kagawad PO"):
        return "Kagawad - Peace and Order"
    if (dbPos == "Kagawad CL"):
        return "Kagawad - Cooperative and Livelihood"
    if (dbPos == "Kagawad ECAT"):
        return "Kagawad - Education, Cultural Affairs and Tourism / Public Works"
    if (dbPos == "Kagawad HR"):
        return "Kagawad - Human Rights"
    if (dbPos == "SK Chairman"):
        return "SK Chairman Youth and Sports Development"

def GetNowString():
    now = str(datetime.now())
    now = now.split(" ")
    date = now[0].split("-")
    time = now[1].split(":")
    seconds = time[2].split(".")
    return date[0] + date[1] + date[2] + time[0] + time[1] + seconds[0]

def GetTodayString():
    today = str(date.today()).split("-")
    return today[0] + today[1] + today[2]

def AutoUpdateActivities():
    db = sqlite3.connect(dbPath)
    cursor = db.cursor()
    cursor.execute("SELECT * FROM activities")
    c = list(cursor)
    for x in c:
        if (x[2] < str(date.today())):
            if (x[3] == "Yes"):
                d = date.today()
                if (date.today().weekday() <= int(x[4][len(x[4]) - 1])):
                    for y in x[4]:
                        if (date.today().weekday() <= int(y)):
                            while d.weekday() != int(y):
                                d = d + DateTime.timedelta(1)
                            break
                else:
                    while d.weekday() != int(x[4][0]):
                        d = d + DateTime.timedelta(1)
                cursor.execute("UPDATE activities SET aDate = '" + str(d) + "' WHERE aPK = " + str(x[0]))
                db.commit()
            else:
                cursor.execute("DELETE FROM activities WHERE aPK = " + str(x[0]))
                db.commit()
    db.close()

def AutoBackupDatabase():
    shutil.copy(os.getcwd() + "\mis\mis.db", os.getcwd() + "\mis\\db\\" + GetTodayString() + ".db")

def Daily():
    db = sqlite3.connect(dbPath)
    cursor = db.cursor()
    cursor.execute("SELECT * FROM date_last")
    for x in cursor:
        if (x[0] != str(date.today())):
            AutoUpdateActivities()
            AutoBackupDatabase()
            cursor.execute("UPDATE date_last SET date = '" + str(date.today()) + "'")
            db.commit()
    db.close()