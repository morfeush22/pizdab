TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp \
    ui_sheduler.cpp \
    thread_controller.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

unix:!macx: LIBS += -L$$PWD/../sdr/ -lsdrdab

INCLUDEPATH += $$PWD/../sdr/sdrdab/src
DEPENDPATH += $$PWD/../sdr/sdrdab/src

unix:!macx: LIBS += -L$$PWD/../sdr/rtlsdr-bin/src/ -lrtlsdr

INCLUDEPATH += $$PWD/../sdr/rtlsdr/include
DEPENDPATH += $$PWD/../sdr/rtlsdr/include

CONFIG += link_pkgconfig
PKGCONFIG += gstreamer-1.0

HEADERS += \
    ui_sheduler.h \
    thread_controller.h
