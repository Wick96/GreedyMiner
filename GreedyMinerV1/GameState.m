#import "GameState.h"


@implementation GameState

- (id) initWithGame:(Game *)theGame
{
    self = [super initWithGame:theGame];
    if (self != nil) {
       greedyMiner = (GreedyMiner*)self.game;
    }
    return self;
}

- (void) activate {}
- (void) deactivate {}

@end
