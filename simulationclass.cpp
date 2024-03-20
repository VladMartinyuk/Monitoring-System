#include "simulationclass.h"

SimulationClass::SimulationClass(QObject *parent)
    : QThread{parent}
{
}

void SimulationClass::setModel(QStandardItemModel *model_in)
{
    trackModel = model_in;
}

void SimulationClass::run()
{
    double longitude;
    double latitude;
    int time = 0;
    while(time++ != 100)
    {
        for(int i = 0 ; i < trackModel->rowCount(); ++i)
        {
            QModelIndex index_ = trackModel->index(i,0);
            longitude = trackModel->data(index_,DronsModel::LongitudeRole).toDouble();
            latitude = trackModel->data(index_,DronsModel::LatitudeRole).toDouble();
            QString name = trackModel->data(index_, DronsModel::DronNameRole).toString();
            longitude += 0.001;
            latitude += 0.001;
            emit coordinatesChanged(QString::number(latitude),QString::number(longitude),index_);
            emit coordinatesToPolyne(QString::number(latitude),QString::number(longitude), name);
            QThread::sleep(1);
        }
    }
}
