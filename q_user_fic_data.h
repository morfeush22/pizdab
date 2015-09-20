#ifndef QUSERFICDATA_H
#define QUSERFICDATA_H

#include <QObject>

class QUserFICData: public QObject {
    Q_OBJECT
    Q_PROPERTY(bool dabPlus READ dabPlus NOTIFY dabPlusChanged)
    Q_PROPERTY(unsigned int bitrate READ bitrate NOTIFY bitrateChanged)

    bool dab_plus_;
    size_t bitrate_;

public:
    explicit QUserFICData(QObject* parent = 0);

    bool dabPlus() const;
    void setDabPlus(bool dab_plus);
    unsigned int bitrate() const;
    void setBitrate(size_t bitrate);

signals:
    void dabPlusChanged();
    void bitrateChanged();

};

#endif // QUSERFICDATA_H
