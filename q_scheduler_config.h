#ifndef QSCHEDULERCONFIG_H
#define QSCHEDULERCONFIG_H

#include <scheduler.h>
#include <QObject>

class QSchedulerConfig : public QObject {
    Q_OBJECT
    Q_PROPERTY(unsigned int samplingRate READ samplingRate NOTIFY samplingRateChanged)
    Q_PROPERTY(unsigned int carrierFrequency READ carrierFrequency NOTIFY carrierFrequencyChanged)
    Q_PROPERTY(unsigned int dongleNr READ dongleNr NOTIFY dongleNrChanged)
    Q_PROPERTY(const char * inputFilename READ inputFilename NOTIFY inputFilenameChanged)
    Q_PROPERTY(Scheduler::data_source_t dataSource READ dataSource NOTIFY dataSourceChanged)
    Q_PROPERTY(bool useSpeakers READ useSpeakers NOTIFY useSpeakersChanged)

    u_int32_t sampling_rate_;
    u_int32_t carrier_frequency_;
    size_t dongle_nr_;
    const char *input_filename_;
    Scheduler::data_source_t data_source_;
    bool use_speakers_;

public:
    explicit QSchedulerConfig(QObject* parent = 0);

    unsigned int samplingRate() const;
    void setSamplingRate(const u_int32_t sampling_rate);
    unsigned int carrierFrequency() const;
    void setCarrierFrequency(const u_int32_t carrier_frequency);
    unsigned int dongleNr() const;
    void setDongleNr(const size_t dongle_nr);
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
