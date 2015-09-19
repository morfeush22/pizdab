#include "thread_controller.h"

ThreadController::ThreadController(UIScheduler *ui_scheduler, QObject *parent):
    QObject(parent),
    ui_scheduler_(ui_scheduler) {
    ui_scheduler->moveToThread(&scheduler_thread_);
    connect(&scheduler_thread_, &QThread::finished, ui_scheduler, &QObject::deleteLater);
    connect(this, &ThreadController::SchedulerProcess, ui_scheduler_, &UIScheduler::StartWork);
    connect(this, &ThreadController::SchedulerSuspend, ui_scheduler_, &UIScheduler::StopWork);
    connect(this, &ThreadController::ChangeStation, ui_scheduler_, &UIScheduler::ChangeStation);
    connect(ui_scheduler_, &UIScheduler::SNRData, this, &ThreadController::HandleSNRData);
    connect(ui_scheduler_, &UIScheduler::FicExtraData, this, &ThreadController::HandleFicExtraData);
    connect(ui_scheduler_, &UIScheduler::RDSData, this, &ThreadController::HandleRDSData);
    connect(ui_scheduler_, &UIScheduler::StationInfoData, this, &ThreadController::HandleStationInfoData);
    connect(ui_scheduler_, &UIScheduler::SchedulerStarted, this, &ThreadController::HandleSchedulerStarted);
    connect(ui_scheduler_, &UIScheduler::SchedulerStopped, this, &ThreadController::HandleSchedulerStopped);
    scheduler_thread_.start();

    //only test
    QSchedulerConfig config;
    //StartScheduler(&config);
}

ThreadController::~ThreadController() {
    emit SchedulerSuspend();
    scheduler_thread_.quit();
    scheduler_thread_.wait();

    for(QList<QStationInfo*>::iterator it = q_station_list_.begin(); it != q_station_list_.end(); it++)
        delete (*it);
}

std::list<std::string> ThreadController::GetDevices() {
    return ui_scheduler_->GetDevices();
}

void ThreadController::StartScheduler(QSchedulerConfig *config) {
    Scheduler::SchedulerConfig_t new_config;
    new_config.sampling_rate = config->samplingRate();
    new_config.carrier_frequency = config->carrierFrequency();
    new_config.input_filename = config->inputFilename();
    new_config.data_source = config->dataSource();
    new_config.use_speakers = config->useSpeakers();
    emit SchedulerProcess(new_config);
}

void ThreadController::StopScheduler() {
    emit SchedulerSuspend();
}

void ThreadController::HandleSNRData(float snr) {
    qDebug("Handling SNR");

    snr_ = snr;

    emit SNRChanged();
}

void ThreadController::HandleFicExtraData(UserFICData_t user_fic_extra_data) {
    qDebug("Handling FIC");

    q_user_fic_extra_data_.setBitrate(user_fic_extra_data.bitrate_);
    q_user_fic_extra_data_.setDABPlus(user_fic_extra_data.DAB_plus_);

    emit UserFICExtraDataChanged();
}

void ThreadController::HandleRDSData(std::string text) {
    qDebug("Handling RDS");

    text_ = text;

    emit TextChanged();
}

void ThreadController::HandleStationInfoData(std::list<stationInfo> station_list) {
    qDebug("Handling station info");

    for(QList<QStationInfo*>::iterator it = q_station_list_.begin(); it != q_station_list_.end(); it++)
        delete (*it);
    q_station_list_.clear();

    std::list<stationInfo>::iterator it;
    for(it = station_list.begin(); it != station_list.end(); it++) {
        QStationInfo* item = new QStationInfo;
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

    emit StationListChanged();
}

void ThreadController::HandleSchedulerStarted() {
    qDebug("Scheduler started");

    scheduler_running_ = true;

    emit SchedulerRunningChanged();
}

void ThreadController::HandleSchedulerStopped() {
    qDebug("Scheduler stopped");

    scheduler_running_ = false;

    emit SchedulerRunningChanged();
}
