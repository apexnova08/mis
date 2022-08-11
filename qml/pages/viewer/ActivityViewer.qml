import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material
import "../../controls"

Rectangle
{
    id: activityViewer

    width: 700
    color: "#1b222c"

    Material.theme: Material.Dark
    Material.accent: Material.LightBlue

    property int pk: 0
    property string activity: ""
    property string aYear: ""
    property int aMonth: 0
    property int aDay: 0
    property string repeat: ""
    property string sched: ""

    property string schedNew: ""

    QtObject
    {
        id: internal

        function getNewSched()
        {
            schedNew = ""
            if (chkRepeat.checked == true)
            {
                if (chkMon.checked)
                {
                    schedNew = schedNew + "0"
                }
                if (chkTue.checked)
                {
                    schedNew = schedNew + "1"
                }
                if (chkWed.checked)
                {
                    schedNew = schedNew + "2"
                }
                if (chkThu.checked)
                {
                    schedNew = schedNew + "3"
                }
                if (chkFri.checked)
                {
                    schedNew = schedNew + "4"
                }
                if (chkSat.checked)
                {
                    schedNew = schedNew + "5"
                }
                if (chkSun.checked)
                {
                    schedNew = schedNew + "6"
                }
            }
        }
        function valuesChanged()
        {
            getNewSched()

            let changed = false
            if (txtActivity.text != activity || (repeat == "Yes" && chkRepeat.checked == false) || (repeat == "No" && chkOneTime.checked == false))
            {
                changed = true
            }
            if (sched != schedNew)
            {
                changed = true
            }
            if (repeat == "No")
            {
                if (txtAYear.text != aYear || comboAMonth.currentIndex != aMonth - 1 || comboADay.currentIndex != aDay - 1)
                {
                    changed = true
                }
            }

            return changed
        }
        function cancelRequest()
        {
            if (valuesChanged() == false)
            {
                backend.PopupFunc("ACTIVITY CANCEL EDIT")
            }
            else
            {
                cancelEditActivityPopup.open()
            }
        }
        function editRequest()
        {
            if (valuesChanged() == true)
            {
                editActivityPopup.open()
            }
            else
            {
                lblError.text = qsTr("<i>No changes were made</i>")
                lblError.visible = true
            }
        }
        function clearErrors()
        {
            lblActivity.Material.foreground = Material.White
            chkOneTime.Material.foreground = Material.White
            chkRepeat.Material.foreground = Material.White
            lblError.visible = false
        }
        function clearFields()
        {
            clearErrors()

            txtActivity.text = ""

            comboAMonth.currentIndex = -1
            comboADay.currentIndex = -1
            txtAYear.text = ""

            chkMon.checked = false
            chkTue.checked = false
            chkWed.checked = false
            chkThu.checked = false
            chkFri.checked = false
            chkSat.checked = false
            chkSun.checked = false

            infoContainer.ScrollBar.vertical.position = 0
        }
    }
    Connections
    {
        target: backend

        function onGetActivity(pk, activity, aYear, aMonth, aDay, repeat, sched)
        {
            activityViewer.pk = pk
            activityViewer.activity = activity
            activityViewer.aYear = aYear
            activityViewer.aMonth = aMonth
            activityViewer.aDay = aDay
            activityViewer.repeat = repeat
            activityViewer.sched = sched

            txtActivity.text = activity

            if (repeat == "Yes")
            {
                chkOneTime.checked = false
                chkRepeat.checked = true

                if (sched.includes("0")){chkMon.checked = true}
                if (sched.includes("1")){chkTue.checked = true}
                if (sched.includes("2")){chkWed.checked = true}
                if (sched.includes("3")){chkThu.checked = true}
                if (sched.includes("4")){chkFri.checked = true}
                if (sched.includes("5")){chkSat.checked = true}
                if (sched.includes("6")){chkSun.checked = true}
            }
            else
            {
                chkOneTime.checked = true
                chkRepeat.checked = false

                txtAYear.text = aYear
                comboAMonth.currentIndex = aMonth - 1
                comboADay.currentIndex = aDay - 1
            }
        }

        function onEditActivityCancelRequest()
        {
            internal.cancelRequest()
        }
        function onEditActivity()
        {
            let date = ""
            let repeatNew = "Yes"

            if (chkOneTime.checked == true)
            {
                repeatNew = "No"

                let m = (comboAMonth.currentIndex + 1).toString()
                if (comboAMonth.currentIndex < 9)
                {
                    m = "0" + m
                }

                let d = (comboADay.currentIndex + 1).toString()
                if (comboADay.currentIndex < 9)
                {
                    d = "0" + d
                }
                date = txtAYear.text + "-" + m + "-" + d
            }
            backend.EditActivity(pk, txtActivity.text, date, repeatNew, schedNew)
        }
        function onActivityEdited()
        {
            internal.clearFields()
        }
        function onCancelEditActivity()
        {
            internal.clearFields()
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

            text: qsTr("<b>Activity / Event</b>")
            color: "#ffffff"
            font.pixelSize: 17
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
    }

    Rectangle
    {
        id: rectActivityInfo

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
            contentHeight: 530

            Label
            {
                id: lblActivity

                text: qsTr("Activity Name:*     ")
                Material.foreground: Material.White
                font.pixelSize: 16
            
                anchors.top: parent.top
                anchors.left: parent.left
                anchors.margins: 20
            }
            TextField
            {
                id: txtActivity
                selectByMouse: true
                placeholderText: "Activity Name"
                text: qsTr(activity)

                anchors.left: lblActivity.right
                anchors.right: parent.right
                anchors.verticalCenter: lblActivity.verticalCenter
            
                anchors.leftMargin: 20
                anchors.rightMargin: 50
            }
            CheckBox
            {
                id: chkOneTime
                text: qsTr("One Time Event / Activity*")
                Material.foreground: Material.White
                checked: true
                font.pixelSize: 16

                anchors. left: parent.left
                anchors.top: lblActivity.bottom
                anchors.leftMargin: 10
                anchors.topMargin: 20

                onCheckedChanged:
                {
                    if (chkOneTime.checked == true)
                    {
                        chkOneTime.text = qsTr("One Time Event / Activity*")
                        chkRepeat.checked = false

                        comboAMonth.enabled = true
                        comboADay.enabled = true
                        txtAYear.enabled = true
                    }
                    else
                    {
                        chkOneTime.text = qsTr("One Time Event / Activity")
                        chkRepeat.checked = true

                        comboAMonth.currentIndex = -1
                        comboADay.currentIndex = -1
                        txtAYear.text = ""

                        comboAMonth.enabled = false
                        comboADay.enabled = false
                        txtAYear.enabled = false
                    }
                }
            }
            Label
            {
                id: lblADate

                text: qsTr("Set Date:     ")
                color: "#ffffff"
                font.pixelSize: 16
            
                anchors.top: chkOneTime.bottom
                anchors.left: parent.left
                anchors.leftMargin: 40
                anchors.topMargin: 10
            }
            ComboBox
            {
                id: comboAMonth
                currentIndex: -1
                displayText: currentIndex === -1 ? "Month" : currentText
                model: ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]

                anchors.left: lblADate.right
                anchors.verticalCenter: lblADate.verticalCenter
                width: 150

                anchors.leftMargin: 20
            }
            ComboBox
            {
                id: comboADay
                currentIndex: -1
                displayText: currentIndex === -1 ? "Day" : currentText
                model: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"]

                anchors.left: comboAMonth.right
                anchors.verticalCenter: lblADate.verticalCenter
                width: 100

                anchors.leftMargin: 20
            }
            TextField
            {
                id: txtAYear
                selectByMouse: true
                validator: IntValidator {bottom: 0; top: 9999;}
                horizontalAlignment: TextInput.AlignHCenter
                placeholderText: "Year"

                anchors.left: comboADay.right
                anchors.verticalCenter: lblADate.verticalCenter
                width: 100
            
                anchors.leftMargin: 20
            }
            CheckBox
            {
                id: chkRepeat
                text: qsTr("Repeat Weekly*")
                Material.foreground: Material.White
                checked: true
                font.pixelSize: 16

                anchors. left: parent.left
                anchors.top: lblADate.bottom
                anchors.leftMargin: 10
                anchors.topMargin: 20

                onCheckedChanged:
                {
                    if (chkRepeat.checked == true)
                    {
                        chkRepeat.text = qsTr("Repeat Weekly*")
                        chkOneTime.checked = false

                        chkMon.enabled = true
                        chkTue.enabled = true
                        chkWed.enabled = true
                        chkThu.enabled = true
                        chkFri.enabled = true
                        chkSat.enabled = true
                        chkSun.enabled = true
                    }
                    else
                    {
                        chkRepeat.text = qsTr("Repeat Weekly")
                        chkOneTime.checked = true

                        chkMon.checked = false
                        chkTue.checked = false
                        chkWed.checked = false
                        chkThu.checked = false
                        chkFri.checked = false
                        chkSat.checked = false
                        chkSun.checked = false

                        chkMon.enabled = false
                        chkTue.enabled = false
                        chkWed.enabled = false
                        chkThu.enabled = false
                        chkFri.enabled = false
                        chkSat.enabled = false
                        chkSun.enabled = false
                    }
                }
            }
            CheckBox
            {
                id: chkMon
                text: qsTr("Monday")
                property string isChecked: "No"
                font.pixelSize: 16

                anchors. left: parent.left
                anchors.top: chkRepeat.bottom
                anchors.leftMargin: 40
            }
            CheckBox
            {
                id: chkTue
                text: qsTr("Tuesday")
                property string isChecked: "No"
                font.pixelSize: 16

                anchors. left: parent.left
                anchors.top: chkMon.top
                anchors.margins: 40
            }
            CheckBox
            {
                id: chkWed
                text: qsTr("Wednesday")
                property string isChecked: "No"
                font.pixelSize: 16

                anchors. left: parent.left
                anchors.top: chkTue.top
                anchors.margins: 40
            }
            CheckBox
            {
                id: chkThu
                text: qsTr("Thursday")
                property string isChecked: "No"
                font.pixelSize: 16

                anchors. left: parent.left
                anchors.top: chkWed.top
                anchors.margins: 40
            }
            CheckBox
            {
                id: chkFri
                text: qsTr("Friday")
                property string isChecked: "No"
                font.pixelSize: 16

                anchors. left: parent.left
                anchors.top: chkThu.top
                anchors.margins: 40
            }
            CheckBox
            {
                id: chkSat
                text: qsTr("Saturday")
                property string isChecked: "No"
                font.pixelSize: 16

                anchors. left: parent.left
                anchors.top: chkFri.top
                anchors.margins: 40
            }
            CheckBox
            {
                id: chkSun
                text: qsTr("Sunday")
                property string isChecked: "No"
                font.pixelSize: 16

                anchors. left: parent.left
                anchors.top: chkSat.top
                anchors.margins: 40
            }
        }

        // Bottom Controls
        Label
        {
            id: lblError
            font.pixelSize: 10
            text: qsTr("Missing required fields")
            Material.foreground: Material.Pink
            visible: false

            anchors.left: btnEditActivity.left
            anchors.bottom: btnEditActivity.top
        }
        Button
        {
            id: btnEditActivity
            text: "Done"

            anchors.left: parent.left
            anchors.bottom: parent.bottom
            
            anchors.margins: 20

            onClicked:
            {
                internal.clearErrors()
                if (txtActivity.text == "" || (chkRepeat.checked == true && chkMon.checked == false && chkTue.checked == false && chkWed.checked == false && chkThu.checked == false && chkFri.checked == false && chkSat.checked == false && chkSun.checked == false) || (chkOneTime.checked == true && (comboAMonth.currentIndex == -1 || comboADay.currentIndex == -1 || txtAYear.text == "")))
                {
                    lblError.text = qsTr("<i>Missing required fields</i>")
                    lblError.visible = true

                    if (txtActivity.text == "")
                    {
                        lblActivity.Material.foreground = Material.Pink
                    }
                    if (chkRepeat.checked == true && chkMon.checked == false && chkTue.checked == false && chkWed.checked == false && chkThu.checked == false && chkFri.checked == false && chkSat.checked == false && chkSun.checked == false)
                    {
                        chkRepeat.Material.foreground = Material.Pink
                    }
                    if (chkOneTime.checked == true && (comboAMonth.currentIndex == -1 || comboADay.currentIndex == -1 || txtAYear.text == ""))
                    {
                        chkOneTime.Material.foreground = Material.Pink
                    }
                }
                else
                {
                    internal.editRequest()
                }
            }
        }
        Button
        {
            id: btnCancel
            text: "Cancel"

            anchors.left: btnEditActivity.right
            anchors.bottom: parent.bottom

            anchors.margins: 20

            onClicked: internal.cancelRequest()
        }
    }
    CustomPopup
    {
        id: editActivityPopup
        popText: "You are about to update this activity's data. Continue?"
        popFunc: "ACTIVITY EDIT"
    }
    CustomPopup
    {
        id: cancelEditActivityPopup
        popText: "You are about to cancel updating this activity's data. Continue?"
        popWarningText: "No changes will be made"

        popOKButtonColor: "#cf1e60"
        popOKButtonColorHover: "#b00041"

        popFunc: "ACTIVITY CANCEL EDIT"
        isWarning: true
    }
}