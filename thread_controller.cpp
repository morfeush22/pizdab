#include "thread_controller.h"

ThreadController::ThreadController(UIScheduler *ui_scheduler, QObject *parent):
    QObject(parent),
    ui_scheduler_(ui_scheduler) {
    ui_scheduler->moveToThread(&scheduler_thread_);
    connect(&scheduler_thread_, &QThread::finished, ui_scheduler, &QObject::deleteLater);
    scheduler_thread_.start();
}

ThreadController::~ThreadController() {
    scheduler_thread_.quit();
    scheduler_thread_.wait();
}

void ThreadController::Process()
{

}

void ThreadController::HandleSchedulerError(int error_code)
{

}

void ThreadController::HandleSNRData(float snr)
{

}

void ThreadController::HandleFicExtraData(UserFICData_t user_fic_extra_data)
{

}

void ThreadController::HandleRDSData(std::string text)
{

}

void ThreadController::HandleStationInfoData(std::list<stationInfo> station_list)
{

}

