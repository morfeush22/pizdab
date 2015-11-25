TEMPLATE = app

QT += qml quick network websockets

QMAKE_CXXFLAGS_CXX11 =
QMAKE_CXXFLAGS_GNUCXX11 =

SOURCES += main.cpp \
    thread_controller.cpp \
    ui_scheduler.cpp \
    q_station_info.cpp \
    q_user_fic_data.cpp \
    q_scheduler_config.cpp \
    CommonElements/VirtualKeyboard/key_event_dispatcher.cpp \
    host_info.cpp \
    q_spectrum_data.cpp

RESOURCES += qml.qrc

target.path = /home/odroid

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

unix:!macx: LIBS += -L$$[QT_SYSROOT]/opt/sdr -lsdrdab

INCLUDEPATH += $$[QT_SYSROOT]/opt/sdr/sdrdab/src
DEPENDPATH += $$[QT_SYSROOT]/opt/sdr/sdrdab/src

unix:!macx: LIBS += -L$$[QT_SYSROOT]/opt/sdr/rtlsdr-bin/src/ -lrtlsdr

INCLUDEPATH += $$[QT_SYSROOT]/opt/sdr/rtlsdr/include
DEPENDPATH += $$[QT_SYSROOT]/opt/sdr/rtlsdr/include

CONFIG += link_pkgconfig
PKGCONFIG += gstreamer-1.0

unix:!macx:: LIBS += -pthread -lgstreamer-1.0 -lgobject-2.0 -lglib-2.0 -lpcre

HEADERS += \
    thread_controller.h \
    ui_scheduler.h \
    q_station_info.h \
    q_user_fic_data.h \
    q_scheduler_config.h \
    CommonElements/VirtualKeyboard/key_event_dispatcher.h \
    host_info.h \
    q_spectrum_data.h

LIBS += -Wl,-rpath-link=$$[QT_SYSROOT]/usr/lib/arm-linux-gnueabihf/mali-egl

LIBS += -Wl,-rpath=/opt/sdr
LIBS += -Wl,-rpath=/opt/sdr/rtlsdr-bin/src

DISTFILES +=
