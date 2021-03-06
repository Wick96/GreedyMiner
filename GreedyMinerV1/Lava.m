#import "Lava.h"

#import "Retronator.GreedyMiner.h"

@implementation Lava

- (id) init
{
    self = [super init];
    if (self != nil) {
        position = [[Vector2 alloc] init];
        width = 64;
        height = 64;
    }
    return self;
}

@synthesize destroyed, position, width, height;

- (BOOL) collidingWithItem:(id)item {
    return YES;
}

- (void) collidedWithItem:(id)item {
    
}

- (void) dealloc
{
    [position release];
    [super dealloc];
}

@end
