#ifndef QSCHEDULERCONFIG_H
#define QSCHEDULERCONFIG_H

#include <QObject>
#include <QUrl>
#include <scheduler.h>

class QSchedulerConfig : public QObject {
    Q_OBJECT

    Q_PROPERTY(quint32 samplingRate READ samplingRate WRITE setSamplingRate NOTIFY samplingRateChanged)
    Q_PROPERTY(quint32 carrierFrequency READ carrierFrequency WRITE setCarrierFrequency NOTIFY carrierFrequencyChanged)
    Q_PROPERTY(int dongleNr READ dongleNr WRITE setDongleNr NOTIFY dongleNrChanged)
    Q_PROPERTY(QUrl inputFilename READ inputFilename WRITE setInputFilename NOTIFY inputFilenameChanged)
    Q_PROPERTY(int dataSource READ dataSource WRITE setDataSource NOTIFY dataSourceChanged)

    quint32 sampling_rate_;
    quint32 carrier_frequency_;
    int dongle_nr_;
    QByteArray input_filename_;
    int data_source_;
    quint8 initial_channel_;

public:
    explicit QSchedulerConfig(QObject *parent = 0);
    virtual ~QSchedulerConfig();

    quint32 samplingRate() const;
    void setSamplingRate(const unsigned int sampling_rate);
    quint32 carrierFrequency() const;
    void setCarrierFrequency(const unsigned int carrier_frequency);
    int dongleNr() const;
    void setDongleNr(const unsigned int dongle_nr);
    const char *inputFilename() const;
    void setInputFilename(QUrl input_filename);
    int dataSource() const;
    void setDataSource(const int data_source);
    quint8 initialChannel() const;

signals:
    void samplingRateChanged();
    void carrierFrequencyChanged();
    void dongleNrChanged();
    void inputFilenameChanged();
    void dataSourceChanged();
    void useSpeakersChanged();

};

#endif // QSCHEDULERCONFIG_H
