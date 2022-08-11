from datetime import date
from datetime import datetime

from multiprocessing import Process

import os
import shutil
from tkinter import Tk
from tkinter.filedialog import askopenfilename

class PFP:
    def __init__(self):
        self.p = Process(target=self.ChangePFP)

    def ChangePFP(self, pk):
        filetypes = (
        ('Images', '*.png *.jpg *.jpeg'),
        ('All files', '*.*'))
        root = Tk()
        root.attributes("-topmost", True)
        root.withdraw()
        filename = askopenfilename(parent=root, title='Select Image', initialdir='/', filetypes=filetypes)
        if (filename != ""):
            shutil.copy(filename, os.getcwd() + "\mis\pfp\\" + pk + ".png")

    def ChangePFPStart(self, pk):
        self.p = Process(target=self.ChangePFP, args=(str(pk),))
        self.p.start()

    def ChangePFPStop(self):
        self.p.terminate()

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

def GetOrdinal(num):
    if num[len(num) -1] == '1':
        return "st"
    elif num[len(num) -1] == '2':
        return "nd"
    elif num[len(num) -1] == '3':
        return "rd"
    else:
        return "th"

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

def GetMI(mName):
    if (mName != ""):
        m = mName.split(" ")
        mName = ""
        for c in m:
            mName = mName + c[0] + "."
    return mName

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