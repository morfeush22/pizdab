#include "q_station_info.h"

QStationInfo::QStationInfo(QObject* parent): QObject(parent) {

}

size_t QStationInfo::audioKbps() const {
    return audio_kbps_;
}

void QStationInfo::setAudioKbps(size_t audio_kbps) {
    audio_kbps_ = audio_kbps;
}

QString QStationInfo::stationName() const {
    return QString(station_name_.c_str());
}

void QStationInfo::setStationName(std::string station_name) {
    station_name_ = station_name;
}

quint16 QStationInfo::stationId() const {
	return station_id_;
}

void QStationInfo::setStationId(quint16 station_id) {
    station_id_ = station_id;
}

quint8 QStationInfo::subChannelId() const {
    return sub_channel_id_;
}

void QStationInfo::setSubChannelId(quint8 sub_channel_id) {
    sub_channel_id_ = sub_channel_id;
}
