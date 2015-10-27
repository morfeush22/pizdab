#ifndef QSPECTRUMDATA_H
#define QSPECTRUMDATA_H

#include <QObject>
#include <QVariantList>

class QSpectrumData: public QObject {
    Q_OBJECT

    Q_PROPERTY(QVariantList xValues READ xValues NOTIFY xValuesChanged)
    Q_PROPERTY(QVariantList yValues READ yValues NOTIFY yValuesChanged)

    QVariantList x_values_;
    QVariantList y_values_;

public:
    explicit QSpectrumData(QObject *parent = 0);
    virtual ~QSpectrumData();

    const QVariantList &xValues() const;
    void setXValues(QVariantList &xValues);
    const QVariantList &yValues() const;
    void setYValues(QVariantList &yValues);

signals:
    void xValuesChanged();
    void yValuesChanged();

};

#endif // QSPECTRUMDATA_H
