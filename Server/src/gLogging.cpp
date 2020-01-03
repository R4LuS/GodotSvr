
#include "gLogging.h"


gLogging::gLogging() : QObject()
{

}

void gLogging::info(QString str)
{
    qDebug().nospace().noquote() << INFO_COLOR("[INFORMATION]") << str;
}

void gLogging::error(QString str)
{
    qDebug().nospace().noquote() << ERROR_COLOR("[ERROR]") << str;
}

void gLogging::warning(QString str)
{
    qDebug().nospace().noquote() << WARNING_COLOR("[WARNING]") << str;
}