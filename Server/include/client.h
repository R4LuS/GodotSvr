#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QDebug>

#include <gLogging.h>


class Client : public QObject
{
	Q_OBJECT
public:
	Client(QTcpSocket *nsocket);
	int send(QByteArray data);
	int get_id() { return this->id; }
	void set_id(int id) { this->id = id; }
	int get_x() { return x; }
	int get_y() { return y; }

signals:
	void updatedInfo(Client *cliente);
	void sendInfo(Client *, QByteArray);

public slots:
	void incomingData();
	void closed();

private:
	QTcpSocket *socket;
	int x, y;
	int speedx = 500, speedy = 500;
	int id;
};

#endif // CLIENT_H
