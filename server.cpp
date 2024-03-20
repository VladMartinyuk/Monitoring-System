#include "server.h"
#include <future>

Server::Server(QObject *parent)
    : QTcpServer{parent}
{
    QHash<int, QByteArray> roles;
    roles[Name] = "dron_name";
    roles[Id] = "dron_id";
    roles[Latitude] = "dron_latitude";
    roles[Longitude] = "dron_longitude";
    roles[Type] = "dron_type";
    roles[Time] = "dronTracked_time";
    roles[Date] = "dronTracked_date";

    model = new QStandardItemModel;
    model->insertColumn(0);
    model->insertRows(0,2);

    model->setData(model->index(0,0),"1",Id);
    model->setData(model->index(0,0),"dron1",Name);
    model->setData(model->index(0,0),"51.6757",Latitude);
    model->setData(model->index(0,0),"39.19885",Longitude);
    model->setData(model->index(0,0),"military",Type);
    model->setData(model->index(0,0),""+QDate::currentDate().toString()+"",Date);
    model->setData(model->index(0,0),""+QTime::currentTime().toString()+"",Time);

    model->setData(model->index(1,0),"2",Id);
    model->setData(model->index(1,0),"dron2",Name);
    model->setData(model->index(1,0),"51.667",Latitude);
    model->setData(model->index(1,0),"39.2055",Longitude);
    model->setData(model->index(1,0),"civil",Type);
    model->setData(model->index(1,0),""+QDate::currentDate().toString()+"",Date);
    model->setData(model->index(1,0),""+QTime::currentTime().toString()+"",Time);

    model->setItemRoleNames(roles);

    if(listen(QHostAddress::Any,2323))
    {
        qDebug() << "server start";
    }
}

void Server::slotTrackedDron(QString name, QString id, QString lat, QString loong,QString date, QString time,QString type,QModelIndex curIndex)
{
    model->setData(curIndex,name,Name);
    model->setData(curIndex,id,Id);
    model->setData(curIndex,lat,Latitude);
    model->setData(curIndex,loong,Longitude);
    model->setData(curIndex,time,Time);
    model->setData(curIndex,date,Date);
    model->setData(curIndex,type,Type);

    QVector<QString> dataToClient;
    dataToClient.push_back(name);
    dataToClient.push_back(id);
    dataToClient.push_back(lat);
    dataToClient.push_back(loong);
    dataToClient.push_back(date);
    dataToClient.push_back(time);
    dataToClient.push_back(type);
    std::future f = async(std::launch::async, [&](){ sendData(dataToClient); });
}

void Server::sendData(QVector<QString> vectIn)
{
    QJsonObject obj;
    obj["type"] = TrackedDron;
    obj["dron_id"] = vectIn[1];
    obj["dron_name"] = vectIn[0];
    obj["dron_lat"] = vectIn[2];
    obj["dron_loong"] = vectIn[3];
    obj["dron_date"] = vectIn[4];
    obj["dron_time"] = vectIn[5];
    obj["dron_type"] = vectIn[6];
    QJsonDocument doc;
    doc.setObject(obj);
    if(socket->isWritable())
    {
        socket->write(doc.toJson());
        socket->waitForBytesWritten(1000);
    }
    qDebug() << "send data to client:" << doc;
}

void Server::incomingConnection(qintptr descriptor)
{
    socket = new QTcpSocket;
    socket->setSocketDescriptor(descriptor);
    Simulation * simul = new Simulation;
    simul->setModel(model);
    simul->start();
    connect(simul, &Simulation::trackedDron, this, &Server::slotTrackedDron);
}
