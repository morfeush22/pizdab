#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QtQml>
#include "CommonElements/VirtualKeyboard/key_event_dispatcher.h"
#include "host_info.h"
#include "q_scheduler_config.h"
#include "thread_controller.h"


int main(int argc, char *argv[]) {
    //register types
    qRegisterMetaType<size_t>("size_t");
    qRegisterMetaType<Scheduler::data_source_t>("Scheduler::data_source_t");
    qRegisterMetaType<Scheduler::SchedulerConfig_t>("Scheduler::SchedulerConfig_t");
    qRegisterMetaType<UserFICData_t>("UserFICData_t");
    qRegisterMetaType<std::list<stationInfo> >("std::list<stationInfo>");
    qRegisterMetaType<QUserFICData *>("QUserFICData *");
    qRegisterMetaType<QSpectrumData *>("QSpectrumData *");

    QSchedulerConfig scheduler_config;
    ThreadController thread_controller;
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
    KeyEventDispatcher key_event_dispatcher;
    HostInfo host_info;

    //register singletons
    engine.rootContext()->setContextProperty("schedulerConfig", &scheduler_config);
    engine.rootContext()->setContextProperty("threadController", &thread_controller);
    engine.rootContext()->setContextProperty("keyEventDispatcher", &key_event_dispatcher);
    engine.rootContext()->setContextProperty("hostInfo", &host_info);

    //load main view into engine
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    //register quit signal
    QObject::connect(&engine, SIGNAL(quit()), &app, SLOT(quit()));

    return app.exec();
}
