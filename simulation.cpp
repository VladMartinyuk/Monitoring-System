#include "simulation.h"

Simulation::Simulation(QObject *parent)
    : QThread{parent}
{
    modelSimul = new QStandardItemModel;
}

void Simulation::setModel(QStandardItemModel *model)
{
    modelSimul = model;
}

void Simulation::run()
{
    int i = 0;
    double dronlat;
    double dronLong;
    while(i++ < 100)
    {
        for(int i = 0 ; i < modelSimul->rowCount(); ++i)
        {
            QModelIndex index = modelSimul->index(i,0);
            QString name = modelSimul->data(index,Server::Name).toString();
            QString id = modelSimul->data(index,Server::Id).toString();
            QString type = modelSimul->data(index, Server::Type).toString();
            dronlat = modelSimul->data(index,Server::Latitude).toDouble();
            dronLong = modelSimul->data(index,Server::Longitude).toDouble();
            dronlat += 0.0001;
            dronLong += 0.001;
            emit trackedDron(name, id, QString::number(dronlat), QString::number(dronLong), QDate::currentDate().toString(), QTime::currentTime().toString(),type,index);
            QThread::sleep(1);
        }
    }
}
