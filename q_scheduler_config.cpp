#include "q_scheduler_config.h"

QSchedulerConfig::QSchedulerConfig(QObject* parent) : QObject(parent) {

}

u_int32_t QSchedulerConfig::samplingRate() const {
    return sampling_rate_;
}

void QSchedulerConfig::setSamplingRate(const u_int32_t sampling_rate) {
    sampling_rate_ = sampling_rate;
    emit samplingRateChanged();
}

u_int32_t QSchedulerConfig::carrierFrequency() const {
    return carrier_frequency_;
}

void QSchedulerConfig::setCarrierFrequency(const u_int32_t carrier_frequency) {
    carrier_frequency_ = carrier_frequency;
    emit carrierFrequencyChanged();
}

size_t QSchedulerConfig::dongleNr() const {
    return dongle_nr_;
}

void QSchedulerConfig::setDongleNr(const size_t dongle_nr) {
    dongle_nr_ = dongle_nr;
    emit dongleNrChanged();
}

const char *QSchedulerConfig::inputFilename() const {
    return input_filename_;
}

void QSchedulerConfig::setInputFilename(const char *input_filename) {
    input_filename_ = input_filename;
    emit inputFilenameChanged();
}

Scheduler::data_source_t QSchedulerConfig::dataSource() const {
    return data_source_;
}

void QSchedulerConfig::setDataSource(const Scheduler::data_source_t data_source) {
    data_source_ = data_source;
    emit dataSourceChanged();
}

bool QSchedulerConfig::useSpeakers() const {
    return use_speakers_;
}

void QSchedulerConfig::setUseSpeakers(const bool use_speakers) {
    use_speakers_ = use_speakers;
    emit useSpeakersChanged();
}
