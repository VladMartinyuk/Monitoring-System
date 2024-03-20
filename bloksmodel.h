#ifndef BLOKSMODEL_H
#define BLOKSMODEL_H

#include <QObject>
#include <QStandardItemModel>

class BloksModel : public QStandardItemModel
{
    Q_OBJECT

public:
    explicit BloksModel(QObject *parent = nullptr);

    enum BlocksRoles {
        LatitudeRole = Qt::UserRole + 1,
        LongitudeRole,
        NameRole,
        IdRole,
        RadiusViewRole,
    };

    Q_ENUM(BlocksRoles)

    Q_INVOKABLE void trackBlock(QString block_name);


signals:
    void newMapCenter(QString newLat, QString newLong);
};

#endif // BLOKSMODEL_H
