#include <QCoreApplication>
#include <QGuiApplication>
#include <QKeyEvent>
#include <QQuickItem>
#include "key_event_dispatcher.h"

#include <iostream>

KeyEventDispatcher::KeyEventDispatcher(QObject *parent) : QObject(parent) {
}

void KeyEventDispatcher::emitKey(Qt::Key key) {
    QQuickItem *receiver = qobject_cast<QQuickItem *>(QGuiApplication::focusObject());
    if (!receiver)
        return;

    if(key == Qt::Key_Escape) {
        receiver->setFocus(false);
        return;
    }

    QKeyEvent *press_event = new QKeyEvent(QEvent::KeyPress, key, Qt::NoModifier, QKeySequence(key).toString());
    QKeyEvent *release_event = new QKeyEvent(QEvent::KeyRelease, key, Qt::NoModifier);
    QCoreApplication::sendEvent(receiver, press_event);
    QCoreApplication::sendEvent(receiver, release_event);
}
