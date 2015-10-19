TEMPLATE = app

QT += qml quick network websockets

SOURCES += main.cpp \
    thread_controller.cpp \
    ui_scheduler.cpp \
    q_station_info.cpp \
    q_user_fic_data.cpp \
    q_scheduler_config.cpp \
    CommonElements/VirtualKeyboard/key_event_dispatcher.cpp \
    host_info.cpp

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
    thread_controller.h \
    ui_scheduler.h \
    q_station_info.h \
    q_user_fic_data.h \
    q_scheduler_config.h \
    CommonElements/VirtualKeyboard/key_event_dispatcher.h \
    host_info.h

DISTFILES +=
