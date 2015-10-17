#include "host_info.h"

HostInfo::HostInfo(QObject *parent) : QObject(parent){
}

QList<QString> HostInfo::addresses() {
    QList<QHostAddress> addresses = QNetworkInterface::allAddresses();
    QList<QString> stringed;

    for (QList<QHostAddress>::const_iterator it = addresses.begin(); it != addresses.end(); it++) {
        stringed.append(it->toString());
    }

    return stringed;
}
