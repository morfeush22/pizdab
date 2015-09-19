#ifndef QSCHEDULERCONFIG_H
#define QSCHEDULERCONFIG_H

#include <scheduler.h>
#include <QObject>

class QSchedulerConfig : public QObject {
    Q_OBJECT

    u_int32_t sampling_rate_;
    u_int32_t carrier_frequency_;
    size_t dongle_nr_;
    const char *input_filename_;
    Scheduler::data_source_t data_source_;
    bool use_speakers_;

public:
    explicit QSchedulerConfig(QObject* parent = 0);

    u_int32_t samplingRate() const;
    void setSamplingRate(const u_int32_t sampling_rate);
    u_int32_t carrierFrequency() const;
    void setCarrierFrequency(const u_int32_t carrier_frequency);
    size_t dongleNr() const;
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
