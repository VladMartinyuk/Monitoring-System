#ifndef QUERYSNAMESPACE_H
#define QUERYSNAMESPACE_H

#include <QString>

namespace db {

static QString getAllUsersId()
{
    return "SELECT user_id FROM users;";
}

static QString checkUser(QString userCode, QString userPinCode)
{
    return "SELECT user_id FROM users WHERE user_code = '"+userCode+"' AND user_pinCode = '"+userPinCode+"';";
}

static QString regNewUser(int curId, QString userCode, QString userPinCode)
{
    return "INSERT INTO users VALUES("+QString::number(curId)+", '"+userCode+"', '"+userPinCode+"', '','', '');";
}

static QString getUserData(int user_id)
{
    return "SELECT user_name, user_lastName, user_surname FROM users WHERE user_id = "+QString::number(user_id)+"";
}

static QString changUserData(int userId, QString userName, QString userLastName, QString userSureName)
{
    return "UPDATE users SET user_name = '"+userName+"', user_lastName = '"+userLastName+"', user_surname = '"+userSureName+"' WHERE user_id = "+QString::number(userId)+";";
}

static QString getUserId(QString userCode, QString userPinCode)
{
    return "SELECT user_id FROM users WHERE user_code = "+userCode+" AND user_pinCode = "+userPinCode+";";
}

}

#endif // QUERYSNAMESPACE_H
