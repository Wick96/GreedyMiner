//
//  LevelSelection.m
//  GreedyMinerV1
//
//  Created by Tone Novak on 06/01/18.
//  Copyright © 2018 Tone Novak. All rights reserved.
//

#import "LevelSelection.h"

#import "Retronator.Xni.Framework.Content.h"

#import "Artificial.Mirage.h"

#import "Retronator.GreedyMiner.h"

@implementation LevelSelection

- (void) initialize {
    [super initialize];
    float sizeX = (float)self.game.gameWindow.clientBounds.width/2;
    
    Texture2D *tableTexture = [[self.game.content load:@"menubg"] autorelease];
    table = [[Image alloc] initWithTexture:tableTexture position:[Vector2 vectorWithX:0 y:0]];
    [table setScaleUniform: 0.5];
    [scene addItem:table];
    
    // Text
    title = [[Label alloc] initWithFont:mainfont text:@"Izberi level:" position:[Vector2 vectorWithX:sizeX/2.0 y:10]];
    title.horizontalAlign = HorizontalAlignCenter;
    [scene addItem:title];

    
    // Buttons
    
    for (int i = 0; i < LevelTypes; i++) {
        levelButton[i] = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:20 y:60+i*50 width:200 height:50]
                                                   background:nil font:mainfont text:@"test"];
        levelButton[i].backgroundHoverColor = [Color white];
        levelButton[i].labelHoverColor = [Color gray];
        levelButton[i].label.position.x = 90;
        [scene addItem:levelButton[i]];
    }
    
    [scene addItem:back];
}

- (void) activate {
    [super activate];
    
    // Update the list on activate.
    
    for (int i = 0; i < LevelTypes; i++) {
        Class levelClass = [greedyMiner getLevelClass:i];
        
        NSString *portraitPath;
        if ([greedyMiner.progress isLevelUnlocked:i]) {
            portraitPath = [levelClass portraitPath];
            levelButton[i].label.text = [levelClass name];
            levelButton[i].labelColor = [Color white];
            levelButton[i].enabled = YES;
        } else {
            portraitPath = [levelClass hiddenPortraitPath];
            levelButton[i].label.text = @"???";
            levelButton[i].labelColor = [Color dimGray];
            levelButton[i].enabled = NO;
        }
        
        Texture2D *portrait = [self.game.content load:portraitPath];
        levelButton[i].backgroundImage.texture = portrait;
        levelButton[i].label.horizontalAlign = HorizontalAlignLeft;
        levelButton[i].backgroundImage.scale = [Vector2 vectorWithX:0.70 y:0.70];
    }
    
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    [super updateWithGameTime:gameTime];
    for (int i = 0; i < LevelTypes; i++) {
        if (levelButton[i].wasReleased) {
            
            Class levelClass = [greedyMiner getLevelClass:i];
            Gameplay *gameplay = [[[Gameplay alloc] initSinglePlayerWithGame:self.game
                                                                  levelClass:levelClass] autorelease];
            [greedyMiner pushState:gameplay];
        }
    }
}

- (void) dealloc
{
    [title release];
    
    for (int i = 0; i < LevelTypes; i++) {
        [levelButton[i] release];
    }
    
    [super dealloc];
}


@end