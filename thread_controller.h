#ifndef THREADCONTROLLER_H
#define THREADCONTROLLER_H

#include <QQmlListProperty>
#include <QObject>
#include <QThread>
#include "ui_scheduler.h"
#include "q_scheduler_config.h"
#include "q_station_info.h"
#include "q_user_fic_data.h"

class ThreadController: public QObject {
    Q_OBJECT

    Q_PROPERTY(float snr READ snr NOTIFY snrChanged)
    Q_PROPERTY(QUserFICData * userFICExtraData READ userFICExtraData NOTIFY userFICExtraDataChanged)
    Q_PROPERTY(QString text READ text NOTIFY textChanged)
    Q_PROPERTY(QList<QObject *> stationList READ stationList NOTIFY stationListChanged)
    Q_PROPERTY(bool schedulerRunning READ schedulerRunning NOTIFY schedulerRunningChanged)

    UIScheduler *ui_scheduler_;
    QThread scheduler_thread_;

    //variables to keep obtained data
    float snr_;
    std::string text_;
    bool scheduler_running_;

    //variables QML formatted
    QList<QObject *> q_station_list_;
    QUserFICData *q_user_fic_extra_data_;

public:
    explicit ThreadController(UIScheduler *ui_scheduler, QObject *parent = 0);
    virtual ~ThreadController();

    Q_INVOKABLE QList<QString> GetDevices();
    Q_INVOKABLE void startScheduler(QSchedulerConfig *config);
    Q_INVOKABLE void stopScheduler();
    Q_INVOKABLE void changeStation(int new_station);

    float snr() const;
    QUserFICData *userFICExtraData() const;
    QString text() const;
    QList<QObject *> stationList() const;
    bool schedulerRunning() const;

signals:
    void schedulerProcess(Scheduler::SchedulerConfig_t);
    void snrChanged();
    void userFICExtraDataChanged();
    void textChanged();
    void stationListChanged();
    void schedulerRunningChanged();

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
