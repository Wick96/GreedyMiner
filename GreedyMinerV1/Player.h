#import "Express.Scene.h"

#import "Retronator.GreedyMiner.classes.h"

@interface Player : GameComponent {
    Miner *miner;
}

- (id) initWithGame:(Game *)theGame miner:(Miner*)theMiner;

- (void) reset;

@end
