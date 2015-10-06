#ifndef QUSERFICDATA_H
#define QUSERFICDATA_H

#include <QObject>

class QUserFICData: public QObject {
    Q_OBJECT

    Q_PROPERTY(bool dabPlus READ dabPlus NOTIFY dabPlusChanged)
    Q_PROPERTY(size_t bitrate READ bitrate NOTIFY bitrateChanged)
    Q_PROPERTY(quint16 currentStationId READ currentStationId NOTIFY currentStationIdChanged)

    bool dab_plus_;
    size_t bitrate_;
    quint16 current_station_id_;

public:
    explicit QUserFICData(QObject* parent = 0);

    bool dabPlus() const;
    void setDabPlus(bool dab_plus);
    size_t bitrate() const;
    void setBitrate(size_t bitrate);
    quint16 currentStationId() const;
    void setCurrentStationId(quint16 current_station_id);

signals:
    void dabPlusChanged();
    void bitrateChanged();
    void currentStationIdChanged();

};

#endif // QUSERFICDATA_H
