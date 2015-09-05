#include "ui_sheduler.h"

UIScheduler::UIScheduler(QObject *parent): QObject(parent), Scheduler() {

}

UIScheduler::~UIScheduler() {

}

std::list<std::string> UIScheduler::GetDevices() const {

}

void UIScheduler::StartWork() {

}

void UIScheduler::StopWork() {

}

void UIScheduler::ChangeStation(uint8_t new_station) {
    return;
}
