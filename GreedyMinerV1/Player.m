#import "Player.h"


@implementation Player

- (id) initWithGame:(Game *)theGame miner:(Miner *)theMiner
{
    self = [super initWithGame:theGame];
    if (self != nil) {
        miner = theMiner;
    }
    return self;
}

- (void) reset {}

@end
