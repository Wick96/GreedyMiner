#import "Menu.h"

#import "Retronator.Xni.Framework.Content.h"

#import "Retronator.Xni.Framework.Content.Pipeline.Processors.h"

#import "Retronator.GreedyMiner.h"

@implementation Menu

- (id) initWithGame:(Game *)theGame
{
    self = [super initWithGame:theGame];
    if (self != nil) {
        scene = [[SimpleScene alloc] initWithGame:self.game];
        renderer = [[GuiRenderer alloc] initWithGame:self.game scene:scene];
    }
    return self;
}

- (void) activate {
    [self.game.components addComponent:scene];
    [self.game.components addComponent:renderer];
}

- (void) deactivate {
    [self.game.components removeComponent:scene];
    [self.game.components removeComponent:renderer];
}

- (void) initialize {
    float sizeX = (float)self.game.gameWindow.clientBounds.width/2;
    float sizeY = (float)self.game.gameWindow.clientBounds.height/2;

    FontTextureProcessor *fontProcessor = [[[FontTextureProcessor alloc] init] autorelease ];
    mainfont = [self.game.content load:@"font" processor:fontProcessor];

    buttonBackground = [self.game.content load:@"Button"];
    
    back = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:sizeX-120 y:sizeY-28 width:70 height:32]
                                          background:buttonBackground font:mainfont text:@"Nazaj"];
    [back.backgroundImage setScaleUniform:2];
    
    [super initialize];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    // Update all buttons.
    Matrix *inverseView = [Matrix invert:renderer.camera];
    for (id item in scene) {
        Button *button = [item isKindOfClass:[Button class]] ? item : nil;
        
        if (button) {
            [button updateWithInverseView:inverseView];
        }
    }
    
    if (back.wasReleased) {
        [greedyMiner popState];
    }
}

- (void) dealloc
{
    [back release];
    [buttonBackground release];
    [scene release];
    [renderer release];	 
    [super dealloc];
}

@end