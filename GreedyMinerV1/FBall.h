#import "Express.Scene.Objects.h"
#import "Retronator.GreedyMiner.classes.h"

@interface FBall : NSObject <IParticleCollider, ICustomCollider, ICustomUpdate, IMovable>  {
    Vector2 *position;
    Vector2 *velocity;
    float radius;
    float mass;
    Vector2 *target;
}

@property (nonatomic, readonly) Vector2 *target;

- (void) goTo:(Vector2*)theTarget;
- (void) updateWithGameTime:(GameTime*)gameTime;

@end
