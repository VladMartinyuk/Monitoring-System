#include "selecteddronmodel.h"

SelectedDronModel::SelectedDronModel(QObject *parent)
    : QStandardItemModel{parent}
{
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
}


