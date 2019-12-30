#include "netserver.h"

NetServer::NetServer(int port, QObject *parent) : QTcpServer(parent)
{
	world = new World();
	gLogging::info("World created!");
	connect(this, SIGNAL(newConnection()), this, SLOT(newConnection()));
	listen(QHostAddress::Any, port);
	gLogging::info("Server opened and listening to incoming clients: " + QString::number(port));
}

void NetServer::newConnection()
{
	QTcpSocket *nsocket = nextPendingConnection();
	Client *nclient = new Client(nsocket, world->add_body(b2Vec2(), b2Vec2()));
	connect(nsocket, SIGNAL(readyRead()), nclient, SLOT(incomingData()));
	connect(nsocket, SIGNAL(disconnected()), nclient, SLOT(closed()));
	connect(nclient, SIGNAL(updatedInfo(Client *)), this, SLOT(sendAll_UpdatedInfo(Client *)));
	connect(nclient, SIGNAL(sendInfo(Client *, QByteArray)), this, SLOT(sendAll_sl(Client *, QByteArray)));
	players.append(nclient);
	nclient->set_id(n++);
	gLogging::info("New client: " + QString::number(nclient->get_id()));
	char aux[20];
	sprintf(aux, "%d %d %d", nclient->get_id(), 500, 400);
	nsocket->write(aux);
}

void NetServer::updatePos()
{
	for(Client *c : players)
	{
		for(Client *o : players)
		{
			if(c != o)
			{
				char aux[40];
				sprintf(aux, "1001 %d %d %d\n", o->get_id(), o->get_x(), o->get_y());
				QByteArray data(aux);
				if(c->send(data) < 0) players.removeAll(c);
			}
		}
	}
}

void NetServer::sendAll_UpdatedInfo(Client *cl)
{
	for(Client *c : players)
	{
		if(c != cl)
		{
			char aux[40];
			sprintf(aux, "1001 %d %d %d\n", cl->get_id(), cl->get_x(), cl->get_y());
			QByteArray data(aux);
			if(c->send(data) < 0) players.removeAll(c);

		}
	}
}

void NetServer::sendAll_sl(Client *cl, QByteArray data)
{
	for(Client *c: players)
	{
		if(c != cl)
		{
			if(c->send(data) < 0) players.removeAll(c);
		}
	}
}
