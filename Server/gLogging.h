#ifndef GLOGGING_H
#define GLOGGING_H



#include <QObject>
#include <QDebug>


class gLogging : public QObject
{
    Q_OBJECT
    public:
        gLogging();

        static void info(QString);
        static void error(QString);


    private:

};

typedef gLogging Log;


#define ERROR_COLOR(str) ("\e[31m" str "\e[0m") // RED
#define INFO_COLOR(str) ("\e[32m" str "\e[0m") // GREEN

#endif