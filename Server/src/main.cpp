#include <QCoreApplication>
#include "netserver.h"

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
	NetServer *server = new NetServer(atoi(argv[1]));
    return a.exec();
}
