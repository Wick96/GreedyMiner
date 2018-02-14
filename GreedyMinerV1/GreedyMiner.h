#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Audio.h"
#import "Retronator.Xni.Framework.Media.h"
#import "Retronator.GreedyMiner.classes.h"

@interface GreedyMiner : Game {
    GraphicsDeviceManager *graphics;
    
    // Progress
    GameProgress *progress;
    
    // Game state
    NSMutableArray *stateStack;
    
    // Levels
    Class levelClasses[LevelTypes];
    
    // Opponents
    
    MediaPlayer *player;
    Song *song;
}

@property (nonatomic, readonly) GameProgress *progress;
@property (nonatomic, readonly) Song *song;
@property (nonatomic, retain) MediaPlayer *player;

- (void) pushState:(GameState*)gameState;
- (void) popState;

- (Class) getLevelClass:(LevelType)type;

@end
