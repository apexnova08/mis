import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import "../controls"

Item
{
    Rectangle
    {
        id: rectangle
        color: "#191d26"
        anchors.fill: parent

        Rectangle
        {
            height: 2
            anchors.bottom: bg.top
            anchors.left: bg.left
            anchors.right: bg.right
        }
        Rectangle
        {
            id: bg
            color: "#12151c"
            
            anchors.fill: parent
            anchors.margins: 20

            // Map
            ScrollView
            {
                id: mapContainer

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.margins: 10

                width: 1020
                contentHeight: 900

                Image
                {
                    id: map
                    anchors.left: parent.left
                    source: "../images/map.png"

                    // Block 1
                    HouseNum
                    {
                        id: b1l1
                        x: 825
                        y: 758

                        btnBlock: "1"
                        btnLot: "1"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b1l1.horizontalCenter
                        anchors.verticalCenter: b1l1.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("1")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b1l2
                        x: 815
                        y: 725

                        btnBlock: "1"
                        btnLot: "2"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b1l2.horizontalCenter
                        anchors.verticalCenter: b1l2.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("2")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b1l3
                        x: 790
                        y: 682

                        btnBlock: "1"
                        btnLot: "3"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b1l3.horizontalCenter
                        anchors.verticalCenter: b1l3.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("3")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b1l4
                        x: 820
                        y: 671

                        btnBlock: "1"
                        btnLot: "4"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b1l4.horizontalCenter
                        anchors.verticalCenter: b1l4.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("4")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b1l5
                        x: 790
                        y: 655

                        btnBlock: "1"
                        btnLot: "5"
                        propertyType: "V"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b1l5.horizontalCenter
                        anchors.verticalCenter: b1l5.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("5")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b1l6
                        x: 802
                        y: 615

                        btnBlock: "1"
                        btnLot: "6"
                        propertyType: "V"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b1l6.horizontalCenter
                        anchors.verticalCenter: b1l6.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("6")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b1l7
                        x: 768
                        y: 630

                        btnBlock: "1"
                        btnLot: "7"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b1l7.horizontalCenter
                        anchors.verticalCenter: b1l7.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("7")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b1l8
                        x: 739
                        y: 640

                        btnBlock: "1"
                        btnLot: "8"
                        propertyType: "V"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b1l8.horizontalCenter
                        anchors.verticalCenter: b1l8.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("8")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b1l9
                        x: 713
                        y: 655

                        btnBlock: "1"
                        btnLot: "9"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b1l9.horizontalCenter
                        anchors.verticalCenter: b1l9.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("9")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b1l10
                        x: 680
                        y: 680

                        btnBlock: "1"
                        btnLot: "10"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b1l10.horizontalCenter
                        anchors.verticalCenter: b1l10.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("10")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b1l11
                        x: 713
                        y: 705

                        btnBlock: "1"
                        btnLot: "11"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b1l11.horizontalCenter
                        anchors.verticalCenter: b1l11.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("11")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b1l12
                        x: 745
                        y: 715

                        btnBlock: "1"
                        btnLot: "12"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b1l12.horizontalCenter
                        anchors.verticalCenter: b1l12.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("12")
                        color: "#ffffff"
                    }

                    // Block 2
                    HouseNum
                    {
                        id: b2l1
                        x: 782
                        y: 551

                        btnBlock: "2"
                        btnLot: "1"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b2l1.horizontalCenter
                        anchors.verticalCenter: b2l1.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("1")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b2l2
                        x: 747
                        y: 504

                        btnBlock: "2"
                        btnLot: "2"
                        propertyType: "V"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b2l2.horizontalCenter
                        anchors.verticalCenter: b2l2.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("2")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b2l3
                        x: 720
                        y: 462

                        btnBlock: "2"
                        btnLot: "3"
                        propertyType: "V"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b2l3.horizontalCenter
                        anchors.verticalCenter: b2l3.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("3")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b2l4
                        x: 719
                        y: 418

                        btnBlock: "2"
                        btnLot: "4"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b2l4.horizontalCenter
                        anchors.verticalCenter: b2l4.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("4")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b2l5
                        x: 732
                        y: 371

                        btnBlock: "2"
                        btnLot: "5"
                        propertyType: "B"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b2l5.horizontalCenter
                        anchors.verticalCenter: b2l5.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("5")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b2l6
                        x: 696
                        y: 380

                        btnBlock: "2"
                        btnLot: "6"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b2l6.horizontalCenter
                        anchors.verticalCenter: b2l6.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("6")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b2l7
                        x: 651
                        y: 388

                        btnBlock: "2"
                        btnLot: "7"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b2l7.horizontalCenter
                        anchors.verticalCenter: b2l7.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("7")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b2l8
                        x: 613
                        y: 396

                        btnBlock: "2"
                        btnLot: "8"
                        propertyType: "V"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b2l8.horizontalCenter
                        anchors.verticalCenter: b2l8.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("8")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b2l9
                        x: 586
                        y: 402

                        btnBlock: "2"
                        btnLot: "9"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b2l9.horizontalCenter
                        anchors.verticalCenter: b2l9.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("9")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b2l10
                        x: 622
                        y: 450

                        btnBlock: "2"
                        btnLot: "10"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b2l10.horizontalCenter
                        anchors.verticalCenter: b2l10.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("10")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b2l11
                        x: 633
                        y: 492

                        btnBlock: "2"
                        btnLot: "11"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b2l11.horizontalCenter
                        anchors.verticalCenter: b2l11.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("11")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b2l12
                        x: 643
                        y: 520

                        btnBlock: "2"
                        btnLot: "12"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b2l12.horizontalCenter
                        anchors.verticalCenter: b2l12.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("12")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b2l13
                        x: 681
                        y: 533

                        btnBlock: "2"
                        btnLot: "13"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b2l13.horizontalCenter
                        anchors.verticalCenter: b2l13.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("13")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b2l14
                        x: 649
                        y: 591

                        btnBlock: "2"
                        btnLot: "14"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b2l14.horizontalCenter
                        anchors.verticalCenter: b2l14.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("14")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b2l15
                        x: 687
                        y: 582

                        btnBlock: "2"
                        btnLot: "15"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b2l15.horizontalCenter
                        anchors.verticalCenter: b2l15.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("15")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b2l16
                        x: 736
                        y: 568

                        btnBlock: "2"
                        btnLot: "16"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b2l16.horizontalCenter
                        anchors.verticalCenter: b2l16.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("16")
                        color: "#ffffff"
                    }

                    // Block 3
                    HouseNum
                    {
                        id: b3l1A
                        x: 712
                        y: 311

                        btnBlock: "3"
                        btnLot: "1A"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l1A.horizontalCenter
                        anchors.verticalCenter: b3l1A.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("1A")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b3l1B
                        x: 706
                        y: 289

                        btnBlock: "3"
                        btnLot: "1B"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l1B.horizontalCenter
                        anchors.verticalCenter: b3l1B.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("1B")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b3l1C
                        x: 698
                        y: 268

                        btnBlock: "3"
                        btnLot: "1C"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l1C.horizontalCenter
                        anchors.verticalCenter: b3l1C.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("1C")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b3l2A
                        x: 705
                        y: 250

                        btnBlock: "3"
                        btnLot: "2A"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l2A.horizontalCenter
                        anchors.verticalCenter: b3l2A.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("2A")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b3l2B
                        x: 680
                        y: 240

                        btnBlock: "3"
                        btnLot: "2B"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l2B.horizontalCenter
                        anchors.verticalCenter: b3l2B.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("2B")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b3l3
                        x: 685
                        y: 215

                        btnBlock: "3"
                        btnLot: "3"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l3.horizontalCenter
                        anchors.verticalCenter: b3l3.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("3")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b3l4A
                        x: 677
                        y: 187

                        btnBlock: "3"
                        btnLot: "4A"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l4A.horizontalCenter
                        anchors.verticalCenter: b3l4A.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("4A")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b3l4B
                        x: 675
                        y: 160

                        btnBlock: "3"
                        btnLot: "4B"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l4B.horizontalCenter
                        anchors.verticalCenter: b3l4B.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("4B")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b3l4C
                        x: 652
                        y: 166

                        btnBlock: "3"
                        btnLot: "4C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l4C.horizontalCenter
                        anchors.verticalCenter: b3l4C.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("4C")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b3l5
                        x: 656
                        y: 122

                        btnBlock: "3"
                        btnLot: "5"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l5.horizontalCenter
                        anchors.verticalCenter: b3l5.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("5")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b3l6A
                        x: 614
                        y: 123

                        btnBlock: "3"
                        btnLot: "6A"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l6A.horizontalCenter
                        anchors.verticalCenter: b3l6A.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("6A")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b3l6B
                        x: 624
                        y: 151

                        btnBlock: "3"
                        btnLot: "6B"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l6B.horizontalCenter
                        anchors.verticalCenter: b3l6B.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("6B")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b3l6C
                        x: 633
                        y: 177

                        btnBlock: "3"
                        btnLot: "6C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l6C.horizontalCenter
                        anchors.verticalCenter: b3l6C.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("6C")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b3l6D
                        x: 643
                        y: 202

                        btnBlock: "3"
                        btnLot: "6D"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l6D.horizontalCenter
                        anchors.verticalCenter: b3l6D.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("6D")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b3l7A
                        x: 593
                        y: 120

                        btnBlock: "3"
                        btnLot: "7A"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l7A.horizontalCenter
                        anchors.verticalCenter: b3l7A.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("7A")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b3l7B
                        x: 588
                        y: 138

                        btnBlock: "3"
                        btnLot: "7B"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l7B.horizontalCenter
                        anchors.verticalCenter: b3l7B.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("7B")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b3l7C
                        x: 572
                        y: 125

                        btnBlock: "3"
                        btnLot: "7C"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l7C.horizontalCenter
                        anchors.verticalCenter: b3l7C.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("7C")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b3l7D
                        x: 566
                        y: 145

                        btnBlock: "3"
                        btnLot: "7D"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l7D.horizontalCenter
                        anchors.verticalCenter: b3l7D.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("7D")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b3l7E
                        x: 548
                        y: 135

                        btnBlock: "3"
                        btnLot: "7E"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l7E.horizontalCenter
                        anchors.verticalCenter: b3l7E.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("7E")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b3l7F
                        x: 540
                        y: 155

                        btnBlock: "3"
                        btnLot: "7F"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l7F.horizontalCenter
                        anchors.verticalCenter: b3l7F.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("7F")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b3l7G
                        x: 571
                        y: 181

                        btnBlock: "3"
                        btnLot: "7G"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l7G.horizontalCenter
                        anchors.verticalCenter: b3l7G.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("7G")
                        color: "#000000"
                    }HouseNum
                    {
                        id: b3l7H
                        x: 616
                        y: 215

                        btnBlock: "3"
                        btnLot: "7H"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l7H.horizontalCenter
                        anchors.verticalCenter: b3l7H.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("7H")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b3l8
                        x: 549
                        y: 231

                        btnBlock: "3"
                        btnLot: "8"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l8.horizontalCenter
                        anchors.verticalCenter: b3l8.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("8")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b3l9
                        x: 558
                        y: 257

                        btnBlock: "3"
                        btnLot: "9"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l9.horizontalCenter
                        anchors.verticalCenter: b3l9.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("9")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b3l10
                        x: 590
                        y: 236

                        btnBlock: "3"
                        btnLot: "10"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l10.horizontalCenter
                        anchors.verticalCenter: b3l10.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("10")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b3l11
                        x: 569
                        y: 314

                        btnBlock: "3"
                        btnLot: "11"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l11.horizontalCenter
                        anchors.verticalCenter: b3l11.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("11")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b3l12A
                        x: 636
                        y: 287

                        btnBlock: "3"
                        btnLot: "12A"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l12A.horizontalCenter
                        anchors.verticalCenter: b3l12A.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("12A")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b3l12B
                        x: 595
                        y: 290

                        btnBlock: "3"
                        btnLot: "12B"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l12B.horizontalCenter
                        anchors.verticalCenter: b3l12B.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("12B")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b3l12C
                        x: 670
                        y: 277

                        btnBlock: "3"
                        btnLot: "12C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b3l12C.horizontalCenter
                        anchors.verticalCenter: b3l12C.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("12C")
                        color: "#ffffff"
                    }

                    // Block 4
                    HouseNum
                    {
                        id: b4l1
                        x: 343
                        y: 564

                        btnBlock: "4"
                        btnLot: "1"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b4l1.horizontalCenter
                        anchors.verticalCenter: b4l1.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("1")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b4l2
                        x: 338
                        y: 482

                        btnBlock: "4"
                        btnLot: "2"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b4l2.horizontalCenter
                        anchors.verticalCenter: b4l2.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("2")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b4l3
                        x: 328
                        y: 445

                        btnBlock: "4"
                        btnLot: "3"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b4l3.horizontalCenter
                        anchors.verticalCenter: b4l3.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("3")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b4l4
                        x: 290
                        y: 468

                        btnBlock: "4"
                        btnLot: "4"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b4l4.horizontalCenter
                        anchors.verticalCenter: b4l4.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("4")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b4l5
                        x: 250
                        y: 476

                        btnBlock: "4"
                        btnLot: "5"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b4l5.horizontalCenter
                        anchors.verticalCenter: b4l5.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("5")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b4l6
                        x: 193
                        y: 484

                        btnBlock: "4"
                        btnLot: "6"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b4l6.horizontalCenter
                        anchors.verticalCenter: b4l6.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("6")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b4l7
                        x: 138
                        y: 524

                        btnBlock: "4"
                        btnLot: "7"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b4l7.horizontalCenter
                        anchors.verticalCenter: b4l7.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("7")
                        color: "#000000"
                    }
                    HouseNum
                    {
                        id: b4l8
                        x: 209
                        y: 546

                        btnBlock: "4"
                        btnLot: "8"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b4l8.horizontalCenter
                        anchors.verticalCenter: b4l8.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("8")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b4l9
                        x: 264
                        y: 559

                        btnBlock: "4"
                        btnLot: "9"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b4l9.horizontalCenter
                        anchors.verticalCenter: b4l9.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("9")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b4l10
                        x: 297
                        y: 563

                        btnBlock: "4"
                        btnLot: "10"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b4l10.horizontalCenter
                        anchors.verticalCenter: b4l10.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("10")
                        color: "#ffffff"
                    }

                    // Block 5
                    HouseNum
                    {
                        id: b5l1
                        x: 605
                        y: 674

                        btnBlock: "5"
                        btnLot: "1"
                        propertyType: "V"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l1.horizontalCenter
                        anchors.verticalCenter: b5l1.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("1")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l2
                        x: 590
                        y: 637

                        btnBlock: "5"
                        btnLot: "2"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l2.horizontalCenter
                        anchors.verticalCenter: b5l2.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("2")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l3
                        x: 569
                        y: 592

                        btnBlock: "5"
                        btnLot: "3"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l3.horizontalCenter
                        anchors.verticalCenter: b5l3.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("3")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l4
                        x: 524
                        y: 618

                        btnBlock: "5"
                        btnLot: "4"
                        propertyType: "V"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l4.horizontalCenter
                        anchors.verticalCenter: b5l4.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("4")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l5
                        x: 540
                        y: 554

                        btnBlock: "5"
                        btnLot: "5"
                        propertyType: "V"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l5.horizontalCenter
                        anchors.verticalCenter: b5l5.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("5")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l6
                        x: 522
                        y: 517

                        btnBlock: "5"
                        btnLot: "6"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l6.horizontalCenter
                        anchors.verticalCenter: b5l6.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("6")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l7A
                        x: 522
                        y: 480

                        btnBlock: "5"
                        btnLot: "7A"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l7A.horizontalCenter
                        anchors.verticalCenter: b5l7A.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("7A")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l7B
                        x: 531
                        y: 448

                        btnBlock: "5"
                        btnLot: "7B"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l7B.horizontalCenter
                        anchors.verticalCenter: b5l7B.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("7B")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l7C
                        x: 489
                        y: 459

                        btnBlock: "5"
                        btnLot: "7C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l7C.horizontalCenter
                        anchors.verticalCenter: b5l7C.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("7C")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l8
                        x: 500
                        y: 419

                        btnBlock: "5"
                        btnLot: "8"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l8.horizontalCenter
                        anchors.verticalCenter: b5l8.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("8")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l9A
                        x: 435
                        y: 434

                        btnBlock: "5"
                        btnLot: "9A"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l9A.horizontalCenter
                        anchors.verticalCenter: b5l9A.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("9A")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l9B
                        x: 437
                        y: 474

                        btnBlock: "5"
                        btnLot: "9B"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l9B.horizontalCenter
                        anchors.verticalCenter: b5l9B.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("9B")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l9C
                        x: 460
                        y: 468

                        btnBlock: "5"
                        btnLot: "9C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l9C.horizontalCenter
                        anchors.verticalCenter: b5l9C.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("9C")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l10
                        x: 402
                        y: 458

                        btnBlock: "5"
                        btnLot: "10"
                        propertyType: "V"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l10.horizontalCenter
                        anchors.verticalCenter: b5l10.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("10")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l11A
                        x: 435
                        y: 503

                        btnBlock: "5"
                        btnLot: "11A"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l11A.horizontalCenter
                        anchors.verticalCenter: b5l11A.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("11A")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l11B
                        x: 433
                        y: 538

                        btnBlock: "5"
                        btnLot: "11B"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l11B.horizontalCenter
                        anchors.verticalCenter: b5l11B.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("11B")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l12
                        x: 451
                        y: 580

                        btnBlock: "5"
                        btnLot: "12"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l12.horizontalCenter
                        anchors.verticalCenter: b5l12.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("12")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l13
                        x: 441
                        y: 623

                        btnBlock: "5"
                        btnLot: "13"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l13.horizontalCenter
                        anchors.verticalCenter: b5l13.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("13")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l14
                        x: 491
                        y: 637

                        btnBlock: "5"
                        btnLot: "14"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l14.horizontalCenter
                        anchors.verticalCenter: b5l14.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("14")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l15
                        x: 543
                        y: 656

                        btnBlock: "5"
                        btnLot: "15"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l15.horizontalCenter
                        anchors.verticalCenter: b5l15.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("15")
                        color: "#ffffff"
                    }
                    HouseNum
                    {
                        id: b5l16
                        x: 565
                        y: 667

                        btnBlock: "5"
                        btnLot: "16"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b5l16.horizontalCenter
                        anchors.verticalCenter: b5l16.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("16")
                        color: "#ffffff"
                    }
                    
                    // Block 6
                    HouseNum
                    {
                        id: b6l1A
                        x: 501
                        y: 337

                        btnBlock: "6"
                        btnLot: "1A"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l1A.horizontalCenter
                        anchors.verticalCenter: b6l1A.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("1A")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l1B
                        x: 491
                        y: 290

                        btnBlock: "6"
                        btnLot: "1B"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l1B.horizontalCenter
                        anchors.verticalCenter: b6l1B.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("1B")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l2A
                        x: 480
                        y: 260

                        btnBlock: "6"
                        btnLot: "2A"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l2A.horizontalCenter
                        anchors.verticalCenter: b6l2A.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("2A")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l2B
                        x: 445
                        y: 268

                        btnBlock: "6"
                        btnLot: "2B"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l2B.horizontalCenter
                        anchors.verticalCenter: b6l2B.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("2B")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l3
                        x: 457
                        y: 242

                        btnBlock: "6"
                        btnLot: "3"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l3.horizontalCenter
                        anchors.verticalCenter: b6l3.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("3")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l4A
                        x: 468
                        y: 220

                        btnBlock: "6"
                        btnLot: "4A"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l4A.horizontalCenter
                        anchors.verticalCenter: b6l4A.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("4A")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l4B
                        x: 428
                        y: 228

                        btnBlock: "6"
                        btnLot: "4B"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l4B.horizontalCenter
                        anchors.verticalCenter: b6l4B.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("4B")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l5
                        x: 441
                        y: 186

                        btnBlock: "6"
                        btnLot: "5"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l5.horizontalCenter
                        anchors.verticalCenter: b6l5.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("5")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l6
                        x: 376
                        y: 223

                        btnBlock: "6"
                        btnLot: "6"
                        propertyType: "C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l6.horizontalCenter
                        anchors.verticalCenter: b6l6.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("6")
                        color: "#000000"
                    }HouseNum
                    {
                        id: b6l7
                        x: 323
                        y: 240

                        btnBlock: "6"
                        btnLot: "7"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l7.horizontalCenter
                        anchors.verticalCenter: b6l7.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("7")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l8
                        x: 262
                        y: 245

                        btnBlock: "6"
                        btnLot: "8"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l8.horizontalCenter
                        anchors.verticalCenter: b6l8.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("8")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l9
                        x: 161
                        y: 259

                        btnBlock: "6"
                        btnLot: "9"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l9.horizontalCenter
                        anchors.verticalCenter: b6l9.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("9")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l10
                        x: 168
                        y: 324

                        btnBlock: "6"
                        btnLot: "10"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l10.horizontalCenter
                        anchors.verticalCenter: b6l10.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("10")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l11
                        x: 173
                        y: 350

                        btnBlock: "6"
                        btnLot: "11"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l11.horizontalCenter
                        anchors.verticalCenter: b6l11.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("11")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l12A
                        x: 179
                        y: 380

                        btnBlock: "6"
                        btnLot: "12A"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l12A.horizontalCenter
                        anchors.verticalCenter: b6l12A.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("12A")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l12B
                        x: 182
                        y: 410

                        btnBlock: "6"
                        btnLot: "12B"
                        propertyType: "V"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l12B.horizontalCenter
                        anchors.verticalCenter: b6l12B.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("12B")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l13A
                        x: 224
                        y: 406

                        btnBlock: "6"
                        btnLot: "13A"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l13A.horizontalCenter
                        anchors.verticalCenter: b6l13A.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("13A")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l13B
                        x: 220
                        y: 384

                        btnBlock: "6"
                        btnLot: "13B"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l13B.horizontalCenter
                        anchors.verticalCenter: b6l13B.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("13B")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l13C
                        x: 216
                        y: 364

                        btnBlock: "6"
                        btnLot: "13C"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l13C.horizontalCenter
                        anchors.verticalCenter: b6l13C.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("13C")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l13D
                        x: 210
                        y: 347

                        btnBlock: "6"
                        btnLot: "13D"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l13D.horizontalCenter
                        anchors.verticalCenter: b6l13D.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("13D")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l13E
                        x: 215
                        y: 328

                        btnBlock: "6"
                        btnLot: "13E"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l13E.horizontalCenter
                        anchors.verticalCenter: b6l13E.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("13E")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l13F
                        x: 200
                        y: 315

                        btnBlock: "6"
                        btnLot: "13F"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l13F.horizontalCenter
                        anchors.verticalCenter: b6l13F.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("13F")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l13G
                        x: 216
                        y: 280

                        btnBlock: "6"
                        btnLot: "13G"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l13G.horizontalCenter
                        anchors.verticalCenter: b6l13G.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("13G")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l13H
                        x: 242
                        y: 312

                        btnBlock: "6"
                        btnLot: "13H"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l13H.horizontalCenter
                        anchors.verticalCenter: b6l13H.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("13H")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l13I
                        x: 250
                        y: 347

                        btnBlock: "6"
                        btnLot: "13I"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l13I.horizontalCenter
                        anchors.verticalCenter: b6l13I.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("13I")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l13J
                        x: 255
                        y: 386

                        btnBlock: "6"
                        btnLot: "13J"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l13J.horizontalCenter
                        anchors.verticalCenter: b6l13J.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("13J")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l14
                        x: 299
                        y: 349

                        btnBlock: "6"
                        btnLot: "14"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l14.horizontalCenter
                        anchors.verticalCenter: b6l14.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("14")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l15
                        x: 360
                        y: 338

                        btnBlock: "6"
                        btnLot: "15"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l15.horizontalCenter
                        anchors.verticalCenter: b6l15.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("15")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l16
                        x: 417
                        y: 326

                        btnBlock: "6"
                        btnLot: "16"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l16.horizontalCenter
                        anchors.verticalCenter: b6l16.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("16")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l17A
                        x: 464
                        y: 344

                        btnBlock: "6"
                        btnLot: "17A"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l17A.horizontalCenter
                        anchors.verticalCenter: b6l17A.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("17A")
                        color: "#ffffff"
                    }HouseNum
                    {
                        id: b6l17B
                        x: 458
                        y: 299

                        btnBlock: "6"
                        btnLot: "17B"
                    }
                    Label
                    {
                        anchors.horizontalCenter: b6l17B.horizontalCenter
                        anchors.verticalCenter: b6l17B.verticalCenter
                        font.pixelSize: 15
                        text: qsTr("17B")
                        color: "#ffffff"
                    }
                }
            }

            Rectangle
            {
                id: legendBG
                color: "#000000"
                opacity: 0.5
                width: 200
                height: 210

                anchors.top: mapContainer.top
                anchors.right: mapContainer.right
                anchors.topMargin: 20
                anchors.rightMargin: 40

                MouseArea
                    {
                        anchors.fill: parent
                        onClicked:
                        {
                            console.log(mouseY)
                        }
                    }
            }
            Label
            {
                id: lblLegend
                color: "#ffffff"
                font.pixelSize: 15
                text: qsTr("<b>==== Legend ====</b>")

                anchors.horizontalCenter: legendBG.horizontalCenter
                anchors.top: legendBG.top

                anchors.topMargin: 10
            }
            Rectangle
            {
                id: rectResidential
                color: "#3232ff"
                opacity: 0.8

                height: 20
                width: 27
                anchors.left: legendBG.left
                anchors.top: lblLegend.bottom

                anchors.margins: 20
            }
            Label
            {
                id: lblResidential
                color: "#ffffff"
                font.pixelSize: 15
                text: qsTr("Residential Lot")

                anchors.left: rectResidential.right
                anchors.verticalCenter: rectResidential.verticalCenter
                
                anchors.margins: 20
            }
            Rectangle
            {
                id: rectCommercial
                color: "#ffff00"
                opacity: 0.8

                height: 20
                width: 27
                anchors.left: legendBG.left
                anchors.top: rectResidential.bottom

                anchors.margins: 20
            }
            Label
            {
                id: lblCommercial
                color: "#ffffff"
                font.pixelSize: 15
                text: qsTr("Commercial Lot")

                anchors.left: rectCommercial.right
                anchors.verticalCenter: rectCommercial.verticalCenter
                
                anchors.margins: 20
            }
            Rectangle
            {
                id: rectVacant
                color: "#323232"
                opacity: 0.8

                height: 20
                width: 27
                anchors.left: legendBG.left
                anchors.top: rectCommercial.bottom

                anchors.margins: 20
            }
            Label
            {
                id: lblVacant
                color: "#ffffff"
                font.pixelSize: 15
                text: qsTr("Vacant Lot")

                anchors.left: rectVacant.right
                anchors.verticalCenter: rectVacant.verticalCenter
                
                anchors.margins: 20
            }
            Rectangle
            {
                id: rectBarangay
                color: "#c83223"
                opacity: 0.8

                height: 20
                width: 27
                anchors.left: legendBG.left
                anchors.top: rectVacant.bottom

                anchors.margins: 20
            }
            Label
            {
                id: lblBarangay
                color: "#ffffff"
                font.pixelSize: 15
                text: qsTr("Barangay Hall")

                anchors.left: rectBarangay.right
                anchors.verticalCenter: rectBarangay.verticalCenter
                
                anchors.margins: 20
            }
        }
    }
}