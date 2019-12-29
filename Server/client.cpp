#include "client.h"

Client::Client(QTcpSocket *nsocket)
{
	this->socket = nsocket;
}


void Client::incomingData()
{
	QByteArray data = socket->readLine();
	QByteArray sdata = "";
	auto aux = data.mid(4).split(' ');
	if(aux[0].length() <= 0) return;
	switch(aux[0].toInt())
	{
		case 1000:
			speedx = atoi(aux[1]);
			speedy = atoi(aux[2]);
			x = atoi(aux[3]);
			y = atoi(aux[4]);
			sdata += "1001 " + QString::number(id) + " " + QString::number(speedx) + " " + QString::number(speedy) + " " + QString::number(x) + " " + QString::number(y) + " ";
			emit sendInfo(this, sdata);
			break;
		case 1010:
			 sdata += "1011 " + aux[1] + " " + aux[2] + " " + aux[3] + " " + aux[4] + " " + aux[5] + " " + QString::number(id) + " ";
			emit sendInfo(this, sdata);
			break;
		default:
			qDebug() << "\e[31mred" <<"[Unknown:" << aux[0] << "]" << data << "\e[0m";
		}
}

int Client::send(QByteArray data)
{
	return socket->write(data);
}


void Client::closed()
{
	qDebug() << "\e[31m" << "Client " << id << " disconnected!" << "\e[0m";
	QByteArray sdata = "";
	sdata += "1002 " + QString::number(id) + " ";
	emit sendInfo(this, sdata);
}
