#ifndef SIMULATIONCLASS_H
#define SIMULATIONCLASS_H

#include <QObject>
#include <QThread>
#include <QStandardItemModel>
#include "dronsmodel.h"
#include <QGeoCoordinate>

class SimulationClass : public QThread
{
    Q_OBJECT

    QStandardItemModel * trackModel;

public:
    explicit SimulationClass(QObject *parent = nullptr);

    void setModel(QStandardItemModel * model_in);

protected:
    void run();

signals:
    void coordinatesChanged(QString newDronLat, QString newDronLong, QModelIndex curIndex);
    void coordinatesToPolyne(QString newDronLat, QString newDronLong, QString dronName);
};

#endif // SIMULATIONCLASS_H
