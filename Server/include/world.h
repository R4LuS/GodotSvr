#ifndef WORLD_H
#define WORLD_H

#include <QObject>
#include <box2d/box2d.h>    


class World : public QObject
{
    Q_OBJECT
    public:
        World();
        void add_body();

    private:
        b2World *mworld;
};


#endif