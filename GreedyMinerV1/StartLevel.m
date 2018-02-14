#import "StartLevel.h"

#import "Retronator.GreedyMiner.h"

@implementation StartLevel

- (id) initWithGame:(Game *)theGame
{
    self = [super initWithGame:theGame];
    if (self != nil) {
        
        minerSpawn.x = 500;
        minerSpawn.y = 100;
        
        fballSpawn.x = 0;
        fballSpawn.y = 0;
        

        RectangleWall *wall;
        
        wall = [[[RectangleWall alloc] init] autorelease];
        wall.position.x = -5;
        wall.position.y = 250;
        wall.width = self.game.gameWindow.clientBounds.width*2;
        wall.height = 1;
        wall.fly = YES;
        [scene addItem:wall];
        
        wall = [[[RectangleWall alloc] init] autorelease];
        wall.position.x = -5;
        wall.position.y = 200;
        wall.width = self.game.gameWindow.clientBounds.width*2;
        wall.height = 1;
        [scene addItem:wall];
        
        dirtCount = 0;
        goldCount = 0;
        diamondCount = 0;
        treasureCount = 0;
        for (int i = (float)self.game.gameWindow.clientBounds.height-32; i>=256; i=i-64) {
            for (int x = 24 ; x <= (float)self.game.gameWindow.clientBounds.width; x+=64) {
                int rand = arc4random_uniform(99);
                if(rand<5){
                    Stone *stone = [[[Stone alloc] init ] autorelease];
                    stone.position.x = x;
                    stone.position.y = i;
                    [scene addItem:stone];
                }
                else{
                    Dirt *dirt = [[[Dirt alloc] init] autorelease];
                    dirt.position.x = x;
                    dirt.position.y = i;
                    [scene addItem:dirt];
                    dirtCount++;
                }
                
            }
        }
        

    }
    return self;
}

+ (NSString*) name {return @"Navadni rudnik";}
+ (LevelType) levelType  {return LevelTypeLava;}
+ (NSString*) portraitPath {return @"rsz_mine1";}
+ (NSString*) hiddenPortraitPath {return @"rsz_mine0";}
+ (NSString*) fullPortraitPath {return @"mine1";}

@end
