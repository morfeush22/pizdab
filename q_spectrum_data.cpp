#include "q_spectrum_data.h"

QSpectrumData::QSpectrumData(QObject *parent):
    QObject(parent) {
    x_values_ = new QList<size_t>;
    y_values_ = new QList<float>;
}

QSpectrumData::~QSpectrumData() {
    delete x_values_;
    delete y_values_;
}

QList<size_t> *QSpectrumData::xValues() const {
    return x_values_;
}

void QSpectrumData::setXValues(QList<size_t> &xValues) {
    x_values_->swap(xValues);

    emit xValuesChanged();
}

QList<float> *QSpectrumData::yValues() const {
    return y_values_;
}

void QSpectrumData::setYValues(QList<float> &yValues) {
    y_values_->swap(yValues);

    emit yValuesChanged();
}
