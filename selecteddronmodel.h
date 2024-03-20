#ifndef SELECTEDDRONMODEL_H
#define SELECTEDDRONMODEL_H

#include <QObject>
#include <QStandardItemModel>

class SelectedDronModel : public QStandardItemModel
{
    Q_OBJECT
public:
    explicit SelectedDronModel(QObject *parent = nullptr);

    enum myRoles {
        DronTrackedDate = Qt::UserRole + 1,
        DronTrackedTime,
        DronTrackedName,
        DronTrackedLat,
        DronTrackedLong,
        DronTrakcedType,
        DronTrackedId,
    };

signals:
};

#endif // SELECTEDDRONMODEL_H
