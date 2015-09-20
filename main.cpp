#include <QGuiApplication>
#include <QQmlContext>
#include <QQmlApplicationEngine>
#include <QtQml>
#include "thread_controller.h"
#include "q_scheduler_config.h"

int main(int argc, char *argv[]) {
    //register types
    qRegisterMetaType<Scheduler::SchedulerConfig_t>("Scheduler::SchedulerConfig_t");
    qRegisterMetaType<UserFICData_t>("UserFICData_t");
    qRegisterMetaType<std::list<stationInfo> >("std::list<stationInfo>");
    qRegisterMetaType<QUserFICData *>("QUserFICData *");
    qRegisterMetaType<QStationInfo *>("QStationInfo *");
    qmlRegisterType<QSchedulerConfig>("SDRDAB", 1, 0, "QSchedulerConfig");
    //qmlRegisterType<QStationInfo>("SDRDAB", 1, 0, "QStationInfo");

    UIScheduler ui_scheduler;
    ThreadController thread_controller(&ui_scheduler);

    QGuiApplication app(argc, argv);

    //now pop up with devices list
    //next pop up with freq?
    //pass ui_scheduler to ThreadController and start

    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("threadController", &thread_controller);
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
