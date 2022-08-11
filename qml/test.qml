import QtQuick 2.15
import QtQuick.Controls 2.15

ApplicationWindow
{
    id: testapp

    width: 700
    height: 500

    color: "#12151c"

    visible: true

    GridView
    {
        anchors.fill: parent

        Column
        {
            Rectangle
            {
                height: 100
                width: 100
                color: "red"

                Rectangle
                {
                    anchors.fill: parent
                    anchors.margins: 10
                    color: "blue"
                }
            }

            Rectangle
            {
                height: 100
                width: 100
                color: "red"

                Rectangle
                {
                    anchors.fill: parent
                    anchors.margins: 10
                    color: "blue"
                }
            }
            Rectangle
            {
                height: 100
                width: 100
                color: "red"

                Rectangle
                {
                    anchors.fill: parent
                    anchors.margins: 10
                    color: "blue"
                }
            }
            Rectangle
            {
                height: 100
                width: 100
                color: "red"

                Rectangle
                {
                    anchors.fill: parent
                    anchors.margins: 10
                    color: "blue"
                }
            }
            Rectangle
            {
                height: 100
                width: 100
                color: "red"

                Rectangle
                {
                    anchors.fill: parent
                    anchors.margins: 10
                    color: "blue"
                }
            }
            Rectangle
            {
                height: 100
                width: 100
                color: "red"

                Rectangle
                {
                    anchors.fill: parent
                    anchors.margins: 10
                    color: "blue"
                }
            }
        }

        
        
    }
}