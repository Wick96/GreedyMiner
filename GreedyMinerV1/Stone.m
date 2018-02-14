#import "Stone.h"

#import "Retronator.GreedyMiner.h"

@implementation Stone

- (id) init
{
    self = [super init];
    if (self != nil) {
        position = [[Vector2 alloc] init];
        width = 80;
        height = 80;
    }
    return self;
}

@synthesize position, width, height, destroyed;

- (BOOL) collidingWithItem:(id)item {
    return YES;
}

- (void) collidedWithItem:(id)item {
    if([item isKindOfClass:[Miner class]]){
        Miner *miner = (Miner*)item;
        int x = miner.position.x-self.position.x;
        int y = miner.position.y-self.position.y;
        miner.position.x=self.position.x+x;
        miner.position.y=self.position.y+y;
    }
    
}

- (void) dealloc
{
    [position release];
    [super dealloc];
}

@end