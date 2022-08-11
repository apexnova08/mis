import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

Rectangle
{
    id: rectangle
    color: "#12151c"

    Component.onCompleted: backend.DGetDemographics()

    Connections
    {
        target: backend

        function onDGetDemographics(total, male, female, pwd, senior, voter, permanent, vaccine, booster)
        {
            dTotal.valueText = total
            dMale.valueText = male
            dFemale.valueText = female
            dSenior.valueText = senior
            dPWD.valueText = pwd
            dVoter.valueText = voter
            dPermanent.valueText = permanent
            dVaccine.valueText = vaccine
            dBooster.valueText = booster
        }
    }

    Rectangle
    {
        id: rectTitleBar

        color: "#191d26"
        height: 50

        anchors.left: parent.left
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 2

        Label
        {
            id: lblTitleBar

            text: qsTr("<b>Demographics</b>")
            color: "#ffffff"
            font.pixelSize: 17
            
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: 20
        }
    }
    ScrollView
    {
        id: scroll
        anchors.left: parent.left
        anchors.top: rectTitleBar.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.topMargin: 1
        anchors.bottomMargin: 1

        contentHeight: 384
        z: 1

        DDemographicsRow
        {
            id: dTotal
            categoryText: "<b>Total Residents:</b>"

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.right: parent.right
        }

        // Gender
        Rectangle
        {
            id: dGenderContainer
            color: "#c5c5c5"
            height: 1
            
            anchors.left: parent.left
            anchors.top: dTotal.bottom
            anchors.right: parent.right
            anchors.margins: 10
        }
        DDemographicsRow
        {
            id: dMale
            categoryText: "Male:"

            anchors.left: parent.left
            anchors.top: dGenderContainer.bottom
            anchors.right: parent.horizontalCenter
            anchors.topMargin: 10
        }
        DDemographicsRow
        {
            id: dFemale
            categoryText: "Female:"

            anchors.left: parent.horizontalCenter
            anchors.top: dGenderContainer.bottom
            anchors.right: parent.right
            anchors.topMargin: 10
        }

        // Age
        Rectangle
        {
            id: dAge
            color: "#c5c5c5"
            height: 1
            
            anchors.left: parent.left
            anchors.top: dMale.bottom
            anchors.right: parent.right
            anchors.margins: 10
        }
        DDemographicsRow
        {
            id: dToddler
            categoryText: "Toddlers:"

            anchors.left: parent.left
            anchors.top: dAge.bottom
            anchors.right: parent.horizontalCenter
            anchors.topMargin: 10
        }
        DDemographicsRow
        {
            id: dSenior
            categoryText: "Senior Citizens:"

            anchors.left: parent.horizontalCenter
            anchors.top: dAge.bottom
            anchors.right: parent.right
            anchors.topMargin: 10
        }
        DDemographicsRow
        {
            id: dPWD
            categoryText: "PWDs:"

            anchors.left: parent.left
            anchors.top: dToddler.bottom
            anchors.right: parent.horizontalCenter
        }
        DDemographicsRow
        {
            id: dPensionner
            categoryText: "Pensionners:"

            anchors.left: parent.horizontalCenter
            anchors.top: dSenior.bottom
            anchors.right: parent.right
        }

        // Recidency
        Rectangle
        {
            id: dRecidency
            color: "#c5c5c5"
            height: 1
            
            anchors.left: parent.left
            anchors.top: dPWD.bottom
            anchors.right: parent.right
            anchors.margins: 10
        }
        DDemographicsRow
        {
            id: dVoter
            categoryText: "Registered Voters:"

            anchors.left: parent.left
            anchors.top: dRecidency.bottom
            anchors.right: parent.horizontalCenter
            anchors.topMargin: 10
        }
        DDemographicsRow
        {
            id: dPermanent
            categoryText: "Permanent Residents:"

            anchors.left: parent.horizontalCenter
            anchors.top: dRecidency.bottom
            anchors.right: parent.right
            anchors.topMargin: 10
        }

        // COVID 19
        Rectangle
        {
            id: dCOVID
            color: "#c5c5c5"
            height: 1
            
            anchors.left: parent.left
            anchors.top: dVoter.bottom
            anchors.right: parent.right
            anchors.margins: 10
        }
        DDemographicsRow
        {
            id: dVaccine
            categoryText: "COVID-19 Vaccinated:"

            anchors.left: parent.left
            anchors.top: dCOVID.bottom
            anchors.right: parent.horizontalCenter
            anchors.topMargin: 10
        }
        DDemographicsRow
        {
            id: dBooster
            categoryText: "COVID-19 Boostered:"

            anchors.left: parent.horizontalCenter
            anchors.top: dCOVID.bottom
            anchors.right: parent.right
            anchors.topMargin: 10
        }
    }
}