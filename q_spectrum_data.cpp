#include "q_spectrum_data.h"

QSpectrumData::QSpectrumData(QObject *parent):
    QObject(parent) {
    x_values_ << static_cast<qulonglong>(1);
    x_values_ << static_cast<qulonglong>(2);
    x_values_ << static_cast<qulonglong>(3);
    x_values_ << static_cast<qulonglong>(4);
    x_values_ << static_cast<qulonglong>(5);

    y_values_ << static_cast<float>(0.5);
    y_values_ << static_cast<float>(1);
    y_values_ << static_cast<float>(1.5);
    y_values_ << static_cast<float>(1);
    y_values_ << static_cast<float>(0.5);

    x_values_ << static_cast<qulonglong>(1);
    x_values_ << static_cast<qulonglong>(2);
    x_values_ << static_cast<qulonglong>(3);
    x_values_ << static_cast<qulonglong>(4);
    x_values_ << static_cast<qulonglong>(5);

    y_values_ << static_cast<float>(0.5);
    y_values_ << static_cast<float>(1);
    y_values_ << static_cast<float>(1.5);
    y_values_ << static_cast<float>(1);
    y_values_ << static_cast<float>(0.5);

    x_values_ << static_cast<qulonglong>(1);
    x_values_ << static_cast<qulonglong>(2);
    x_values_ << static_cast<qulonglong>(3);
    x_values_ << static_cast<qulonglong>(4);
    x_values_ << static_cast<qulonglong>(5);

    y_values_ << static_cast<float>(0.5);
    y_values_ << static_cast<float>(1);
    y_values_ << static_cast<float>(1.5);
    y_values_ << static_cast<float>(1);
    y_values_ << static_cast<float>(0.5);
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
