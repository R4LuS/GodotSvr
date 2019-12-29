#ifndef NETSERVER_H
#define NETSERVER_H

#include <QObject>
#include <QtNetwork>
#include <QDebug>
#include <QList>
#include <QTimer>

#include <client.h>
#include <gLogging.h>
#include <world.h>


class NetServer : public QTcpServer
{
	Q_OBJECT

public:
	NetServer(int port, QObject *parent = nullptr);

signals:
	void random1();

public slots:
	void updatePos();
	void newConnection();
	void sendAll_UpdatedInfo(Client *);
	void sendAll_sl(Client *, QByteArray);

private:
	QList<Client *> players;
	int n = 1;

	World *world;
};




#endif // NETSERVER_H

