#include "networkmanager.h"

NetworkManager::NetworkManager(QObject *parent)
    : QObject{parent}
{
}

NetworkManager * NetworkManager::getInstance()
{
    static NetworkManager * instance = new NetworkManager;
    return instance;
}

void NetworkManager::connectToHost()
{
    qDebug() << "connect slot";
    socket = new QTcpSocket;
    connect(socket, &QTcpSocket::connected, this, &NetworkManager::slotConnected);
    connect(socket,&QTcpSocket::disconnected, this, &NetworkManager::slotDisconnected);
    connect(socket, &QTcpSocket::readyRead, this, &NetworkManager::slotReadyRead);
    try {
        socket->connectToHost("127.0.0.1",2323);
    }
    catch(...)
    {
        qDebug() << "exeption";
    }

    socket->waitForConnected();
}

void NetworkManager::registerObj(QObject *objIn)
{
    objectsVect.push_back(objIn);
    qDebug() << "oject name: " << objIn->objectName().toInt();
}

void NetworkManager::slotConnected()
{
    qDebug() << "Connected to server!";
}

void NetworkManager::slotDisconnected()
{
    qDebug() << "Disconnected!";
    socket->deleteLater();
}

void NetworkManager::slotReadyRead()
{
    QJsonDocument doc = QJsonDocument::fromJson(socket->readAll());
    int typeMessage = doc.object().value("type").toInt();
    switch (typeMessage)
    {
    case TrackedDron:
        QString dronName = doc.object().value("dron_name").toString();
        QString dronId = doc.object().value("dron_id").toString();
        QString dron_lat = doc.object().value("dron_lat").toString();
        QString dron_long = doc.object().value("dron_loong").toString();
        QString dron_type = doc.object().value("dron_type").toString();
        QString dronTracked_date = doc.object().value("dron_date").toString();
        QString dronTracked_time = doc.object().value("dron_time").toString();
        for(int i = 0 ; i < objectsVect.size(); ++i)
        {
            if(objectsVect[i]->objectName().toInt() == DronsModelObj)
            {
                emit signalToDronsModel(dronId,dronName,dron_lat,dron_long, dron_type);
            }
            if(objectsVect[i]->objectName().toInt() == HistoryModelObj)
            {
                emit signalToHistoryModel(dronId,dronName,dron_lat,dron_long,dron_type,dronTracked_date,dronTracked_time);
            }
        }
        break;
    }
}
