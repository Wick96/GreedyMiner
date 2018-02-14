@interface PhysicsEngine : GameComponent {
    // Level
    Level *level;
}

- (id) initWithGame:(Game*)theGame level:(Level*)theLevel;

@end