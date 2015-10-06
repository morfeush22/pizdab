#include "ui_scheduler.h"

void UIScheduler::ParametersFromSDR(Scheduler::scheduler_error_t error_code) {
    errno_ = error_code;
}

void UIScheduler::ParametersFromSDR(float snr) {
    if (snr != snr)
        emit SNRData(snr);
}

void UIScheduler::ParametersFromSDR(UserFICData_t *user_fic_extra_data) {
    UserFICData_t new_data;
    std::list<stationInfo> new_station_list;

    new_data.DAB_plus_ = user_fic_extra_data->DAB_plus_;
    new_data.bitrate_ = user_fic_extra_data->bitrate_;

    if ((user_fic_extra_data->validity_ & UserFICData_t::LABEL_VALID) &&
            new_data.service_id_ != user_fic_extra_data->service_id_) {
        new_data.service_id_ = user_fic_extra_data->service_id_;
        new_data.service_label_ = user_fic_extra_data->service_label_;
        new_data.validity_ |= UserFICData_t::LABEL_VALID;
    }

    if ((user_fic_extra_data->validity_ & UserFICData_t::PROGRAMME_TYPE_VALID) &&
            user_fic_extra_data->programme_type_ < 32) {
        new_data.programme_type_ =
                *DataDecoder::InternationalProgrammeTable[user_fic_extra_data->programme_type_][0];
        new_data.validity_ |= UserFICData_t::PROGRAMME_TYPE_VALID;
    }

    new_station_list = user_fic_extra_data->stations;

    emit FicExtraData(new_data);
    emit StationInfoData(new_station_list);

    delete user_fic_extra_data;
}

void UIScheduler::ParametersFromSDR(std::string *text) {
    std::string new_text = *text;
    emit RDSData(new_text);
    delete text;
}

UIScheduler::UIScheduler(QObject *parent):
    QObject(parent),
    Scheduler(),
    errno_(OK) {

}

UIScheduler::~UIScheduler() {

}

std::list<std::string> UIScheduler::GetDevices() {
    std::list<std::string> devices;
    ListDevices(&devices);
    return devices;
}

void UIScheduler::StartWork(SchedulerConfig_t config) {
    emit SchedulerStarted();
    Start(config);
    std::cout << "stopped" << std::endl;
    emit SchedulerStopped();
}

void UIScheduler::StopWork() {
    Stop();
}

void UIScheduler::ChangeStation(quint8 new_station) {
    ParametersToSDR(0x6);
    std::cout << "changed" << std::endl;
}
