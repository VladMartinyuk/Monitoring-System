#ifndef SERVER_H
#define SERVER_H

#include <QObject>
#include <QTcpServer>
#include <QTcpSocket>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>
#include <QStandardItemModel>
#include "simulation.h"
#include <QDate>
#include <QTime>

class Server : public QTcpServer
{
    Q_OBJECT

    QTcpSocket *socket;

    QStandardItemModel *model;

    enum typeOfMessages {
        TrackedDron = 1,
    };

    void sendData(QVector<QString>vectIn);

public:
    explicit Server(QObject *parent = nullptr);

    enum Roles {
        Name = Qt::UserRole+1,
        Id,
        Latitude,
        Longitude,
        Time,
        Date,
        Type
    };

    Q_ENUM(Roles)

public slots:
    void slotTrackedDron(QString name, QString id, QString lat, QString loong, QString date, QString time,QString type, QModelIndex curIndex);

protected:
    void incomingConnection(qintptr descriptor);

signals:
};

#endif // SERVER_H
