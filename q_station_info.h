#ifndef QSTATIONINFO_H
#define QSTATIONINFO_H

#include <QObject>
#include <QString>

class QStationInfo: public QObject {
    Q_OBJECT

    Q_PROPERTY(size_t audioKbps READ audioKbps NOTIFY audioKbpsChanged)
    Q_PROPERTY(QString stationName READ stationName NOTIFY stationNameChanged)
    Q_PROPERTY(quint16 stationId READ stationId NOTIFY stationIdChanged)

    size_t audio_kbps_;
    std::string station_name_;
    quint16 station_id_;

public:
    explicit QStationInfo(QObject* parent = 0);

    size_t audioKbps() const;
    void setAudioKbps(size_t audio_kbps);
    QString stationName() const;
    void setStationName(std::string station_name);
    quint16 stationId() const;
    void setStationId(quint16 station_id);

signals:
    void audioKbpsChanged();
    void stationNameChanged();
    void stationIdChanged();

};

#endif // QSTATIONINFO_H
