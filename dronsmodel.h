#ifndef DRONSMODEL_H
#define DRONSMODEL_H

#include <QObject>
#include <QStandardItemModel>
#include <QDebug>
#include "simulationclass.h"
#include <QGeoCoordinate>
#include "networkmanager.h"

class DronsModel : public QStandardItemModel
{
    Q_OBJECT

    enum objName {
        DronsModelObj = 1,
        HistoryModelObj,
    };

    QModelIndex checkObjModel(QString dronIdIn);

public:
    explicit DronsModel(QObject *parent = nullptr);

    enum DronsRoles {
        LatitudeRole = Qt::UserRole + 1,
        LongitudeRole,
        DronNameRole,
        DronIdRole,
        DronTypeRole,
    };

    Q_ENUM(DronsRoles)

    Q_INVOKABLE void trackDron(QString dronName);
   // Q_INVOKABLE void trackButClicked();

public slots:
   // void newDronCoordinates(QString newLat, QString newLong, QModelIndex curId);
    void trackedDronData(QString dronId, QString dronName, QString dronLat, QString dronLong, QString dronType);

signals:
    void newMapCenter(QString newMap_lat, QString newMap_long);
};



#endif // DRONSMODEL_H
