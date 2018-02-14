#import "Express.Scene.Objects.h"
#import "Retronator.GreedyMiner.classes.h"

@interface Bomb : NSObject <IAARectangleCollider, ICustomCollider> {
    Vector2 *position;
    float width;
    float height;
    
}

@property (nonatomic) BOOL destroyed;

@end
