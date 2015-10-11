#include "q_scheduler_config.h"

QSchedulerConfig::QSchedulerConfig(QObject *parent):
    QObject(parent),
    sampling_rate_(2048000),
    carrier_frequency_(209936),
    dongle_nr_(0),
    input_filename_("//home/morfeush22/project/sdr/Record3_katowice_iq.raw"),
    data_source_(Scheduler::DATA_FROM_FILE),
    initial_channel_(0x0) {
}

quint32 QSchedulerConfig::samplingRate() const {
    return sampling_rate_;
}

void QSchedulerConfig::setSamplingRate(const unsigned int sampling_rate) {
    sampling_rate_ = sampling_rate;

    emit samplingRateChanged();
}

quint32 QSchedulerConfig::carrierFrequency() const {
    return carrier_frequency_;
}

void QSchedulerConfig::setCarrierFrequency(const unsigned int carrier_frequency) {
    carrier_frequency_ = carrier_frequency;

    emit carrierFrequencyChanged();
}

int QSchedulerConfig::dongleNr() const {
    return dongle_nr_;
}

void QSchedulerConfig::setDongleNr(const unsigned int dongle_nr) {
    dongle_nr_ = dongle_nr;

    emit dongleNrChanged();
}

const char *QSchedulerConfig::inputFilename() const {
    return input_filename_.data();
}

void QSchedulerConfig::setInputFilename(QUrl input_filename) {
    input_filename_ = input_filename.toLocalFile().toUtf8();

    emit inputFilenameChanged();
}

Scheduler::data_source_t QSchedulerConfig::dataSource() const {
    return data_source_;
}

void QSchedulerConfig::setDataSource(const Scheduler::data_source_t data_source) {
    data_source_ = data_source;

    emit dataSourceChanged();
}

quint8 QSchedulerConfig::initialChannel() const {
    return initial_channel_;
}
