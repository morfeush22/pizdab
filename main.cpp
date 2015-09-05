#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include "thread_controller.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    UIScheduler ui_scheduler();
    //now pop up with devices list
    //next pop up with freq?
    //pass ui_scheduler to ThreadController and start

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
