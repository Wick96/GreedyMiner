#import "FBall.h"

#import "Retronator.GreedyMiner.h"

@implementation FBall

- (id) init
{
    self = [super init];
    if (self != nil) {
        position = [[Vector2 alloc] init];
        velocity = [[Vector2 alloc] init];
        mass = 20;
        radius = 20;
    }
    return self;
}

@synthesize position, velocity, radius, target;

- (void) goTo:(Vector2 *)theTarget {
    [theTarget retain];
    [target release];
    target = theTarget;
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    // Avoid division by zero.
    if (target) {
        [velocity set:[Vector2 subtract:target by:position]];
        float length = [velocity length];
        if (length > 0.01f) {
            [velocity normalize];
            [velocity multiplyBy:100];
        } else {
            [velocity set:[Vector2 zero]];
            [target release];
            target = nil;
        }
    }
    
}
- (BOOL) collidingWithItem:(id)item {
    if([item isKindOfClass:[Lava class]]){
        return NO;
    }
    else if([item isKindOfClass:[Bomb class]]){
        return NO;
    }
    else if([item isKindOfClass:[RectangleWall class]]){
        return NO;
    }
    return YES;
}

- (void) collidedWithItem:(id)item {
    
    if([item isKindOfClass:[Dirt class]]){
        Dirt *dirt = (Dirt*)item;
        dirt.destroyed=YES;
    }
    else if([item isKindOfClass:[Gold class]]){
        Gold *gold = (Gold*)item;
        gold.destroyed=YES;
    }
    else if([item isKindOfClass:[Diamond class]]){
        Diamond *diamond = (Diamond*)item;
        diamond.destroyed=YES;
    }
    else if([item isKindOfClass:[Treasure class]]){
        Treasure *treasure = (Treasure*)item;
        treasure.destroyed=YES;
    }
    else if([item isKindOfClass:[Stone class]]){
        Stone *stone = (Stone*)item;
        stone.destroyed=YES;
    }
    
    
    
}
- (void) dealloc
{
    [velocity release];
    [position release];
    [super dealloc];
}


@end
