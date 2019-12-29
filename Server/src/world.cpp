
#include <world.h>


World::World() : QObject()
{
    mworld = new b2World(b2Vec2(0.0f,0.0f));
}

void World::add_body()
{

}