#import "Express.Scene.Objects.h"
#import "Retronator.GreedyMiner.classes.h"

@interface Miner : NSObject <IMovable, IMass, IAARectangleCollider, ICustomCollider,  ILifetime> {
    Vector2 *position;
    Vector2 *velocity;
    Lifetime *lifetime;
    float width;
    float height;
    float mass;
    BOOL destroyed;
    BOOL minning;
    BOOL cantmove;
}
@property (nonatomic) BOOL destroyed;
@property (nonatomic) BOOL minning;
@property (nonatomic) BOOL cantmove;

- (id) initWithGameTime:(GameTime*)gameTime;
@end
