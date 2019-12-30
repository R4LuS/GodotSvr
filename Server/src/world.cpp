
#include <world.h>

#define TPASSED 1.0f/60.0f

World::World() : QObject()
{
    mworld = new b2World(b2Vec2(0.0f,0.0f));
    mlistener = new MContactListener();
    mworld->SetContactListener(mlistener);
    timer = new QTimer();
    connect(timer, SIGNAL(timeout()), this, SLOT(update()));
    timer->start(TPASSED);
}

b2Body *World::add_body(b2Vec2 pos, b2Vec2 size)
{
    b2BodyDef bodyDef;
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(pos.x, pos.y);
    b2Body *groundBody = mworld->CreateBody(&bodyDef);
    b2PolygonShape groundBox;
    groundBox.SetAsBox(size.x, size.y);
    groundBody->CreateFixture(&groundBox, 0.0f);
    gLogging::warning("Body created and added to world!");
    return groundBody;
}


void World::delete_body(b2Body *body)
{
    //mworld->DeleteBody(body);
}


void World::update()
{
    mworld->Step(TPASSED, 5, 5);
    for (b2Contact* c = mworld->GetContactList(); c; c = c->GetNext())
    {
        gLogging::warning("Something in contact");
    }
}


MContactListener::MContactListener()
{
    
}