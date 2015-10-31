#ifndef THREADCONTROLLER_H
#define THREADCONTROLLER_H

#include <QObject>
#include <QQmlListProperty>
#include <QThread>
#include <QVariantList>
#include "q_scheduler_config.h"
#include "q_spectrum_data.h"
#include "q_station_info.h"
#include "q_user_fic_data.h"
#include "ui_scheduler.h"

class ThreadController: public QObject {
    Q_OBJECT

    Q_PROPERTY(float snr READ snr NOTIFY snrChanged)
    Q_PROPERTY(QUserFICData * userFICExtraData READ userFICExtraData NOTIFY userFICExtraDataChanged)
    Q_PROPERTY(QString text READ text NOTIFY textChanged)
    Q_PROPERTY(QList<QObject *> stationList READ stationList NOTIFY stationListChanged)
    Q_PROPERTY(QSpectrumData * spectrumData READ spectrumData NOTIFY spectrumDataChanged)
    Q_PROPERTY(bool schedulerRunning READ schedulerRunning NOTIFY schedulerRunningChanged)

    UIScheduler *ui_scheduler_;
    QThread *scheduler_thread_;
    bool scheduler_running_;
    float snr_;
    std::string text_;  
    //variables QML formatted
    QUserFICData *q_user_fic_extra_data_;
    QList<QObject *> *q_station_list_;
    QSpectrumData *q_spectrum_data_;

    void ConnectSignals();
    Scheduler::SchedulerConfig_t parseConfig(QSchedulerConfig *config);

public:
    explicit ThreadController(QObject *parent = 0);
    virtual ~ThreadController();

    Q_INVOKABLE QVariantList getDevices();
    Q_INVOKABLE void startScheduler(QSchedulerConfig *config);
    Q_INVOKABLE void stopScheduler();
    Q_INVOKABLE void changeStation(quint16 new_station);

    float snr() const;
    QUserFICData *userFICExtraData() const;
    QString text() const;
    QList<QObject *> stationList() const;
    QSpectrumData *spectrumData() const;
    bool schedulerRunning() const;

signals:
    void schedulerProcess(Scheduler::SchedulerConfig_t);
    void schedulerRunningChanged();
    void snrChanged();
    void userFICExtraDataChanged();
    void textChanged();
    void stationListChanged();
    void spectrumDataChanged();

public slots:
    //hande result functions
    void HandleSNRData(float snr);
    void HandleFicExtraData(UserFICData_t user_fic_extra_data);
    void HandleRDSData(std::string text);
    void HandleStationInfoData(std::list<stationInfo> station_list);
    void HandleSpectrumData(std::vector<std::pair<size_t, float> > spectrum_data);
    void HandleSchedulerStarted();
    void HandleSchedulerStopped();

};

#endif // THREADCONTROLLER_H
