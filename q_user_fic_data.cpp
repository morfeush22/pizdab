#include "q_user_fic_data.h"

QUserFICData::QUserFICData(QObject* parent): QObject(parent) {

}

bool QUserFICData::DABPlus() const {
    return DAB_plus_;
}

void QUserFICData::setDABPlus(bool DAB_Plus) {
    DAB_plus_ = DAB_Plus;
}

size_t QUserFICData::bitrate() const {
    return bitrate_;
}

void QUserFICData::setBitrate(size_t bitrate) {
    bitrate_ = bitrate;
}
