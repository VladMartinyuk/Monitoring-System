#include "historytimemodel.h"
#include <future>

HistoryTimeModel::HistoryTimeModel(SelectedDronModel *selectedModelIn,QObject *parent)
    : QStandardItemModel {parent}
{
    selectModelDron = selectedModelIn;
    setObjectName(QString::number(HistoryModelObj));
    QHash<int, QByteArray> roles;
    roles.insert(DronTrackedName, "trackedDron_name");
    roles.insert(DronTrackedLat, "trackedDron_lat");
    roles.insert(DronTrackedLong, "trackedDron_long");
    roles.insert(DronTrackedDate, "trackedDron_date");
    roles.insert(DronTrackedTime, "trackedDron_time");
    roles.insert(DronTrackedId, "trackedDron_id");
    roles.insert(DronTrakcedType, "trackedDron_type");
    this->setItemRoleNames(roles);
    insertColumn(0);

    connect(NetworkManager::getInstance(), &NetworkManager::signalToHistoryModel, this, &HistoryTimeModel::getTrackingDrons);
}

void HistoryTimeModel::getViewState(QString stateIn)
{
    if(stateIn == "Не отображать точки")
    {
        emit stateChanged(false);
    }
    else if(stateIn == "Отображать точки")
    {
        emit stateChanged(true);
    }
    else
    {
        emit stateChanged(false);
    }
}

void HistoryTimeModel::upFlag()
{
    flag = true;
}

void HistoryTimeModel::downFLag()
{
    flag = false;
    idron = "";
}

void HistoryTimeModel::setDronId(QString idIn)
{
    idron = idIn;
}

void HistoryTimeModel::getPathOfCurrentDron(QString id)
{
    qDebug() << id;
    selectModelDron->clear();
    selectModelDron->insertColumn(0);
    for(int i = 0 ; i < rowCount(); ++i)
    {
        QModelIndex _index_ = index(i,0);
        if(data(_index_,DronTrackedId).toString() == id)
        {
            QString dronlat = data(_index_,DronTrackedLat).toString();
            QString dronLong = data(_index_,DronTrackedLong).toString();
            QString dronTime = data(_index_,DronTrackedTime).toString();
            QString dronDate = data(_index_, DronTrackedDate).toString();
            selectModelDron->insertRow(selectModelDron->rowCount());
            selectModelDron->setData(selectModelDron->index(selectModelDron->rowCount()-1,0),dronlat, SelectedDronModel::DronTrackedLat);
            selectModelDron->setData(selectModelDron->index(selectModelDron->rowCount()-1,0),dronLong, SelectedDronModel::DronTrackedLong);
            selectModelDron->setData(selectModelDron->index(selectModelDron->rowCount()-1,0),dronTime, SelectedDronModel::DronTrackedTime);
            selectModelDron->setData(selectModelDron->index(selectModelDron->rowCount()-1,0),dronDate, SelectedDronModel::DronTrackedDate);
        }
    }
    emit changeModelPath();
}


void HistoryTimeModel::getTrackingDrons(QString dronId, QString dronName, QString dronLat, QString dronLong, QString dronType, QString trackedDate, QString trackedTime)
{
    insertRow(rowCount());
    setData(index(rowCount()-1,0),dronId,DronTrackedId);
    setData(index(rowCount()-1,0),dronName,DronTrackedName);
    setData(index(rowCount()-1,0),dronLat,DronTrackedLat);
    setData(index(rowCount()-1,0),dronLong,DronTrackedLong);
    setData(index(rowCount()-1,0),dronType,DronTrakcedType);
    setData(index(rowCount()-1,0),trackedDate,DronTrackedDate);
    setData(index(rowCount()-1,0),trackedTime,DronTrackedTime);
    if(flag == true)
    {
        getPathOfCurrentDron(idron);
    }
}

