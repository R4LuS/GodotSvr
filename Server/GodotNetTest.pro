QT -= gui
QT += network
QT += core

CONFIG += c++11 console
CONFIG -= app_bundle
CONFIG += precompile_header

# The following define makes your compiler emit warnings if you use
# any Qt feature that has been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if it uses deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        src/client.cpp \
        src/main.cpp \
        src/netserver.cpp \
        src/gLogging.cpp \
        src/world.cpp

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

INCLUDEPATH += include

HEADERS += \
    include/client.h \
    include/netserver.h \
    include/gLogging.h \
    include/world.h

DESTDIR = bin
OBJECTS_DIR = generated_files
MOC_DIR = generated_files


win32:CONFIG(release, debug|release): LIBS += -L$$PWD/../../../../../../Box2D/build/src/release/ -lbox2d
else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/../../../../../../Box2D/build/src/debug/ -lbox2d
else:unix: LIBS += -L$$PWD/../../../../../../Box2D/build/src/ -lbox2d

INCLUDEPATH += $$PWD/../../../../../../Box2D/include
DEPENDPATH += $$PWD/../../../../../../Box2D/include

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../../../../../../Box2D/build/src/release/libbox2d.a
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../../../../../../Box2D/build/src/debug/libbox2d.a
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += $$PWD/../../../../../../Box2D/build/src/release/box2d.lib
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += $$PWD/../../../../../../Box2D/build/src/debug/box2d.lib
else:unix: PRE_TARGETDEPS += $$PWD/../../../../../../Box2D/build/src/libbox2d.a

