#ifndef SIMULATION_H
#define SIMULATION_H

#include <QObject>
#include <QDebug>
#include <QThread>
#include <QStandardItemModel>
#include "server.h"
#include <QDate>
#include <QTime>

class Simulation : public QThread
{
    Q_OBJECT

    QStandardItemModel *modelSimul;

public:
    explicit Simulation(QObject *parent = nullptr);

    void setModel(QStandardItemModel *model);

protected:
    void run();

signals:
    void trackedDron(QString name, QString id, QString dronLat, QString dronLong, QString date, QString time,QString type, QModelIndex curIndex);
};

#endif // SIMULATION_H
