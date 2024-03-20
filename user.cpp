#include "user.h"

User::User(QSqlDatabase * dbIn, QObject *parent)
    : QObject{parent}
{
    dbInUser = *dbIn;
}

void User::writeUserCode(QString number, QString curCode, QString codeSecret)
{
    if(curCode.isEmpty())
    {
        curCode = number;
        codeSecret = "* ";
        emit userCodeChanged(curCode,codeSecret,false);
    }
    else if(curCode.length() < 7)
    {
        curCode += number;
        codeSecret += " * ";
        emit userCodeChanged(curCode,codeSecret,false);
    }
    else if(curCode.length() < 10)
    {
        curCode += number;
        codeSecret += " * ";
        emit userCodeChanged(curCode,codeSecret,true);
    }
}

void User::enterIntoSystem()
{
    QString queryStr = db::checkUser(hashUserCode(), hashUserPinCode());
    QSqlQuery queryAuthUser(dbInUser);
    queryAuthUser.exec(queryStr);
    if(countOfAuth != 3)
    {
        if(queryAuthUser.first())
        {
            emit successAuthorization();
        }
        else
        {
            emit unsuccessAuthorization();
            countOfAuth++;
        }
    }
    else
    {
        emit tooMuchTrysAuth();
    }
}

void User::regsiterUser()
{
    qDebug() << "slot registration";
    int curUserId = 0; // что бы получить необходимый индекс по которому будем добавлять
    QSqlQuery queryGetCurId(dbInUser); // запрос на поиск индекса
    queryGetCurId.exec(db::getAllUsersId());
    while(queryGetCurId.next())
    {
        curUserId++; // таком способом переменная станет равна последнему индексу в таблице users
    }
    curUserId++; // т.к нам надо зарегестрировать по новому индексу
    qDebug() << "user id: " << curUserId;
    QSqlQuery queryRegUser(dbInUser);
    QString regUserStr = db::regNewUser(curUserId,hashUserCode(),hashUserPinCode());
    if(queryRegUser.exec(regUserStr))
    {
        emit successRegistration();
    }
    else
    {
        emit unsuccessRegistration();
    }
}

void User::adminPinEntered()
{
    if(countOfAuthAdminPin != 3)
    {
    if(adminPin == "0000000000")
    {
        emit succesGetAdminPin();
    }
    else
    {
       emit unsuccesGetAdminPin();
        countOfAuthAdminPin++;
    }
    }
    else
    {

    }
}

void User::getDate(QDate date_in)
{
    emit getSelectedDate(date_in.toString());
}

void User::writeUserPin(QString number, QString curPin, QString pinSecret)
{
    if(curPin.isEmpty())
    {
        curPin = number;
        pinSecret = "* ";
        emit userPinChanged(curPin,pinSecret,false);
    }
    else if(curPin.length() < 7)
    {
        curPin += number;
        pinSecret += " * ";
        emit userPinChanged(curPin,pinSecret,false);
    }
    else if(curPin.length() < 10)
    {
        curPin += number;
        pinSecret += " * ";
        emit userPinChanged(curPin,pinSecret,true);
    }
}

void User::clearLastNumber(QString current, QString secret)
{
    current.chop(1);
    secret.chop(3);
    if(current.length() < 8)
    {
        emit lastNumberCleared(current, secret, false);
    }
    else
    {
        emit lastNumberCleared(current, secret, true);
    }
}

void User::clearCurrentAndSecretValues(QString cur, QString secret)
{
    cur = "";
    secret = "";
    emit curAndSecretValCleared(cur,secret,false);
}

void User::setUserCode(QString userCode_in)
{
    userCode = userCode_in;
}

void User::setUserPin(QString userPin_in)
{
    userPinCode = userPin_in;
}

void User::setAdminPin(QString adminPin_in)
{
    adminPin = adminPin_in;
}

void User::getUserProileData()
{
    QString user_name;
    QString user_surName;
    QString user_lastName;
    int usrId = 1111;
    QString strGetuserCode = db::getUserId(hashUserCode(), hashUserPinCode());
    QSqlQuery queryGetId(dbInUser);
    queryGetId.exec(strGetuserCode);
    if(queryGetId.first())
    {
        usrId = queryGetId.value("user_id").toInt();
    }
    else
    {
        qDebug() << "false";
    }
    QString strGetUserData = db::getUserData(usrId);
    QSqlQuery queryGetUserData(dbInUser);
    queryGetUserData.exec(strGetUserData);
    if(queryGetUserData.first())
    {
        user_name = queryGetUserData.value("user_name").toString();
        user_surName = queryGetUserData.value("user_surname").toString();
        user_lastName = queryGetUserData.value("user_lastName").toString();
    }
    else
    {
        qDebug() << "failed find user data";
    }
    emit getUserData(user_name,user_lastName,user_surName);
}

void User::setUserName(QString name_in)
{
    user_name = name_in;
    qDebug() << "seter name: "<< user_name;
}

void User::setUserLastName(QString lastName_in)
{
    user_lastName = lastName_in;
    qDebug() << "seter lastName:" << user_lastName;
}

void User::setUserSureName(QString surName_in)
{
    user_surName = surName_in;
    qDebug() << "seter surname :" << user_surName;
}

void User::changeUserData()
{
    int userId = 0;
    QString strGetUserId = db::getUserId(hashUserCode(), hashUserPinCode());
    QSqlQuery queryGetUsrId(dbInUser);
    queryGetUsrId.exec(strGetUserId);
    if(queryGetUsrId.first())
    {
        userId = queryGetUsrId.value("user_id").toInt();
    }
    else
    {
        qDebug() << "cant find user_id!";
    }
    QString strUpdateUsrData = db::changUserData(userId,user_name,user_lastName,user_surName);
    QSqlQuery queryChangeUserData(dbInUser);
    if(queryChangeUserData.exec(strUpdateUsrData))
    {
        emit userProfileDataChanged(user_name,user_lastName,user_surName);
    }
    else
    {
        qDebug() << "error update data";
    }
}

QString User::hashUserCode()
{
    unsigned long long int hasCode = 0;
    for(int i=1; i<userCode.length()+1; ++i)
    {
        int tmp = userCode[i].toLatin1(); // перевод в ASCI
        hasCode += tmp * userPinCode.toULongLong(); // хешируется пин кодом
    }
    return QString::number(hasCode);
}

QString User::hashUserPinCode()
{
    unsigned long long int hashCode = 0;
    for(int i=0; i<userPinCode.length(); ++i)
    {
        int tmp = userPinCode[i].toLatin1(); // перевод в ASCI
        hashCode += tmp * PRIME_CONST; // хешируется захардкоденной константой
    }
    return QString::number(hashCode);
}
