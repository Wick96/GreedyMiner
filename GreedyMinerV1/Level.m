#import "Level.h"

#import "Retronator.GreedyMiner.h"

#import "Retronator.Xni.Framework.Content.h"

#import "Retronator.Xni.Framework.Content.Pipeline.Processors.h"

@interface Level ()

- (void) reset;

@end


@implementation Level

- (id) initWithGame:(Game *)theGame
{
    self = [super initWithGame:theGame];
    if (self != nil) {
        scene = [[SimpleScene alloc] initWithGame:self.game];
        
        miner = [[Miner alloc] init];
        fball = [[FBall alloc] init];
        
        [scene addItem:miner];
        [scene addItem:fball];
        
        minerSpawn = [[Vector2 alloc] init];
        fballSpawn = [[Vector2 alloc] init];
        
        FontTextureProcessor *fontProcessor = [[[FontTextureProcessor alloc] init] autorelease ];

        mainfont = [self.game.content load:@"font" processor:fontProcessor];
        buttonBackground = [self.game.content load:@"bomb"];
        
        explosion = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:self.game.gameWindow.clientBounds.width/2-16 y:5 width:40 height:64]
                                           background:buttonBackground font:mainfont text:@"2x"];
        [explosion.backgroundImage setScaleUniform:0.6];
        explosion.label.layerDepth= 0.5;
        explosion.labelColor= [Color white];
        explosion.label.position.x= explosion.backgroundImage.position.x-20;
        explosion.backgroundImage.layerDepth=0.5;
        
        [scene addItem:explosion];
        bombs=2;
        
        

    }
    return self;
}

@synthesize scene, miner, fball, dirtCount, goldCount, diamondCount, treasureCount, lives;

+ (NSString*) name {return nil;}
+ (LevelType) levelType  {return 0;}
+ (NSString*) portraitPath {return nil;}
+ (NSString*) hiddenPortraitPath {return nil;}
+ (NSString*) fullPortraitPath {return nil;}

- (void) initialize {
    [super initialize];
    
    [self.game.components addComponent:scene];
}

- (void) resetLevel {
    [self reset];
}

- (void) reset {
    [miner.position set:minerSpawn];
    [fball.position set:fballSpawn];    
    fball.velocity.x = 0;
    fball.velocity.y = 0;
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    
    if (explosion.wasReleased) {
        Bomb *bomb = [[[Bomb alloc] init] autorelease];
        bomb.position.x = miner.position.x;
        bomb.position.y = miner.position.y;
        [SoundEngine play:SoundEffectTypeExp];
        [scene addItem:bomb];
        bombs--;
        explosion.label.text=[NSString stringWithFormat:@"%dx",bombs];
        if(bombs==0){
            [scene removeItem:explosion];
        }
    }
    

    NSMutableArray *removeDirt = [[NSMutableArray alloc] init];
    NSMutableArray *removeGold = [[NSMutableArray alloc] init];
    NSMutableArray *removeDiamond = [[NSMutableArray alloc] init];
    NSMutableArray *removeTreasure = [[NSMutableArray alloc] init];
    NSMutableArray *removeStone = [[NSMutableArray alloc] init];
    NSMutableArray *removeLava = [[NSMutableArray alloc] init];
    
    // Update all items with custom update.
    for (id item in scene) {
        Dirt *dirt = [item isKindOfClass:[Dirt class]] ? item : nil;
        if (dirt && dirt.destroyed) {
            [removeDirt addObject:dirt];
        }
        
        Gold *gold = [item isKindOfClass:[Gold class]] ? item : nil;
        if (gold && gold.destroyed) {
            [removeGold addObject:gold];
        }
        
        Diamond *diamond = [item isKindOfClass:[Diamond class]] ? item : nil;
        if (diamond && diamond.destroyed) {
            [removeDiamond addObject:diamond];
        }
        
        Treasure *treasure = [item isKindOfClass:[Treasure class]] ? item : nil;
        if (treasure && treasure.destroyed) {
            [removeTreasure addObject:treasure];
        }
        
        Lava *lava = [item isKindOfClass:[Lava class]] ? item : nil;
        if (lava && lava.destroyed) {
            [removeLava addObject:lava];
        }
        
        Stone *stone = [item isKindOfClass:[Stone class]] ? item : nil;
        if (stone && stone.destroyed) {
            [removeStone addObject:stone];
        }
        
        Button *button = [item isKindOfClass:[Button class]] ? item : nil;
        
        if (button) {
            Matrix *inverseView = [Matrix invert:[[Matrix createScale:[Vector3 vectorWithX:1 y:1 z:1]] retain]];
            [button updateWithInverseView:inverseView];
        }
        
        id<ICustomUpdate> updatable = [item conformsToProtocol:@protocol(ICustomUpdate)] ? item : nil;
        
        if (updatable) {
            [updatable updateWithGameTime:gameTime];
        }
    }
    
    
    for (Dirt *item in removeDirt) {
        [scene removeItem:item];
        dirtCount--;
    }
    for (Gold *item in removeGold) {
        [scene removeItem:item];
        goldCount--;
    }
    for (Diamond *item in removeDiamond) {
        [scene removeItem:item];
        diamondCount--;
    }
    for (Treasure *item in removeTreasure) {
        [scene removeItem:item];
        treasureCount--;
    }
    for (Lava *item in removeLava) {
        [scene removeItem:item];
    }
    for (Stone *item in removeStone) {
        [scene removeItem:item];
    }
    [removeDirt release];
    [removeGold release];
    [removeDiamond release];
    [removeTreasure release];
    [removeLava release];
    [removeStone release];

}

- (void) dealloc
{
    [self.game.components removeComponent:scene];
    [miner release];
    [fball release];
    [minerSpawn release];
    [fballSpawn release];
    [scene release];
    [super dealloc];
}


@end

