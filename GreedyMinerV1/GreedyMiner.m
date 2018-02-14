#import "GreedyMiner.h"

#import "Retronator.GreedyMiner.h"
#import "Artificial.Control.h"
#import "Retronator.Xni.Framework.Media.h"

@implementation GreedyMiner

- (id) init {
    if (self = [super init]) {
        graphics = [[GraphicsDeviceManager alloc] initWithGame:self];
        
        //self.isFixedTimeStep = NO;
        
        [self.components addComponent:[[[FpsComponent alloc] initWithGame:self] autorelease]];
        [self.components addComponent:[[[TouchPanelHelper alloc] initWithGame:self] autorelease]];
        
        stateStack = [[NSMutableArray alloc] init];
        
        [SoundEngine initializeWithGame:self];
        
        
        progress = [[GameProgress loadProgress] retain];
        
        song = [self.content load:@"intro-song"];
        [MediaPlayer playSong:song];
        player = [MediaPlayer getInstance];
        if(progress.isMusic){
            player.volume = 0.3;
        }
        else{
            player.volume = 0.0;
        }
    }
    return self;
}

@synthesize progress, player, song;

- (void) initialize {
    levelClasses[LevelTypeStart] = [StartLevel class];
    levelClasses[LevelTypeLava] = [LavaLevel class];
    levelClasses[LevelTypeGold] = [GoldLevel class];
    levelClasses[LevelTypeDiamond] = [DiamondLevel class];
    levelClasses[LevelTypeTreasure] = [TreasureLevel class];
    
    // Start in main menu.
    MainMenu *mainMenu = [[[MainMenu alloc] initWithGame:self] autorelease];
    [self pushState:mainMenu];
    
    // Initialize all components.
    [super initialize];
}

- (void) pushState:(GameState *)gameState {
    GameState *currentActiveState = [stateStack lastObject];
    [currentActiveState deactivate];
    [self.components removeComponent:currentActiveState];
    
    [stateStack addObject:gameState];
    [self.components addComponent:gameState];
    [gameState activate];
}

- (void) popState {
    GameState *currentActiveState = [stateStack lastObject];
    [stateStack removeLastObject];
    [currentActiveState deactivate];
    [self.components removeComponent:currentActiveState];
    
    currentActiveState = [stateStack lastObject];
    [self.components addComponent:currentActiveState];
    [currentActiveState activate];
}

- (Class) getLevelClass:(LevelType)type {
    return levelClasses[type];
}


- (void) updateWithGameTime:(GameTime *)gameTime {
    [super updateWithGameTime:gameTime];
}

- (void) drawWithGameTime:(GameTime *)gameTime {
    [self.graphicsDevice clearWithColor:[Color black]];
    [super drawWithGameTime:gameTime];
}

- (void) dealloc
{
    [stateStack release];
    [progress release];
    [graphics release];
    [super dealloc];
}

@end
