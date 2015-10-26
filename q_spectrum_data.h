#ifndef QSPECTRUMDATA_H
#define QSPECTRUMDATA_H

#include <QObject>

class QSpectrumData: public QObject {
    Q_OBJECT

    Q_PROPERTY(QList<size_t> * xValues READ xValues NOTIFY xValuesChanged)
    Q_PROPERTY(QList<float> * yValues READ yValues NOTIFY yValuesChanged)

    QList<size_t> *x_values_;
    QList<float> *y_values_;

public:
    explicit QSpectrumData(QObject *parent = 0);
    virtual ~QSpectrumData();

    QList<size_t> *xValues() const;
    void setXValues(QList<size_t> &xValues);
    QList<float> *yValues() const;
    void setYValues(QList<float> &yValues);

signals:
    void xValuesChanged();
    void yValuesChanged();

};

#endif // QSPECTRUMDATA_H
