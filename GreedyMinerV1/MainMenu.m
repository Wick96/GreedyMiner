#import "MainMenu.h"

#import "Retronator.Xni.Framework.Content.h"

#import "Retronator.GreedyMiner.h"

@implementation MainMenu

- (void) initialize {
    [super initialize];
    
    float sizeX = (float)self.game.gameWindow.clientBounds.width/2;
    float sizeY = (float)self.game.gameWindow.clientBounds.height/2;
    
    // Background
    Texture2D *tableTexture = [[self.game.content load:@"menubg"] autorelease];
    table = [[Image alloc] initWithTexture:tableTexture position:[Vector2 vectorWithX:0 y:0]];
    [table setScaleUniform: 0.5];
    [scene addItem:table];

    title = [[Label alloc] initWithFont:mainfont text:@"Greedy Miner" position:[Vector2 vectorWithX:sizeX/2.0 y:10]];
    title.horizontalAlign = HorizontalAlignCenter;
    
    [scene addItem:title];
    
    subtitle = [[Label alloc] initWithFont:mainfont text:@"by Luka" position:[Vector2 vectorWithX:sizeX-100 y:50]];
    subtitle.horizontalAlign = HorizontalAlignRight;
    subtitle.scale = [Vector2 vectorWithX:0.5 y:0.5 ];
    [scene addItem:subtitle];
    
    copyright = [[Label alloc] initWithFont:mainfont text:@""
                 "Code template by TINR Fri, edited by Luka \n"
                 "Copyright 2018 Luka, all Rights Reserved v0.1" position:[Vector2 vectorWithX:sizeX/2 y:sizeY-20]];
    copyright.scale = [Vector2 vectorWithX:0.2 y:0.2 ];
    copyright.horizontalAlign = HorizontalAlignCenter;
    [scene addItem:copyright];
    
    // Buttons
    singleplayer = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:sizeX/2-130 y:150 width:140 height:32]
                                          background:buttonBackground font:mainfont text:@"Igraj"];
    [singleplayer.backgroundImage setScaleUniform:2];
    [scene addItem:singleplayer];
    
    options = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:sizeX/2-130 y:200 width:140 height:32]
                                     background:buttonBackground font:mainfont text:@"Nastavitve"];
    [options.backgroundImage setScaleUniform:2];
    [scene addItem:options];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    [super updateWithGameTime:gameTime];
    
    GameState *newState = nil;
    
    if (singleplayer.wasReleased) {
        newState = [[[LevelSelection alloc] initWithGame:self.game] autorelease];
    } else if (options.wasReleased) {
        newState = [[[Options alloc] initWithGame:self.game] autorelease];
    }
    
    if (newState) {
        [greedyMiner pushState:newState];
    }
}

- (void) dealloc
{
    [table release];
    
    [title release];
    [subtitle release];
    [copyright release];
    
    [singleplayer release];
    [options release];
    
    [super dealloc];
}


@end
