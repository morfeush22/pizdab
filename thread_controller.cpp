#include "thread_controller.h"

ThreadController::ThreadController(UIScheduler *ui_scheduler, QObject *parent):
    QObject(parent),
    ui_scheduler_(ui_scheduler) {
    q_user_fic_extra_data_ = new QUserFICData;

    ui_scheduler->moveToThread(&scheduler_thread_);
    connect(&scheduler_thread_, &QThread::finished, ui_scheduler, &QObject::deleteLater);
    connect(this, &ThreadController::schedulerProcess, ui_scheduler_, &UIScheduler::StartWork);
    connect(this, &ThreadController::schedulerSuspend, ui_scheduler_, &UIScheduler::StopWork);
    connect(this, &ThreadController::changeStation, ui_scheduler_, &UIScheduler::ChangeStation);
    connect(ui_scheduler_, &UIScheduler::SNRData, this, &ThreadController::HandleSNRData);
    connect(ui_scheduler_, &UIScheduler::FicExtraData, this, &ThreadController::HandleFicExtraData);
    connect(ui_scheduler_, &UIScheduler::RDSData, this, &ThreadController::HandleRDSData);
    connect(ui_scheduler_, &UIScheduler::StationInfoData, this, &ThreadController::HandleStationInfoData);
    connect(ui_scheduler_, &UIScheduler::SchedulerStarted, this, &ThreadController::HandleSchedulerStarted);
    connect(ui_scheduler_, &UIScheduler::SchedulerStopped, this, &ThreadController::HandleSchedulerStopped);
    scheduler_thread_.start();

    //only test
    //QSchedulerConfig config;
    //StartScheduler(&config);
}

ThreadController::~ThreadController() {
    emit schedulerSuspend();
    scheduler_thread_.quit();
    scheduler_thread_.wait();

    for(QList<QObject *>::iterator it = q_station_list_.begin(); it != q_station_list_.end(); it++)
        delete (*it);

    delete q_user_fic_extra_data_;
}

std::list<std::string> ThreadController::GetDevices() {
    return ui_scheduler_->GetDevices();
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

float ThreadController::snr() const {
    return snr_;
}

QUserFICData *ThreadController::userFICExtraData() const {
    return q_user_fic_extra_data_;
}

std::string ThreadController::text() const {
    return text_;
}

QList<QObject *> ThreadController::stationList() const {
    return q_station_list_;
}

bool ThreadController::schedulerRunning() const {
    return scheduler_running_;
}

void ThreadController::HandleSNRData(float snr) {
    qDebug("Handling SNR");

    snr_ = snr;

    emit snrChanged();
}

void ThreadController::HandleFicExtraData(UserFICData_t user_fic_extra_data) {
    qDebug("Handling FIC");

    q_user_fic_extra_data_->setBitrate(user_fic_extra_data.bitrate_);
    q_user_fic_extra_data_->setDabPlus(user_fic_extra_data.DAB_plus_);

    emit userFICExtraDataChanged();
}

void ThreadController::HandleRDSData(std::string text) {
    qDebug("Handling RDS");

    text_ = text;

    emit textChanged();
}

void ThreadController::HandleStationInfoData(std::list<stationInfo> station_list) {
    qDebug("Handling station info");

    for(QList<QObject *>::iterator it = q_station_list_.begin(); it != q_station_list_.end(); it++)
        delete (*it);
    q_station_list_.clear();

    std::list<stationInfo>::iterator it;
    for(it = station_list.begin(); it != station_list.end(); it++) {
        QStationInfo *item = new QStationInfo;
        item->setAudioKbps(it->audio_kbps);
        item->setStationName(it->station_name);
        q_station_list_.push_back(item);
    }

    /*
    QList<QStationInfo*>::iterator it2;
    for(it2 = q_station_list_.begin(); it2 != q_station_list_.end(); it2++) {
        std::cout << (*it2)->audio_kbps() << std::endl;
        std::cout << (*it2)->station_name() << std::endl;
    }
    */

    emit stationListChanged();
}

void ThreadController::HandleSchedulerStarted() {
    qDebug("Scheduler started");

    scheduler_running_ = true;

    emit schedulerRunningChanged();
}

void ThreadController::HandleSchedulerStopped() {
    qDebug("Scheduler stopped");

    scheduler_running_ = false;

    emit schedulerRunningChanged();
}
