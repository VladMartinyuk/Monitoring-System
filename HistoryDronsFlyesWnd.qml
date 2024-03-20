import QtQuick 2.15
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import QtLocation 5.9
import QtPositioning 5.8
import QtQuick.Window 2.3

Window {
    id: historyFlyWnd
    width: 1024
    height: 800
    color: "#A4A4A4"

    signal backButClicked();

    property bool butDateFlag: false

    property string selectedDate: "Дата не выбрана"

    Connections {
        target: user
        function onGetSelectedDate(dateSelected)
        {
            selectedDate = dateSelected
            butDateFlag = false
            dateButLabel.text = "Выберите дату"
            clndr.visible = false
        }
    }

    Rectangle {
        anchors.top: parent.top
        width: parent.width
        height: 90
        color: "#D9D9D9"
        border.color: "black"
        Label {
            anchors.centerIn: parent
            text: "История полетов"
            font.pixelSize: 36
            color: "white"
            style: Text.Outline
            styleColor: "black"
        }
    }

    Label {
        text: "Выберите дрон:"
        font.pixelSize: 36
        anchors.top: parent.top
        anchors.topMargin: 111
        anchors.left: parent.left
        anchors.leftMargin: 15
        color: "white"
        style: Text.Outline
        styleColor: "black"
    }

    ListView {
        id: drons_view
        model: historyModel
        height: parent.height - 182
        spacing: 13
        clip: true
        width: 301
        anchors.top: parent.top
        anchors.topMargin: 168
        anchors.left: parent.left
        anchors.leftMargin: 5
        delegate: Rectangle {
            width: drons_view.width
            height: 57
            radius: 29
            border.color: "black"
            color: timeBut.pressed ? "grey" : "#D9D9D9"
            Label {
                id: time_track
                text: trackedDron_time
                font.pixelSize: 32
                color: "black"
                anchors.centerIn: parent
            }
            MouseArea {
                id: timeBut
                anchors.fill: parent
            }
        }
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 158
        anchors.right: parent.right
        anchors.rightMargin: 10
        width: parent.width - 10 - 345
        height: parent.height - 10 - 158
        border.color: "black"
        Map {
            id: map
            anchors.fill: parent
            plugin: Plugin { name: "osm" }
            center: QtPositioning.coordinate(51.6720400, 39.1843000)
            zoomLevel: 14
        }
    }

    Label {
        text: "Дата:"
        color: "white"
        style: Text.Outline
        styleColor: "black"
        anchors.top: parent.top
        anchors.topMargin: 111
        anchors.left: parent.left
        anchors.leftMargin: 343
        font.pixelSize: 32
    }


    Label {
        id: dateButLabel
        anchors.top: parent.top
        anchors.topMargin: 111
        font.pixelSize: 32
        anchors.right: parent.right
        anchors.rightMargin: 13
        text: "Выберите дату"
        color: date_but.pressed ? "grey": "#D7FF66"
        font.underline: true
        MouseArea {
            id: date_but
            anchors.fill: parent
            onClicked: {
                if(!butDateFlag)
                {
                    clndr.visible = true
                    dateButLabel.text = "Закрыть календарь"
                    butDateFlag = true
                }
                else
                {
                    clndr.visible = false
                    dateButLabel.text = "Выберите дату"
                    butDateFlag = false
                }
            }
        }
    }

    Image {
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: 11
        anchors.leftMargin: 27
        width: 88
        height: 68
        source: "qrc:/images/backBut.png"
        MouseArea {
            id: backButton
            anchors.fill: parent
            onClicked:  {
                backButClicked()
            }
        }
    }

    Calendar {
        id: clndr
        anchors.top: parent.top
        anchors.topMargin: 158
        anchors.right: parent.right
        anchors.rightMargin: 10
        width: 439
        height: 316
        visible: false
        minimumDate: new Date(2017,0,1)
        onDoubleClicked: {
            user.getDate(clndr.selectedDate)
        }
    }

    Label {
        id: curDate
        anchors.top: parent.top
        anchors.topMargin: 111
        font.pixelSize: 32
        color: "white"
        style: Text.Outline
        styleColor: "black"
        anchors.left: parent.left
        anchors.leftMargin: 442
        text: selectedDate
    }

}
