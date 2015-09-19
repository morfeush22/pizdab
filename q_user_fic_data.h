#ifndef QUSERFICDATA_H
#define QUSERFICDATA_H

#include <QObject>

class QUserFICData: public QObject {
    Q_OBJECT
    Q_PROPERTY(bool DABPlus READ DABPlus NOTIFY DABPlusChanged)
    Q_PROPERTY(size_t bitrate READ bitrate NOTIFY bitrateChanged)

    bool DAB_plus_;
    size_t bitrate_;

public:
    explicit QUserFICData(QObject* parent = 0);

    bool DABPlus() const;
    void setDABPlus(bool DAB_Plus);
    size_t bitrate() const;
    void setBitrate(size_t bitrate);

signals:
    void DABPlusChanged();
    void bitrateChanged();

};

#endif // QUSERFICDATA_H
