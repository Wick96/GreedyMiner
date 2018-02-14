#import "Retronator.GreedyMiner.classes.h"

@interface GameState : GameComponent {
    GreedyMiner *greedyMiner;
}

- (void) activate;
- (void) deactivate;

@end
