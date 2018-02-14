#import "HumanPlayer.h"

#import "Retronator.Xni.Framework.Input.Touch.h"
#import "Artificial.Control.h"
#import "Retronator.GreedyMiner.h"

@implementation HumanPlayer

- (id) initWithGame:(Game *)theGame miner:(Miner *)theMiner
{
    self = [super initWithGame:theGame miner:theMiner];
    if (self != nil) {

        inputArea = [[Rectangle alloc] initWithX:0 y:0 width:self.game.gameWindow.clientBounds.width height:self.game.gameWindow.clientBounds.height];
        touchOffset = [[Vector2 alloc] initWithX:0 y:0];
    }
    return self;
}

- (void) setCamera:(Matrix *)camera {
    [inverseView release];
    inverseView = [[Matrix invert:camera] retain];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    TouchCollection *touches = [TouchPanelHelper getState];
    
    BOOL touchesInInputArea = NO;
    for (TouchLocation *touch in touches) {
        Vector2* touchInScene = [Vector2 transform:touch.position with:inverseView];
        
        if ([inputArea containsVector:touchInScene]) {
            touchesInInputArea = YES;
            
            if ((!grabbed && touch.state == TouchLocationStatePressed) || grabbing) {
                grabbing = YES;
                
                float distanceToMiner = [[[Vector2 subtract:touchInScene by:miner.position] add:touchOffset] length];
                if (distanceToMiner < 45) {
                    grabbed = YES;
                }
            }
            
            if (grabbed) {
                if(miner.cantmove){
                    grabbed=NO;
                    miner.cantmove=NO;
                }
                else{
                    [[miner.position set:touchInScene] add:touchOffset];
                }
                
                
            }
        }
    }
    
    if (!touchesInInputArea) {
        grabbed = NO;
    }
}

- (void) reset {
    grabbed = NO;
    grabbing = NO;
}

- (void) resetPlayer{
    [self reset];
}

- (void) dealloc
{
    [inputArea release];
    [super dealloc];
}


@end

