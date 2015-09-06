#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "thread_controller.h"

int main(int argc, char *argv[]) {
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
