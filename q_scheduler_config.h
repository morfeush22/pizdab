#ifndef QSCHEDULERCONFIG_H
#define QSCHEDULERCONFIG_H

#include <scheduler.h>
#include <QObject>

class QSchedulerConfig : public QObject {
    Q_OBJECT
    Q_PROPERTY(unsigned int samplingRate READ samplingRate WRITE setSamplingRate NOTIFY samplingRateChanged)
    Q_PROPERTY(unsigned int carrierFrequency READ carrierFrequency WRITE setCarrierFrequency NOTIFY carrierFrequencyChanged)
    Q_PROPERTY(unsigned int dongleNr READ dongleNr WRITE setDongleNr NOTIFY dongleNrChanged)
    Q_PROPERTY(const char * inputFilename READ inputFilename WRITE setInputFilename NOTIFY inputFilenameChanged)
    Q_PROPERTY(Scheduler::data_source_t dataSource READ dataSource WRITE setDataSource NOTIFY dataSourceChanged)
    Q_PROPERTY(bool useSpeakers READ useSpeakers WRITE setUseSpeakers NOTIFY useSpeakersChanged)

    u_int32_t sampling_rate_;
    u_int32_t carrier_frequency_;
    size_t dongle_nr_;
    const char *input_filename_;
    Scheduler::data_source_t data_source_;
    bool use_speakers_;

public:
    explicit QSchedulerConfig(QObject *parent = 0);

    unsigned int samplingRate() const;
    void setSamplingRate(const unsigned int sampling_rate);
    unsigned int carrierFrequency() const;
    void setCarrierFrequency(const unsigned int carrier_frequency);
    unsigned int dongleNr() const;
    void setDongleNr(const unsigned int dongle_nr);
    const char *inputFilename() const;
    void setInputFilename(const char *input_filename);
    Scheduler::data_source_t dataSource() const;
    void setDataSource(const Scheduler::data_source_t data_source);
    bool useSpeakers() const;
    void setUseSpeakers(const bool use_speakers);

signals:
    void samplingRateChanged();
    void carrierFrequencyChanged();
    void dongleNrChanged();
    void inputFilenameChanged();
    void dataSourceChanged();
    void useSpeakersChanged();

};

#endif // QSCHEDULERCONFIG_H
