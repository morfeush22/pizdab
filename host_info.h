#ifndef HOSTINFO_H
#define HOSTINFO_H

#include <QObject>
#include <QNetworkInterface>

class HostInfo : public QObject {
    Q_OBJECT

public:
    explicit HostInfo(QObject *parent = 0);
    Q_INVOKABLE QList<QString> addresses();
};

#endif // HOSTINFO_H
