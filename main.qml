import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3

Window {
    id: main_wnd
    width: 1024
    height: 800
    visible: true
    title: qsTr("")

    color: "#A4A4A4"

    Connections {
        target: user
        function onSuccessRegistration()
        {
            console.log("succes reg!")
            map_wnd.show()
            main_wnd.hide()
        }
        function onSuccessAuthorization()
        {
            console.log("success auth!")
            map_wnd.show()
            main_wnd.hide()
        }
        function onUnsuccessAuthorization()
        {
            err_auth_wnd.open()
        }
        function onTooMuchTrysAuth()
        {
            tooMuchTry_wnd.open()
        }
        function onSuccesGetAdminPin()
        {
            main_stack.pop()
        }
        function onUnsuccesGetAdminPin()
        {
            errAdminPin_wnd.open()
        }
    }

    ErrorAdminPinWnd {
        id: errAdminPin_wnd
        onAdminPinAgain: {
            errAdminPin_wnd.close()
        }
    }

    ErrorAuthWnd {
        id: err_auth_wnd
        onButAgainClicked: {
            err_auth_wnd.close()
            main_stack.pop()
        }
    }

    ToMuchTryesError {
        id: tooMuchTry_wnd
        onChangeToEnterAdminPin: {
            tooMuchTry_wnd.close()
            main_stack.pop()
            main_stack.push(enterAdminPin_wnd)
        }
    }

    EnterAmdminPinCode {
        id: enterAdminPin_wnd
    }

    StackView {
        id: main_stack
        anchors.fill: parent

    }

    MapWindow {
        id: map_wnd
    }

    AuthorizationCode {
        id: auth_userCode
        onChangeToReg: {
            main_stack.pop()
            main_stack.push(reg_userCode)
        }
        onChangeToEnterPin: {
            main_stack.pop()
            main_stack.push(auth_userPin)
        }
    }

    AuthorizationPin {
        id: auth_userPin
        onChangeToEnterCode: {
            main_stack.pop()
        }
    }

    RegistrationCode {
        id: reg_userCode
        onChangeToEnterCode:  {
            main_stack.pop()
        }
        onChangeToRegPin: {
            main_stack.push(reg_userPin)
        }
    }

    RegistrationPin {
        id: reg_userPin
        onChangeToRegCode: {
            main_stack.pop()
        }
    }

    Component.onCompleted: {
        main_stack.push(auth_userCode)
    }
}
