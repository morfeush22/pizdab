#include "q_station_info.h"

QStationInfo::QStationInfo(QObject* parent): QObject(parent) {

}

size_t QStationInfo::audioKbps() const {
    return audio_kbps_;
}

void QStationInfo::setAudioKbps(size_t audio_kbps) {
    audio_kbps_ = audio_kbps;
}

std::string QStationInfo::stationName() const {
    return station_name_;
}

void QStationInfo::setStationName(std::string station_name) {
    station_name_ = station_name;
}
