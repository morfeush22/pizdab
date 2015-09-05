#ifndef UI_SHEDULER_H
#define UI_SHEDULER_H

#include <QObject>
#include <scheduler.h>
#include <string.h>


class UIScheduler: public QObject, public Scheduler {
    Q_OBJECT

public:
    explicit UIScheduler(QObject *parent = 0);
    virtual ~UIScheduler();

    std::list<std::string> GetDevices() const;

signals:
    void ParametersFromSDR(scheduler_error_t error_code);
    void ParametersFromSDR(float snr);
    void ParametersFromSDR(UserFICData_t *user_fic_extra_data);
    void ParametersFromSDR(std::string *text);

public slots:
    void StartWork();
    void StopWork();
    void ChangeStation(uint8_t new_station);

};

#endif // UI_SHEDULER_H
