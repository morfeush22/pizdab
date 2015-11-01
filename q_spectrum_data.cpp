#include "q_spectrum_data.h"

QSpectrumData::QSpectrumData(QObject *parent):
    QObject(parent) {
}

QSpectrumData::~QSpectrumData() {
}

const QVariantList &QSpectrumData::xValues() const {
    return x_values_;
}

void QSpectrumData::setXValues(QVariantList &xValues) {
    x_values_.swap(xValues);

    emit xValuesChanged();
}

const QVariantList &QSpectrumData::yValues() const {
    return y_values_;
}

void QSpectrumData::setYValues(QVariantList &yValues) {
    y_values_.swap(yValues);

    emit yValuesChanged();
}
