#include "thread_controller.h"

ThreadController::ThreadController(UIScheduler *ui_scheduler, QObject *parent):
    QObject(parent),
    ui_scheduler_(ui_scheduler) {
    q_user_fic_extra_data_ = new QUserFICData;

    ui_scheduler->moveToThread(&scheduler_thread_);
    connect(&scheduler_thread_, &QThread::finished, ui_scheduler, &QObject::deleteLater);
    connect(this, &ThreadController::schedulerProcess, ui_scheduler_, &UIScheduler::StartWork);
    connect(this, &ThreadController::schedulerSuspend, ui_scheduler_, &UIScheduler::StopWork);
    connect(this, &ThreadController::stationChange, ui_scheduler_, &UIScheduler::ChangeStation);
    connect(ui_scheduler_, &UIScheduler::SNRData, this, &ThreadController::HandleSNRData);
    connect(ui_scheduler_, &UIScheduler::FicExtraData, this, &ThreadController::HandleFicExtraData);
    connect(ui_scheduler_, &UIScheduler::RDSData, this, &ThreadController::HandleRDSData);
    connect(ui_scheduler_, &UIScheduler::StationInfoData, this, &ThreadController::HandleStationInfoData);
    connect(ui_scheduler_, &UIScheduler::SchedulerStarted, this, &ThreadController::HandleSchedulerStarted);
    connect(ui_scheduler_, &UIScheduler::SchedulerStopped, this, &ThreadController::HandleSchedulerStopped);
    scheduler_thread_.start();
}

ThreadController::~ThreadController() {
    emit schedulerSuspend();
    scheduler_thread_.quit();
    scheduler_thread_.wait();

    for(QList<QObject *>::iterator it = q_station_list_.begin(); it != q_station_list_.end(); it++)
        delete (*it);

    delete q_user_fic_extra_data_;
}

QList<QString> ThreadController::GetDevices() {
    QList<QString> q_devices;
    std::list<std::string> devices = ui_scheduler_->GetDevices();
    for(std::list<std::string>::iterator it = devices.begin(); it != devices.end(); it++)
        q_devices.push_back(QString(it->c_str()));
    return q_devices;
}

void ThreadController::startScheduler(QSchedulerConfig *config) {
    Scheduler::SchedulerConfig_t new_config;
    new_config.sampling_rate = config->samplingRate();
    new_config.carrier_frequency = config->carrierFrequency();
    new_config.input_filename = config->inputFilename();
    new_config.data_source = config->dataSource();
    new_config.use_speakers = config->useSpeakers();
    emit schedulerProcess(new_config);
}

void ThreadController::stopScheduler() {
    emit schedulerSuspend();
}

void ThreadController::changeStation(quint16 new_station) {
    emit stationChange(new_station);
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
    return q_station_list_;
}

bool ThreadController::schedulerRunning() const {
    return scheduler_running_;
}

void ThreadController::HandleSNRData(float snr) {
    snr_ = snr;

    emit snrChanged();
}

void ThreadController::HandleFicExtraData(UserFICData_t user_fic_extra_data) {
    q_user_fic_extra_data_->setBitrate(user_fic_extra_data.bitrate_);
    q_user_fic_extra_data_->setDabPlus(user_fic_extra_data.DAB_plus_);
    q_user_fic_extra_data_->setCurrentStationId(user_fic_extra_data.service_id_);

    emit userFICExtraDataChanged();
}

void ThreadController::HandleRDSData(std::string text) {
    text_ = text;

    emit textChanged();
}

void ThreadController::HandleStationInfoData(std::list<stationInfo> station_list) {
    for(QList<QObject *>::iterator it = q_station_list_.begin(); it != q_station_list_.end(); it++)
        delete (*it);
    q_station_list_.clear();

    for(std::list<stationInfo>::iterator it = station_list.begin(); it != station_list.end(); it++) {
        QStationInfo *item = new QStationInfo;
        item->setAudioKbps(it->audio_kbps);
        item->setStationName(it->station_name);
        item->setStationId(it->ServiceId);
        q_station_list_.push_back(item);
    }

    emit stationListChanged();
}

void ThreadController::HandleSchedulerStarted() {
    scheduler_running_ = true;

    emit schedulerRunningChanged();
}

void ThreadController::HandleSchedulerStopped() {
    scheduler_running_ = false;

    emit schedulerRunningChanged();
}
