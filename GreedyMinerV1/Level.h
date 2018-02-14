#import "Retronator.GreedyMiner.classes.h"
#import "Express.Scene.h"

@interface Level : GameComponent {
    SimpleScene *scene;

    Miner *miner;
    FBall *fball;
    
    Vector2 *minerSpawn;
    Vector2 *fballSpawn;
    
    int dirtCount;
    int goldCount;
    int diamondCount;
    int treasureCount;
    int lives;
    int bombs;
    
    SpriteFont *mainfont;
    Texture2D *buttonBackground;
    
    Button *explosion;
    


}

@property (nonatomic, readonly) id<IScene> scene;
@property (nonatomic, readonly) Miner *miner;
@property (nonatomic, readonly) FBall *fball;
@property (nonatomic, readonly) int dirtCount;
@property (nonatomic, readonly) int goldCount;
@property (nonatomic, readonly) int diamondCount;
@property (nonatomic, readonly) int treasureCount;
@property (nonatomic) int lives;

- (void) resetLevel;
+ (NSString*) name;
+ (LevelType) levelType;
+ (NSString*) portraitPath;
+ (NSString*) hiddenPortraitPath;
+ (NSString*) fullPortraitPath;

@end
