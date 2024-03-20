#ifndef NETWORKMANAGER_H
#define NETWORKMANAGER_H

#include <QObject>
#include <QTcpSocket>
#include <QJsonDocument>
#include <QJsonObject>

class NetworkManager : public QObject
{
    Q_OBJECT

    QVector<QObject*> objectsVect;

    QTcpSocket * socket;

    enum nameOfObjest {
        DronsModelObj = 1,
        HistoryModelObj,
    };

    enum typeOfMessages {
        TrackedDron = 1,
    };

    explicit NetworkManager(QObject *parent = nullptr);

public:
    static NetworkManager * getInstance();
    void connectToHost();
    void registerObj(QObject*);

private slots:
    void slotConnected();
    void slotDisconnected();
    void slotReadyRead();

signals:
    void signalToDronsModel(QString dronId, QString dronName, QString dronLat, QString dronLong, QString dronType);
    void signalToHistoryModel(QString dronId, QString dronName, QString dronLat, QString dronLong, QString dronType, QString trackedDate, QString trackedTime);
};

#endif // NETWORKMANAGER_H
