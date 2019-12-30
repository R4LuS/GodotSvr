#ifndef WORLD_H
#define WORLD_H

#include <QObject>
#include <QTimer>
#include <box2d/box2d.h>

#include <client.h>
#include <gLogging.h>

class MContactListener;

class World : public QObject
{
    Q_OBJECT
    public:
        World();
        b2Body *add_body(b2Vec2, b2Vec2);

        void delete_body(b2Body *);

    public slots:
        void update();

    private:
        b2World *mworld;
        QTimer *timer;
        MContactListener *mlistener;
};

class MContactListener : public b2ContactListener
{
    public:
        MContactListener();
        void BeginContact(b2Contact* contact) {
            gLogging::warning("Contact Begin");
        }
};

#endif