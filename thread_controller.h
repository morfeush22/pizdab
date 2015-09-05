#ifndef THREADCONTROLLER_H
#define THREADCONTROLLER_H

#include "ui_sheduler.h"
#include <QObject>
#include <QThread>

class ThreadController : public QObject
{
    Q_OBJECT
    QThread scheduler_thread_;

public:
    explicit ThreadController(UIScheduler &ui_scheduler, QObject *parent = 0);

signals:

public slots:
    //hande result functions

};

#endif // THREADCONTROLLER_H
