#include "thread_controller.h"

void ThreadController::ConnectSignals() {
    connect(this, &ThreadController::schedulerProcess, ui_scheduler_, &UIScheduler::StartWork);
    connect(ui_scheduler_, &UIScheduler::SNRData, this, &ThreadController::HandleSNRData);
    connect(ui_scheduler_, &UIScheduler::FicExtraData, this, &ThreadController::HandleFicExtraData);
    connect(ui_scheduler_, &UIScheduler::RDSData, this, &ThreadController::HandleRDSData);
    connect(ui_scheduler_, &UIScheduler::StationInfoData, this, &ThreadController::HandleStationInfoData);
    connect(ui_scheduler_, &UIScheduler::SpectrumData, this, &ThreadController::HandleSpectrumData);
    connect(ui_scheduler_, &UIScheduler::SchedulerStarted, this, &ThreadController::HandleSchedulerStarted);
    connect(ui_scheduler_, &UIScheduler::SchedulerStopped, this, &ThreadController::HandleSchedulerStopped);
}

Scheduler::SchedulerConfig_t ThreadController::parseConfig(QSchedulerConfig *config) {
    Scheduler::SchedulerConfig_t new_config;
    new_config.data_source = static_cast<Scheduler::data_source_t>(config->dataSource());

    if (new_config.data_source == Scheduler::DATA_FROM_DONGLE)
        new_config.dongle_nr = config->dongleNr();
    else
        new_config.input_filename = config->inputFilename();

    new_config.sampling_rate = config->samplingRate();
    new_config.carrier_frequency = config->carrierFrequency();
    new_config.start_station_nr = config->initialChannel();

    return new_config;
}

ThreadController::ThreadController(QObject *parent):
    QObject(parent),
    scheduler_running_(false) {
    q_station_list_ = new QList<QObject *>;
    q_user_fic_extra_data_ = new QUserFICData;
    q_spectrum_data_ = new QSpectrumData;
}

ThreadController::~ThreadController() {
    if (scheduler_running_) {
        ui_scheduler_->StopWork();
        scheduler_thread_->quit();
        scheduler_thread_->wait();
        delete ui_scheduler_;
        delete scheduler_thread_;
    }

    for (QList<QObject *>::iterator it = q_station_list_->begin(); it != q_station_list_->end(); it++)
        delete (*it);

    delete q_station_list_;
    delete q_user_fic_extra_data_;
    delete q_spectrum_data_;
}

QVariantList ThreadController::getDevices() {
    QVariantList q_devices;
    std::list<std::string> devices = ui_scheduler_->GetDevices();
    for (std::list<std::string>::iterator it = devices.begin(); it != devices.end(); it++)
        q_devices << QString(it->c_str());

    return q_devices;
}

void ThreadController::startScheduler(QSchedulerConfig *config) {
    if (scheduler_running_)
        return;

    ui_scheduler_ = new UIScheduler;
    scheduler_thread_ = new QThread;
    ConnectSignals();
    scheduler_thread_->start();
    ui_scheduler_->moveToThread(scheduler_thread_);

    emit schedulerProcess(parseConfig(config));
}

void ThreadController::stopScheduler() {
    if (!scheduler_running_)
        return;

    ui_scheduler_->StopWork();
}

void ThreadController::changeStation(quint16 new_station) {
    ui_scheduler_->ChangeStation(new_station);
}

float ThreadController::snr() const {
    return snr_;
}

QUserFICData *ThreadController::userFICExtraData() const {
    return q_user_fic_extra_data_;
}

QString ThreadController::text() const {
    return QString(text_.c_str());
}

QList<QObject *> ThreadController::stationList() const {
    return *q_station_list_;
}

QSpectrumData *ThreadController::spectrumData() const {
    return q_spectrum_data_;
}

bool ThreadController::schedulerRunning() const {
    return scheduler_running_;
}

void ThreadController::HandleSNRData(float snr) {
    snr_ = snr;

    emit snrChanged();
}

void ThreadController::HandleFicExtraData(UserFICData_t user_fic_extra_data) {
    if ((user_fic_extra_data.validity_ & UserFICData_t::LABEL_VALID) && q_user_fic_extra_data_->currentStationId() != user_fic_extra_data.service_id_)
        q_user_fic_extra_data_->setCurrentStationId(user_fic_extra_data.service_id_);

    q_user_fic_extra_data_->setBitrate(user_fic_extra_data.bitrate_);
    q_user_fic_extra_data_->setDabPlus(user_fic_extra_data.DAB_plus_);

    emit userFICExtraDataChanged();
}

void ThreadController::HandleRDSData(std::string text) {
    text_ = text;

    emit textChanged();
}

void ThreadController::HandleStationInfoData(std::list<stationInfo> station_list) {
    for (QList<QObject *>::iterator it = q_station_list_->begin(); it != q_station_list_->end(); it++)
        delete (*it);

    q_station_list_->clear();

    for(std::list<stationInfo>::iterator it = station_list.begin(); it != station_list.end(); it++) {
        QStationInfo *item = new QStationInfo;
        item->setAudioKbps(it->audio_kbps);
        item->setStationName(it->station_name);
        item->setStationId(it->ServiceId);
        item->setSubChannelId(it->SubChannelId);
        q_station_list_->push_back(item);
    }

    emit stationListChanged();
}

void ThreadController::HandleSpectrumData(float *spectrum_data) {
    QVariantList x_values;
    QVariantList y_values;

    for (int i = 0; i < 800; i++) {
        x_values << static_cast<qulonglong>(i);
        y_values << static_cast<float>(spectrum_data[i]);
    }

    q_spectrum_data_->setXValues(x_values);
    q_spectrum_data_->setYValues(y_values);

    delete spectrum_data;

    emit spectrumDataChanged();
}

void ThreadController::HandleSchedulerStarted() {
    scheduler_running_ = true;

    emit schedulerRunningChanged();
}

void ThreadController::HandleSchedulerStopped() {
    scheduler_running_ = false;

    scheduler_thread_->quit();
    scheduler_thread_->wait();

    delete ui_scheduler_;
    delete scheduler_thread_;

    emit schedulerRunningChanged();
}
