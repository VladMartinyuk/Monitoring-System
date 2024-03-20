import QtQuick 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Item {
    width: parent.width
    height: parent.height

    visible: false

    signal changeToEnterCode();

    property string userPinCode;
    property string userPinCodeSecret;
    property bool nextButFlag: false

    Connections {
        target: user
        function onLastNumberCleared(newCurrent, newSecret, newNextFlag)
        {
            userPinCode = newCurrent
            userPinCodeSecret = newSecret
            nextButFlag = newNextFlag
        }
        function onUserPinChanged(newCurPin, newPinSecret, newNextButFlag)
        {
            userPinCode = newCurPin
            userPinCodeSecret = newPinSecret
            nextButFlag = newNextButFlag
        }
        function onCurAndSecretValCleared(clearedCurr, clearedSecret, clearedFlag)
        {
            userPinCode = clearedCurr
            userPinCodeSecret = clearedSecret
            nextButFlag = clearedFlag
        }
    }

    Label {
        text: "Введите ПИН - КОД"
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
            text: userPinCodeSecret
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
                    user.writeUserPin(one.text, userPinCode, userPinCodeSecret)
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
                onClicked:  {
                    user.writeUserPin(two.text, userPinCode, userPinCodeSecret)
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
                onClicked:  {
                    user.writeUserPin(three.text, userPinCode, userPinCodeSecret)
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
                onClicked:  {
                    user.writeUserPin(four.text, userPinCode, userPinCodeSecret)
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
                onClicked: {
                    user.writeUserPin(five.text, userPinCode, userPinCodeSecret)
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
                onClicked: {
                    user.writeUserPin(six.text, userPinCode, userPinCodeSecret)
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
                    user.writeUserPin(seven.text, userPinCode, userPinCodeSecret)
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
                    user.writeUserPin(eight.text, userPinCode, userPinCodeSecret)
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
                    user.writeUserPin(nine.text, userPinCode, userPinCodeSecret)
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
                    user.writeUserPin(zero.text, userPinCode, userPinCodeSecret)
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
                onClicked: {
                    user.clearLastNumber(userPinCode, userPinCodeSecret)
                }
            }
        }
        Label {
            anchors.top: parent.top
            anchors.topMargin: 540
            anchors.left: parent.left
            anchors.leftMargin: 73
            text: "Вернуться назад"
            font.pixelSize: 25
            color: "black"
            font.underline: true
            MouseArea {
                id: reg_but
                anchors.fill: parent
                onClicked: {
                    user.clearCurrentAndSecretValues(userPinCode, userPinCodeSecret)
                    changeToEnterCode()
                }
            }
        }
        Label {
            anchors.top: parent.top
            anchors.topMargin: 540
            anchors.left: parent.left
            anchors.leftMargin: 460
            visible: nextButFlag
            text: "Подтвердить"
            font.pixelSize: 25
            color: "black"
            font.underline: true
            MouseArea {
                id: enterPin_but
                anchors.fill: parent
                onClicked: {
                    user.setUserPin(userPinCode)
                    user.enterIntoSystem()
                    user.clearCurrentAndSecretValues(userPinCode, userPinCodeSecret)
                }
            }
        }
    }
}
