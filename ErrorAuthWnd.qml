import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Popup
{
    width: 1024
    height: 400

    anchors.centerIn: parent

    signal butAgainClicked();

    Rectangle {
        anchors.fill: parent
        color: "#A4A4A4"
    }

    Text {
        text: "Ошибка авторизации!"
        font.pixelSize: 32
        color: "red"
        style: Text.Outline
        styleColor: "black"
        anchors.top: parent.top
        anchors.topMargin: 130
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        anchors.top: parent.top
        anchors.topMargin: 200
        anchors.horizontalCenter: parent.horizontalCenter
        width: 388
        height: 100
        radius: 34
        color: "#D9D9D9"
        border.color: "black"
        Label {
            text: "Ввести данные повторно"
            font.pixelSize: 26
            anchors.centerIn: parent
            color: "black"
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                butAgainClicked()
            }
        }
    }
}
