#ifndef HISTORYTIMEMODEL_H
#define HISTORYTIMEMODEL_H

#include <QObject>
#include <QStandardItemModel>
#include <QDebug>
#include <QTime>
#include <QDate>
#include <QDateTime>
#include "networkmanager.h"
#include "selecteddronmodel.h"

struct Dron {
    QString dronlat;
    QString dronLong;
    QString dronTime;
    QString dronDate;
};

class HistoryTimeModel : public QStandardItemModel
{
    Q_OBJECT

    SelectedDronModel * selectModelDron;


    bool flag;
    QString idron;
    enum objName {
        DronsModelObj = 1,
        HistoryModelObj,
    };

public:
    explicit HistoryTimeModel(SelectedDronModel *selectedModelIn, QObject *parent = nullptr);

    enum myRoles {
        DronTrackedDate = Qt::UserRole + 1,
        DronTrackedTime,
        DronTrackedName,
        DronTrackedLat,
        DronTrackedLong,
        DronTrakcedType,
        DronTrackedId,
    };

    Q_INVOKABLE void getViewState(QString stateIn);
    Q_INVOKABLE void upFlag();
    Q_INVOKABLE void downFLag();
    Q_INVOKABLE void setDronId(QString idIn);
    Q_INVOKABLE void getPathOfCurrentDron(QString id);

public slots:
    void getTrackingDrons(QString dronId, QString dronName, QString dronLat, QString dronLong, QString dronType, QString trackedDate, QString trackedTime);

signals:
    void stateChanged(bool state);
    void modelChanged(QStandardItemModel *newHistoryModel);
    void changeModelPath();
};

#endif // HISTORYTIMEMODEL_H
