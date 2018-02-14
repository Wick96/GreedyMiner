#import "Bomb.h"

#import "Retronator.GreedyMiner.h"

@implementation Bomb

- (id) init
{
    self = [super init];
    if (self != nil) {
        position = [[Vector2 alloc] init];
        width = 130;
        height = 130;
    }
    return self;
}

@synthesize destroyed, position, width, height;

- (BOOL) collidingWithItem:(id)item {
    if([item isKindOfClass:[Miner class]]){
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
    else if([item isKindOfClass:[Lava class]]){
        Lava *lava = (Lava*)item;
        lava.destroyed=YES;
    }
    else if([item isKindOfClass:[Stone class]]){
        Stone *stone = (Stone*)item;
        stone.destroyed=YES;
    }
    
    
    
}

- (void) dealloc
{
    [position release];
    [super dealloc];
}

@end
