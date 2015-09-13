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
    scheduler_thread_.start();

    //only test
    Scheduler::SchedulerConfig_t config;
    config.sampling_rate = 2048000;
    config.carrier_frequency = 209936;
    config.input_filename = "/home/morfeush22/project/sdr/Record3_katowice_iq.raw";
    config.data_source = Scheduler::DATA_FROM_FILE;
    config.use_speakers = true;
    emit SchedulerProcess(config);
}

ThreadController::~ThreadController() {
    emit SchedulerSuspend();
    scheduler_thread_.quit();
    scheduler_thread_.wait();
}

std::list<std::string> ThreadController::GetDevices() {
    return ui_scheduler_->GetDevices();
}

void ThreadController::HandleSNRData(float snr) {

}

void ThreadController::HandleFicExtraData(UserFICData_t user_fic_extra_data) {

}

void ThreadController::HandleRDSData(std::string text) {

}

void ThreadController::HandleStationInfoData(std::list<stationInfo> station_list) {

}
