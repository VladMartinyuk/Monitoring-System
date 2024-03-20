#ifndef USER_H
#define USER_H

#include <QObject>
#include <QDebug>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QuerysNamespace.h>
#include <QDate>
#include <QDateTime>

class User : public QObject
{
    Q_OBJECT

    unsigned long int PRIME_CONST = 102938475612121;

    QSqlDatabase dbInUser;

    int countOfAuth = 0;
    int countOfAuthAdminPin = 0;

    QString userCode;
    QString userPinCode;
    QString adminPin;

    QString user_name;
    QString user_surName;
    QString user_lastName;

    QString hashUserCode();
    QString hashUserPinCode();

public:
    explicit User(QSqlDatabase * dbIn, QObject *parent = nullptr);

    Q_INVOKABLE void writeUserCode(QString number, QString curCode, QString codeSecret);
    Q_INVOKABLE void writeUserPin(QString number, QString curPin, QString pinSecret);
    Q_INVOKABLE void clearLastNumber(QString current, QString secret);
    Q_INVOKABLE void clearCurrentAndSecretValues(QString cur, QString secret);
    Q_INVOKABLE void setUserCode(QString userCode_in);
    Q_INVOKABLE void setUserPin(QString userPin_in);
    Q_INVOKABLE void setAdminPin(QString adminPin_in);
    Q_INVOKABLE void getUserProileData();
    Q_INVOKABLE void setUserName(QString name_in);
    Q_INVOKABLE void setUserLastName(QString lastName_in);
    Q_INVOKABLE void setUserSureName(QString surName_in);
    Q_INVOKABLE void changeUserData();
    Q_INVOKABLE void enterIntoSystem();
    Q_INVOKABLE void regsiterUser();
    Q_INVOKABLE void adminPinEntered();

    Q_INVOKABLE void getDate(QDate);

signals:
    void userCodeChanged(QString newCurCode, QString newCodeSecret, bool newNextButFlag);
    void userPinChanged(QString newCurPin, QString newPinSecret, bool newNextButFlag);
    void lastNumberCleared(QString newCurrent, QString newSecret, bool newNextFlag);
    void curAndSecretValCleared(QString clearedCurr, QString clearedSecret, bool clearedFlag);
    void successAuthorization();
    void unsuccessAuthorization();
    void tooMuchTrysAuth();
    void successRegistration();
    void unsuccessRegistration();
    void succesGetAdminPin();
    void unsuccesGetAdminPin();
    void getUserData(QString user_name, QString user_lastName, QString user_surName);
    void userProfileDataChanged(QString newUser_name, QString newUser_lastName, QString newUser_surName);
    void getSelectedDate(QString dateSelected);

};

#endif // USER_H
