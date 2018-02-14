#import "Options.h"
#import "Retronator.Xni.Framework.Content.h"

#import "Retronator.GreedyMiner.h"

@implementation Options

- (void) initialize {
    [super initialize];
    
    float sizeX = (float)self.game.gameWindow.clientBounds.width/2;
    
    Texture2D *tableTexture = [[self.game.content load:@"menubg"] autorelease];
    table = [[Image alloc] initWithTexture:tableTexture position:[Vector2 vectorWithX:0 y:0]];
    [table setScaleUniform: 0.5];
    [scene addItem:table];
    
    // Text
    title = [[Label alloc] initWithFont:mainfont text:@"Nastavitve" position:[Vector2 vectorWithX:sizeX/2.0 y:10]];
    title.horizontalAlign = HorizontalAlignCenter;
    [scene addItem:title];
    
    glasba = [[Label alloc] initWithFont:mainfont text:@"Glasba:" position:[Vector2 vectorWithX:sizeX/2.0 y:110]];
    glasba.horizontalAlign = HorizontalAlignCenter;
    glasba.scale = [Vector2 vectorWithX:0.7 y:0.7];
    [scene addItem:glasba];
    [self narisi];
    
    [scene addItem:back];
}

- (void) updateWithGameTime:(GameTime *)gameTime {
    [super updateWithGameTime:gameTime];
    if (on.wasReleased) {
        Song *song = greedyMiner.song;
        [greedyMiner.player playSong:song];
         greedyMiner.player.volume = 0.3;
        [greedyMiner.progress setMusic:YES];
        [scene removeItem:on];
        [scene removeItem:off];
        [self narisi];
    } else if (off.wasReleased) {
        [greedyMiner.player stop];
        [greedyMiner.progress setMusic:NO];
        [scene removeItem:on];
        [scene removeItem:off];
        [self narisi];
    }
    
}
- (void) dealloc
{
    [title release];
    [super dealloc];
}

- (void) narisi{
    float sizeX = (float)self.game.gameWindow.clientBounds.width/2;
    
    on = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:sizeX/2-62 y:140 width:42 height:32]background:buttonBackground font:mainfont text:@"ON"];
    [on.backgroundImage setScale:[Vector2 vectorWithX:0.5 y:2]];
    on.label.horizontalAlign=HorizontalAlignCenter;
    
    if(greedyMiner.progress.isMusic){
        on.backgroundColor = [Color dimGray];
        on.label.color = [Color dimGray];
        on.enabled = NO;
    }
    
    
    [scene addItem:on];
    
    off = [[Button alloc] initWithInputArea:[Rectangle rectangleWithX:sizeX/2 y:140 width:42 height:32]background:buttonBackground font:mainfont text:@"OFF"];
    [off.backgroundImage setScale:[Vector2 vectorWithX:0.5 y:2]];
    off.label.horizontalAlign=HorizontalAlignCenter;
    
    if(!greedyMiner.progress.isMusic){
        off.backgroundColor = [Color dimGray];
        off.label.color = [Color dimGray];
        off.enabled = NO;
    }
    [scene addItem:off];
    
}

@end