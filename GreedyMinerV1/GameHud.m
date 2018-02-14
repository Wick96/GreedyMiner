#import "GameHud.h"

#import "Retronator.Xni.Framework.Graphics.h"
#import "Retronator.Xni.Framework.Content.Pipeline.Processors.h"

@implementation GameHud

- (id) initWithGame:(Game *)theGame
{
    self = [super initWithGame:theGame];
    if (self != nil) {
        scene = [[SimpleScene alloc] initWithGame:self.game];
        [self.game.components addComponent:scene];
    }
    return self;
}

@synthesize scene;

- (void) initialize {
    FontTextureProcessor *fontProcessor = [[[FontTextureProcessor alloc] init] autorelease];
    SpriteFont *font = [[self.game.content load:@"font" processor:fontProcessor] autorelease];
    
    playerScore = [[Label alloc] initWithFont:font text:@"0" position:[Vector2 vectorWithX:10 y:0]];
    
        playerColor = [[Color white] retain];
        playerScore.color = playerColor;
        playerScore.horizontalAlign = HorizontalAlignLeft;
        playerScore.verticalAlign = VerticalAlignTop;
        playerScore.layerDepth= 0.5;
        [scene addItem:playerScore];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    float sizeChange = gameTime.elapsedGameTime * 2;
    
    
    if (playerScore.scale.x > 0.6) {
        playerScore.scale.x -= sizeChange;
        playerScore.scale.y -= sizeChange;
    }
    
}

- (void) changePlayerScoreFor:(int)value {
    
    playerScore.text = [NSString stringWithFormat:@"%i", value];

    [playerScore setScaleUniform:1];
    
    
}

- (void) dealloc
{
    [playerScore release];
    [super dealloc];
}


@end
