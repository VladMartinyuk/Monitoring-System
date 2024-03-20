import QtQuick 2.15
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Window 2.3

Window {
    id: profile_wnd
    width: 1024
    height: 800
    visible: false
    color: "#A4A4A4"

    signal backToMap();


    property string userName: "Данные отсутствуют"
    property string userSureName: "Данные отсутствуют"
    property string userLastName: "Данные отсутствуют"


    EditUserProfileWnd{
        id: edit_user
        onBackToProfile: {
            edit_user.close()
            profile_wnd.show()
        }
    }

    Connections {
        target: user
        function onUserProfileDataChanged(newUser_name,newUser_lastName,newUser_surName)
        {
            userName = newUser_name
            userSureName = newUser_surName
            userLastName = newUser_lastName
            edit_user.close()
            profile_wnd.show()
        }
    }

    Rectangle {
        width: 747
        height: 682
        radius: 45
        border.color: "black"
        color: "white"
        anchors.centerIn: parent

        Label {
            color: "black"
            text: "Профиль"
            font.pixelSize: 40
            font.underline: true
            anchors.top: parent.top
            anchors.topMargin: 43
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Label {
            anchors.top: parent.top
            anchors.topMargin: 163
            anchors.left: parent.left
            anchors.leftMargin: 60
            color: "black"
            text: "Фамилия : "
            font.pixelSize: 28
        }

        Label {
            color: "black"
            font.pixelSize: 32
            anchors.top: parent.top
            anchors.topMargin: 163
            anchors.left: parent.left
            anchors.leftMargin: 229
            text: userLastName
        }

        Rectangle {
            anchors.top: parent.top
            anchors.topMargin: 220
            anchors.horizontalCenter: parent.horizontalCenter
            width: 627
            height: 3
            color: "black"
        }

        Label {
            anchors.top: parent.top
            anchors.topMargin: 278
            anchors.left: parent.left
            anchors.leftMargin: 60
            color: "black"
            text: "Имя : "
            font.pixelSize: 28
        }

        Label {
            color: "black"
            font.pixelSize: 32
            anchors.top: parent.top
            anchors.topMargin: 278
            anchors.left: parent.left
            anchors.leftMargin: 154
            text: userName
        }

        Rectangle {
            anchors.top: parent.top
            anchors.topMargin: 330
            anchors.horizontalCenter: parent.horizontalCenter
            width: 627
            height: 3
            color: "black"
        }

        Label {
            anchors.top: parent.top
            anchors.topMargin: 398
            anchors.left: parent.left
            anchors.leftMargin: 60
            color: "black"
            text: "Отчество : "
            font.pixelSize: 28
        }

        Label {
            color: "black"
            font.pixelSize: 32
            anchors.top: parent.top
            anchors.topMargin: 398
            anchors.left: parent.left
            anchors.leftMargin: 241
            text: userSureName
        }

        Rectangle {
            anchors.top: parent.top
            anchors.topMargin: 450
            anchors.horizontalCenter: parent.horizontalCenter
            width: 627
            height: 3
            color: "black"
        }

        Rectangle {
            width: 262
            height: 100
            radius: 28
            color: back_but.pressed ? "grey": "#D9D9D9"
            border.color: "black"
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.topMargin: 540
            anchors.leftMargin: 65
            Label {
                text: "Назад"
                anchors.centerIn: parent
                font.pixelSize: 32
                color: "black"
            }
            MouseArea {
                id: back_but
                anchors.fill: parent
                onClicked: {
                    backToMap()
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
            anchors.left: parent.left
            anchors.topMargin: 540
            anchors.leftMargin: 430
            Label {
                text: "Редактировать"
                anchors.centerIn: parent
                font.pixelSize: 32
                color: "black"
            }
            MouseArea {
                id: chang_but
                anchors.fill: parent
                onClicked:  {
                    edit_user.userName = userName
                    edit_user.userLastName = userLastName
                    edit_user.userSureName = userSureName
                    console.log(edit_user.userName, edit_user.userLastName,edit_user.userSureName)
                    edit_user.show()
                    profile_wnd.hide()
                }
            }
        }
    }
}

