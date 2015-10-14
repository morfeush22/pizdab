#ifndef KEYEVENTDISPATCHER_H
#define KEYEVENTDISPATCHER_H

#include <QObject>

class KeyEventDispatcher : public QObject {
        Q_OBJECT

    public:
        explicit KeyEventDispatcher(QObject *parent = 0);

    public slots:
        void emitKey(Qt::Key key);

};

#endif // KEYEVENTDISPATCHER_H
