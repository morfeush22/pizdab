#ifndef THREADCONTROLLER_H
#define THREADCONTROLLER_H

#include "ui_scheduler.h"
#include "q_station_info.h"
#include "q_user_fic_data.h"
#include <QObject>
#include <QThread>

class ThreadController: public QObject {
    Q_OBJECT

    UIScheduler *ui_scheduler_;
    QThread scheduler_thread_;

    //variables to keep obtained data
    float snr_;
    UserFICData_t user_fic_extra_data_;
    std::string text_;
    std::list<stationInfo> station_list_;
    bool scheduler_running_;

    //variables QML formatted
    QList<QStationInfo*> q_station_list_;
    QUserFICData q_user_fic_extra_data_;

public:
    explicit ThreadController(UIScheduler *ui_scheduler, QObject *parent = 0);
    virtual ~ThreadController();

    std::list<std::string> GetDevices();

signals:
    void SchedulerProcess(Scheduler::SchedulerConfig_t config);
    void SchedulerSuspend();
    void ChangeStation(uint8_t);
    void SNRChanged();
    void UserFICExtraDataChanged();
    void TextChanged();
    void StationListChanged();
    void SchedulerRunningChanged();

public slots:
    //hande result functions
    void HandleSNRData(float snr);
    void HandleFicExtraData(UserFICData_t user_fic_extra_data);
    void HandleRDSData(std::string text);
    void HandleStationInfoData(std::list<stationInfo> station_list);
    void HandleSchedulerStarted();
    void HandleSchedulerStopped();

};

#endif // THREADCONTROLLER_H
