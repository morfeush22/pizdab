#include "q_user_fic_data.h"

QUserFICData::QUserFICData(QObject *parent): QObject(parent) {

}

bool QUserFICData::dabPlus() const {
    return dab_plus_;
}

void QUserFICData::setDabPlus(bool dab_plus) {
    dab_plus_ = dab_plus;
}

size_t QUserFICData::bitrate() const {
    return bitrate_;
}

void QUserFICData::setBitrate(size_t bitrate) {
    bitrate_ = bitrate;
}

quint16 currentStationId() const {
	return current_station_id_
}

void setCurrentStationId(quint16 current_station_id) {
	current_station_id_ = current_station_id
}