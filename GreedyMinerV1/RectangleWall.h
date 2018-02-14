#import "Express.Scene.Objects.h"

@interface RectangleWall : NSObject <IAARectangleCollider> {
    Vector2 *position;
    float width;
    float height;
    BOOL fly;
}

@property (nonatomic) BOOL fly;
@end
