import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    width: parent.width
    height: parent.height

    visible: false

    signal changeToReg();
    signal changeToEnterPin();

    property string userCode;
    property string userCodeSecret;
    property bool nextButFlag: false;

    Connections {
        target: user
        function onUserCodeChanged(newCurCode, newCodeSecret, newNextButFlag)
        {
            userCode = newCurCode
            userCodeSecret = newCodeSecret
            nextButFlag = newNextButFlag
        }
        function onLastNumberCleared(newCurrent, newSecret, newNextFlag)
        {
            userCode = newCurrent
            userCodeSecret = newSecret
            nextButFlag = newNextFlag
        }
        function onCurAndSecretValCleared(clearedCurr, clearedSecret, clearedFlag)
        {
            userCode = clearedCurr
            userCodeSecret = clearedSecret
            nextButFlag = clearedFlag
        }
    }


    Label {
        text: "Введите Код Сотрудника"
        font.pixelSize: 32
        color: "white"
        style: Text.Outline
        styleColor: "black"
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Rectangle {
        width: 663
        height: 605
        anchors.centerIn: parent
        color: "white"
        radius: 45
        border.color: "black"
        Label {
            anchors.top: parent.top
            anchors.topMargin: 42
            anchors.horizontalCenter: parent.horizontalCenter
            font.pixelSize: 40
            color: "black"
            text: userCodeSecret
        }
        Rectangle {
            width: 516
            height: 2
            color: "black"
            anchors.top: parent.top
            anchors.topMargin: 90
            anchors.horizontalCenter: parent.horizontalCenter
        }
        Rectangle {
            width: 75
            height: 75
            radius: 12
            anchors.top: parent.top
            anchors.topMargin: 116
            anchors.left: parent.left
            anchors.leftMargin: 178
            color: "#D9D9D9"
            border.color: "black"
            Label {
                id: one
                text: "1"
                anchors.centerIn: parent
                font.pixelSize: 36
            }
            MouseArea {
                anchors.fill: parent
                onClicked:  {
                    user.writeUserCode(one.text, userCode, userCodeSecret)
                }
            }
        }
        Rectangle {
            width: 75
            height: 75
            radius: 12
            anchors.top: parent.top
            anchors.topMargin: 116
            anchors.left: parent.left
            anchors.leftMargin: 294
            color: "#D9D9D9"
            border.color: "black"
            Label {
                id: two
                text: "2"
                anchors.centerIn: parent
                font.pixelSize: 36
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    user.writeUserCode(two.text, userCode, userCodeSecret)
                }
            }
        }
        Rectangle {
            width: 75
            height: 75
            radius: 12
            anchors.top: parent.top
            anchors.topMargin: 116
            anchors.left: parent.left
            anchors.leftMargin: 409
            color: "#D9D9D9"
            border.color: "black"
            Label {
                id: three
                text: "3"
                anchors.centerIn: parent
                font.pixelSize: 36
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    user.writeUserCode(three.text, userCode, userCodeSecret)
                }
            }
        }
        Rectangle {
            width: 75
            height: 75
            radius: 12
            anchors.top: parent.top
            anchors.topMargin: 221
            anchors.left: parent.left
            anchors.leftMargin: 178
            color: "#D9D9D9"
            border.color: "black"
            Label {
                id: four
                text: "4"
                anchors.centerIn: parent
                font.pixelSize: 36
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    user.writeUserCode(four.text, userCode, userCodeSecret)
                }
            }
        }
        Rectangle {
            width: 75
            height: 75
            radius: 12
            anchors.top: parent.top
            anchors.topMargin: 221
            anchors.left: parent.left
            anchors.leftMargin: 294
            color: "#D9D9D9"
            border.color: "black"
            Label {
                id: five
                text: "5"
                anchors.centerIn: parent
                font.pixelSize: 36
            }
            MouseArea {
                anchors.fill: parent
                onClicked:  {
                    user.writeUserCode(five.text, userCode, userCodeSecret)
                }
            }
        }
        Rectangle {
            width: 75
            height: 75
            radius: 12
            anchors.top: parent.top
            anchors.topMargin: 221
            anchors.left: parent.left
            anchors.leftMargin: 409
            color: "#D9D9D9"
            border.color: "black"
            Label {
                id: six
                text: "6"
                anchors.centerIn: parent
                font.pixelSize: 36
            }
            MouseArea {
                anchors.fill: parent
                onClicked:  {
                    user.writeUserCode(six.text, userCode, userCodeSecret)
                }
            }
        }
        Rectangle {
            width: 75
            height: 75
            radius: 12
            anchors.top: parent.top
            anchors.topMargin: 320
            anchors.left: parent.left
            anchors.leftMargin: 178
            color: "#D9D9D9"
            border.color: "black"
            Label {
                id: seven
                text: "7"
                anchors.centerIn: parent
                font.pixelSize: 36
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    user.writeUserCode(seven.text, userCode, userCodeSecret)
                }
            }
        }
        Rectangle {
            width: 75
            height: 75
            radius: 12
            anchors.top: parent.top
            anchors.topMargin: 320
            anchors.left: parent.left
            anchors.leftMargin: 294
            color: "#D9D9D9"
            border.color: "black"
            Label {
                id: eight
                text: "8"
                anchors.centerIn: parent
                font.pixelSize: 36
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    user.writeUserCode(eight.text, userCode, userCodeSecret)
                }
            }
        }
        Rectangle {
            width: 75
            height: 75
            radius: 12
            anchors.top: parent.top
            anchors.topMargin: 320
            anchors.left: parent.left
            anchors.leftMargin: 409
            color: "#D9D9D9"
            border.color: "black"
            Label {
                id: nine
                text: "9"
                anchors.centerIn: parent
                font.pixelSize: 36
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    user.writeUserCode(nine.text, userCode, userCodeSecret)
                }
            }
        }
        Rectangle {
            width: 75
            height: 75
            radius: 12
            anchors.top: parent.top
            anchors.topMargin: 420
            anchors.left: parent.left
            anchors.leftMargin: 294
            color: "#D9D9D9"
            border.color: "black"
            Label {
                id: zero
                text: "0"
                anchors.centerIn: parent
                font.pixelSize: 36
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    user.writeUserCode(zero.text, userCode, userCodeSecret)
                }
            }
        }
        Image {
            anchors.top: parent.top
            anchors.topMargin: 415
            anchors.right: parent.right
            anchors.rightMargin: 185
            source: "qrc:/images/delete.png"
            width: 85
            height: 85
            MouseArea {
                id: clearNumber_but
                anchors.fill: parent
                onClicked:  {
                    user.clearLastNumber(userCode, userCodeSecret)
                }
            }
        }

        Label {
            anchors.top: parent.top
            anchors.topMargin: 540
            anchors.left: parent.left
            anchors.leftMargin: 73
            text: "Регистрация"
            font.pixelSize: 25
            color: "black"
            font.underline: true
            MouseArea {
                id: reg_but
                anchors.fill: parent
                onClicked: {
                    user.clearCurrentAndSecretValues(userCode, userCodeSecret)
                    changeToReg()
                }
            }
        }
        Label {
            anchors.top: parent.top
            anchors.topMargin: 540
            anchors.right: parent.right
            anchors.rightMargin: 74
            visible: nextButFlag
            text: "Ввести ПИН-КОД"
            font.pixelSize: 25
            color: "black"
            font.underline: true
            MouseArea {
                id: enterPin_but
                anchors.fill: parent
                onClicked:  {
                    user.setUserCode(userCode)
                    user.clearCurrentAndSecretValues(userCode, userCodeSecret)
                    changeToEnterPin()
                }
            }
        }
    }
}
