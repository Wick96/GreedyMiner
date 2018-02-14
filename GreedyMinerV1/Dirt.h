#import "Express.Scene.Objects.h"

#import "Retronator.GreedyMiner.classes.h"

@interface Dirt : NSObject <IAARectangleCollider, ICustomCollider> {
    Vector2 *position;
    float width;
    float height;
    
    BOOL destroyed;
}

@property (nonatomic) BOOL destroyed;

@end
