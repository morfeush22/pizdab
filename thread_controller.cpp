#include "thread_controller.h"

ThreadController::ThreadController(UIScheduler &ui_scheduler, QObject *parent) : QObject(parent) {
    ui_scheduler.moveToThread(&scheduler_thread_);
    connect(&scheduler_thread_, &QThread::finished, &ui_scheduler, &QObject::deleteLater);
    scheduler_thread_.start();
}

