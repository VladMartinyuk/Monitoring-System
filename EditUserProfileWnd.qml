import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Window 2.3

Window {
    id: edit_profileDataWnd
    width: 1024
    height: 800
    visible: false
    color: "#A4A4A4"

    signal backToProfile();

    property string userName;
    property string userLastName;
    property string userSureName;

    Rectangle {
        width: 747
        height: 682
        color: "white"
        border.color: "black"
        anchors.centerIn: parent
        radius: 45
        Label {
            anchors.top: parent.top
            anchors.topMargin: 43
            anchors.horizontalCenter: parent.horizontalCenter
            text: "Редактирование"
            font.underline: true
            color: "black"
            font.pixelSize: 40
        }

        TextArea {
            id: lastname_input
            anchors.top: parent.top
            anchors.topMargin: 163
            anchors.left: parent.left
            anchors.leftMargin: 60
            placeholderText: "Фамилия..."
            font.pixelSize: 32
            width: 627
            clip: true
        }
        Rectangle {
            width: 627
            height: 3
            color: "black"
            anchors.top: parent.top
            anchors.topMargin: 220
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextArea {
            id: name_input
            anchors.top: parent.top
            anchors.topMargin: 278
            anchors.left: parent.left
            anchors.leftMargin: 60
            placeholderText: "Имя..."
            font.pixelSize: 32
            width: 627
            clip: true
        }
        Rectangle {
            width: 627
            height: 3
            color: "black"
            anchors.top: parent.top
            anchors.topMargin: 330
            anchors.horizontalCenter: parent.horizontalCenter
        }

        TextArea {
            id: surname_input
            anchors.top: parent.top
            anchors.topMargin: 398
            anchors.left: parent.left
            anchors.leftMargin: 60
            placeholderText: "Отчество..."
            font.pixelSize: 32
            width: 627
            clip: true
        }
        Rectangle {
            width: 627
            height: 3
            color: "black"
            anchors.top: parent.top
            anchors.topMargin: 450
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Rectangle {
            width: 262
            height: 100
            color: back_but.pressed ? "grey" : "#D9D9D9"
            border.color: "black"
            anchors.top: parent.top
            anchors.topMargin: 540
            anchors.left: parent.left
            anchors.leftMargin: 65
            radius: 28
            Label {
               anchors.centerIn: parent
               text: "Назад"
               font.pixelSize: 32
               color: "black"
            }
            MouseArea {
                id: back_but
                anchors.fill: parent
                onClicked: {
                    backToProfile()
                }
            }
        }

        Rectangle {
            width: 262
            height: 100
            radius: 28
            color: "#D9D9D9"
            border.color: "black"
            anchors.top: parent.top
            anchors.topMargin: 540
            anchors.left: parent.left
            anchors.leftMargin: 430
            Label {
                anchors.centerIn: parent
                text: "Сохранить"
                font.pixelSize: 32
                color: "black"
            }
            MouseArea {
                id: saveChanges_but
                anchors.fill: parent
                onClicked: {
                    if(name_input.text !== "")
                    {
                        userName = name_input.text
                    }
                    if(lastname_input.text !== "")
                    {
                        userLastName  = lastname_input.text
                    }
                    if(surname_input.text !== "")
                    {
                        userSureName = surname_input.text
                    }
                    console.log(userName,userLastName,userSureName)
                    user.setUserName(userName)
                    user.setUserLastName(userLastName)
                    user.setUserSureName(userSureName)
                    user.changeUserData()
                    name_input.clear()
                    lastname_input.clear()
                    surname_input.clear()
                }
            }
        }
    }
}
