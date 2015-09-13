#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "thread_controller.h"

int main(int argc, char *argv[]) {
    //register types for connect
    qRegisterMetaType<Scheduler::SchedulerConfig_t>("Scheduler::SchedulerConfig_t");
    qRegisterMetaType<UserFICData_t>("UserFICData_t");
    qRegisterMetaType<std::list<stationInfo> >("std::list<stationInfo>");

    UIScheduler ui_scheduler;
    ThreadController thread_controller(&ui_scheduler);

    QGuiApplication app(argc, argv);

    //now pop up with devices list
    //next pop up with freq?
    //pass ui_scheduler to ThreadController and start

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
