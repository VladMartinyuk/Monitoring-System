#include "dronsmodel.h"
#include "memory"//

DronsModel::DronsModel(QObject *parent)
    : QStandardItemModel{parent}
{
    setObjectName(QString::number(DronsModelObj));
    QHash<int, QByteArray> roles;
    roles.insert(LatitudeRole, "dron_latitude");
    roles.insert(LongitudeRole, "dron_longitude");
    roles.insert(DronNameRole, "dron_name");
    roles.insert(DronIdRole, "dron_id");
    roles.insert(DronTypeRole, "dron_type");
    this->setItemRoleNames(roles);

    insertColumn(columnCount());

    connect(NetworkManager::getInstance(),&NetworkManager::signalToDronsModel,this,&DronsModel::trackedDronData);
}

void DronsModel::trackDron(QString dronName)
{
    for(int i = 0 ; i < rowCount(); ++i)
    {
        QModelIndex cur_index = index(i,0);
        if(data(cur_index,DronNameRole) == dronName)
        {
            double newCenter_lat = data(cur_index, LatitudeRole).toDouble();
            double newCenter_long = data(cur_index, LongitudeRole).toDouble();
            emit newMapCenter(QString::number(newCenter_lat),QString::number(newCenter_long));
        }
    }
}

void DronsModel::trackedDronData(QString dronId, QString dronName, QString dronLat, QString dronLong, QString dronType)
{
    QModelIndex indexCheck = checkObjModel(dronId);
    if(!indexCheck.isValid())
    {
        insertRow(rowCount());
        setData(index(rowCount()-1,0),dronId,DronIdRole);
        setData(index(rowCount()-1,0),dronName,DronNameRole);
        setData(index(rowCount()-1,0),dronLat,LatitudeRole);
        setData(index(rowCount()-1,0),dronLong,LongitudeRole);
        setData(index(rowCount()-1,0),dronType,DronTypeRole);
    }
    else
    {
        setData(indexCheck,dronId,DronIdRole);
        setData(indexCheck,dronName,DronNameRole);
        setData(indexCheck,dronLat,LatitudeRole);
        setData(indexCheck,dronLong,LongitudeRole);
        setData(indexCheck,dronType,DronTypeRole);
    }
}

QModelIndex DronsModel::checkObjModel(QString dronIdIn)
{
    for(int i = 0 ; i < rowCount(); ++i)
    {
        if(data(index(i,0),DronIdRole).toString() == dronIdIn)
        {
            return index(i,0);
        }
    }
    return QModelIndex();
}
