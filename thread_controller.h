#ifndef THREADCONTROLLER_H
#define THREADCONTROLLER_H

#include "ui_scheduler.h"
#include <QObject>
#include <QThread>

class ThreadController: public QObject {
    Q_OBJECT

    UIScheduler *ui_scheduler_;
    QThread scheduler_thread_;

public:
    ThreadController(UIScheduler *ui_scheduler, QObject *parent = 0);
    virtual ~ThreadController();

signals:

public slots:
    void Process();

    void HandleSchedulerError(int error_code);
    void HandleSNRData(float snr);
    void HandleFicExtraData(UserFICData_t user_fic_extra_data);
    void HandleRDSData(std::string text);
    void HandleStationInfoData(std::list<stationInfo> station_list);
    //hande result functions

};

#endif // THREADCONTROLLER_H
