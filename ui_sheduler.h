#ifndef UI_SHEDULER_H
#define UI_SHEDULER_H

#include <QMutex>
#include <QObject>
#include <scheduler.h>
#include <string.h>


class UIScheduler: public QObject, public Scheduler {
    Q_OBJECT

    virtual void ParametersFromSDR(scheduler_error_t error_code);
    virtual void ParametersFromSDR(float snr);
    virtual void ParametersFromSDR(UserFICData_t *user_fic_extra_data);
    virtual void ParametersFromSDR(std::string *text);

    scheduler_error_t errno_;

public:
    explicit UIScheduler(QObject *parent = 0);
    virtual ~UIScheduler();

    std::list<std::string> GetDevices();

signals:
    void SchedulerError(scheduler_error_t error_code);
    void SNRData(float snr);
    void FicExtraData(UserFICData_t user_fic_extra_data);
    void RDSData(std::string text);
    void StationInfoData(std::list<stationInfo>);

public slots:
    void StartWork(SchedulerConfig_t config);
    void StopWork();
    void ChangeStation(uint8_t new_station);

};

#endif // UI_SHEDULER_H
