#import "RectangleWall.h"


@implementation RectangleWall

- (id) init
{
    self = [super init];
    if (self != nil) {
        position = [[Vector2 alloc] init];
        fly = NO;
    }
    return self;
}

@synthesize position, width, height, fly;

- (void) dealloc
{
    [position release];
    [super dealloc];
}


@end
