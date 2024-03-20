#include "bloksmodel.h"

BloksModel::BloksModel(QObject *parent)
    : QStandardItemModel{parent}
{
    QHash<int, QByteArray> roles;
    roles.insert(LatitudeRole, "latitude_block");
    roles.insert(LongitudeRole, "longitude_block");
    roles.insert(NameRole, "block_name");
    roles.insert(IdRole, "block_id");
    roles.insert(RadiusViewRole, "block_radView");
    this->setItemRoleNames(roles);

    insertColumn(columnCount());
    insertRows(0,2);

    setData(index(0,0), "51.6744", LatitudeRole);
    setData(index(0,0),"39.1999",LongitudeRole);
    setData(index(0,0), "Block 1", NameRole);
    setData(index(0,0), "1", IdRole);
    setData(index(0,0), "1000", RadiusViewRole);

    setData(index(1,0), "51.663", LatitudeRole);
    setData(index(1,0), "39.2051", LongitudeRole);
    setData(index(1,0), "Block 2", NameRole);
    setData(index(1,0), "2", IdRole);
    setData(index(1,0), "1000", RadiusViewRole);
}

void BloksModel::trackBlock(QString block_name)
{
    for(int i = 0 ; i < rowCount(); ++i)
    {
        QModelIndex cur_index = index(i,0);
        if(data(cur_index,NameRole) == block_name)
        {
            double newCenter_lat = data(cur_index, LatitudeRole).toDouble();
            double newCenter_long = data(cur_index, LongitudeRole).toDouble();
            emit newMapCenter(QString::number(newCenter_lat),QString::number(newCenter_long));
        }
    }
}

