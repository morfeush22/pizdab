#ifndef QSTATIONINFO_H
#define QSTATIONINFO_H

#include <QObject>
#include <QString>

class QStationInfo: public QObject {
    Q_OBJECT

    Q_PROPERTY(size_t audioKbps READ audioKbps NOTIFY audioKbpsChanged)
    Q_PROPERTY(QString stationName READ stationName NOTIFY stationNameChanged)

    size_t audio_kbps_;
    std::string station_name_;

public:
    explicit QStationInfo(QObject* parent = 0);

    size_t audioKbps() const;
    void setAudioKbps(size_t audio_kbps);
    QString stationName() const;
    void setStationName(std::string station_name);

signals:
    void audioKbpsChanged();
    void stationNameChanged();

};

#endif // QSTATIONINFO_H
