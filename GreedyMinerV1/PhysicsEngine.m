#import "Express.Physics.h"
#import "Retronator.GreedyMiner.h"
#import "PhysicsEngine.h"

@implementation PhysicsEngine

- (id) initWithGame:(Game *)theGame level:(Level *)theLevel {
    if (self = [super initWithGame:theGame]) {
        level = theLevel;
    }
    return self;
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    [MovementPhysics simulateMovementOn:level.fball withElapsed:gameTime.elapsedGameTime];
    [level.fball goTo: level.miner.position];
    
    for (id item1 in level.scene) {
        if ([item1 isKindOfClass:[Miner class]] || [item1 isKindOfClass:[Bomb class]]  || [item1 isKindOfClass:[FBall class]]) {
            for (id item2 in level.scene) {
                if (item1 != item2) {
                    [Collision collisionBetween:item1 and:item2];
                }
            }
        }
    }
}

@end
