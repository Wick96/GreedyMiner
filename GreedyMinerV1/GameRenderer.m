#import "GameRenderer.h"
#import "Express.Scene.h"
#import "Express.Scene.Objects.h"
#import "Retronator.GreedyMiner.h"

@implementation GameRenderer

@synthesize camera;

- (id) initWithGame:(Game *)theGame level:(Level *)theLevel {
    if (self = [super initWithGame:theGame]) {
        level = theLevel;
        content = [[ContentManager alloc] initWithServiceProvider:self.game.services];
        lightPosition = [[Vector2 alloc] initWithX:160 y:230];
        camera = [[Matrix createScale:[Vector3 vectorWithX:1 y:1 z:1]] retain];
        
    }
    return self;
}



- (void) loadContent {
    spriteBatch = [[SpriteBatch alloc] initWithGraphicsDevice:self.graphicsDevice];

    background = [content load:@"background"];
    
    minerSprite = [[Sprite alloc] init];
    minerSprite.texture = [content load:@"grafika"];
    minerSprite.sourceRectangle = [Rectangle rectangleWithX:(10+0*20+0*128) y:(10+4*20+4*128) width:128 height:128];
    minerSprite.origin = [Vector2 vectorWithX:64 y:64];
    
    for (int j = 0; j < 3; j++) {
        minerSprite2[j] = [[AnimatedSprite alloc] initWithDuration:1];
        for (int i = 0; i < 16; i++) {
            Sprite *sprite = [[[Sprite alloc] init] autorelease];
            sprite.texture = [content load:@"grafika"];
            sprite.sourceRectangle = [Rectangle rectangleWithX:(10+1*20+1*128) y:(10+(4+j)*20+(4+j)*128) width:128 height:128];
            sprite.origin = [Vector2 vectorWithX:64 y:64];
            AnimatedSpriteFrame *frame = [AnimatedSpriteFrame frameWithSprite:sprite start:minerSprite2[j].duration * (float)i / 16];
            [minerSprite2[j] addFrame:frame];
        }
    }
    
    for (int j = 0; j < 4; j++) {
        minerSprite3[j] = [[AnimatedSprite alloc] initWithDuration:1];
        for (int i = 0; i < 16; i++) {
            Sprite *sprite = [[[Sprite alloc] init] autorelease];
            sprite.texture = [content load:@"grafika"];
            sprite.sourceRectangle = [Rectangle rectangleWithX:(10+0*20+0*128) y:(10+(4+j)*20+(4+j)*128) width:128 height:128];
            sprite.origin = [Vector2 vectorWithX:64 y:64];
            AnimatedSpriteFrame *frame = [AnimatedSpriteFrame frameWithSprite:sprite start:minerSprite3[j].duration * (float)i / 16];
            [minerSprite3[j] addFrame:frame];
        }
    }
    
    lifeSprite = [[Sprite alloc] init];
    lifeSprite.texture = [content load:@"grafika"];
    lifeSprite.sourceRectangle = [Rectangle rectangleWithX:(10+0*20+0*128) y:(10+4*20+4*128) width:128 height:128];
    lifeSprite.origin = [Vector2 vectorWithX:0 y:0];
    
    dirtSprite = [[Sprite alloc] init];
    dirtSprite.texture = [content load:@"grafika"];
    dirtSprite.sourceRectangle = [Rectangle rectangleWithX:(10+0*20+0*128) y:(10+0*20+0*128) width:128 height:128];
    dirtSprite.origin = [Vector2 vectorWithX:64 y:64];
    
    stoneSprite = [[Sprite alloc] init];
    stoneSprite.texture = [content load:@"grafika"];
    stoneSprite.sourceRectangle = [Rectangle rectangleWithX:(10+1*20+1*128) y:(10+0*20+0*128) width:128 height:128];
    stoneSprite.origin = [Vector2 vectorWithX:64 y:64];
    
    goldSprite = [[Sprite alloc] init];
    goldSprite.texture = [content load:@"grafika"];
    goldSprite.sourceRectangle = [Rectangle rectangleWithX:(10+3*20+3*128) y:(10+0*20+0*128) width:128 height:128];
    goldSprite.origin = [Vector2 vectorWithX:64 y:64];
    
    diamondSprite = [[Sprite alloc] init];
    diamondSprite.texture = [content load:@"grafika"];
    diamondSprite.sourceRectangle = [Rectangle rectangleWithX:(10+4*20+4*128) y:(10+0*20+0*128) width:128 height:128];
    diamondSprite.origin = [Vector2 vectorWithX:64 y:64];
    
    treasureSprite = [[Sprite alloc] init];
    treasureSprite.texture = [content load:@"grafika"];
    treasureSprite.sourceRectangle = [Rectangle rectangleWithX:(10+2*20+2*128) y:(10+3*20+3*128) width:128 height:128];
    treasureSprite.origin = [Vector2 vectorWithX:64 y:64];
    
    lavaSprite = [[Sprite alloc] init];
    lavaSprite.texture = [content load:@"grafika"];
    lavaSprite.sourceRectangle = [Rectangle rectangleWithX:(10+2*20+2*128) y:(10+0*20+0*128) width:128 height:128];
    lavaSprite.origin = [Vector2 vectorWithX:64 y:64];
    
    fireballSprite = [[Sprite alloc] init];
    fireballSprite .texture = [content load:@"fireball"];
    fireballSprite .sourceRectangle = [Rectangle rectangleWithX: 0 y: 0 width:50 height:38];
    fireballSprite .origin = [Vector2 vectorWithX:25 y:19];}

- (void) drawWithGameTime:(GameTime *)gameTime {
    [self.graphicsDevice clearWithColor:[Color saddleBrown]];
    
    [spriteBatch beginWithSortMode:SpriteSortModeBackToFront BlendState:nil SamplerState:nil
                 DepthStencilState:nil RasterizerState:nil Effect:nil TransformMatrix:camera];
    
    [spriteBatch draw:background to:[Vector2 vectorWithX:0 y:-342] fromRectangle:nil tintWithColor:[Color white]
             rotation:0 origin:[Vector2 zero] scaleUniform:1 effects:SpriteEffectsNone layerDepth:0.8];
    
    for (id item in level.scene) {
        
        id <IPosition> itemWithPosition = [item conformsToProtocol:@protocol(IPosition)] ? item : nil;
        
        Sprite *sprite = nil;
        Color *color = nil;
        float depth = 0.9;
        
        if ([item isKindOfClass:[Dirt class]]) {
            sprite = dirtSprite;
            color = [Color whiteSmoke];
        } else if ([item isKindOfClass:[Miner class]]) {
            Miner *miner = (Miner*)item;
            int rand = [Random int];
            int minerIndex = rand % 3;
            if(miner.minning){
                sprite = [minerSprite3[minerIndex] spriteAtTime:miner.lifetime.progress];
            }
            else{
                sprite = [minerSprite2[minerIndex] spriteAtTime:miner.lifetime.progress];
            }
            
            //sprite=minerSprite;
            color = [Color whiteSmoke];
            depth=0.7;

        } else if ([item isKindOfClass:[Lava class]]){
            sprite = lavaSprite;
            color = [Color whiteSmoke];
        } else if ([item isKindOfClass:[FBall class]]){
            sprite = fireballSprite;
            color = [Color whiteSmoke];
            depth = 0.7;
        }
        else if ([item isKindOfClass:[Stone class]]){
            sprite = stoneSprite;
            color = [Color whiteSmoke];
        }
        else if ([item isKindOfClass:[Gold class]]){
            sprite = goldSprite;
            color = [Color whiteSmoke];
        }
        else if ([item isKindOfClass:[Diamond class]]){
            sprite = diamondSprite;
            color = [Color whiteSmoke];
        }
        else if ([item isKindOfClass:[Treasure class]]){
            sprite = treasureSprite;
            color = [Color whiteSmoke];
        }
        
        if (itemWithPosition && sprite) {
            [spriteBatch draw:sprite.texture to:itemWithPosition.position fromRectangle:sprite.sourceRectangle tintWithColor:color
                     rotation:0 origin:sprite.origin scaleUniform:0.5 effects:SpriteEffectsNone layerDepth:depth];
        }
        Label *label = [item isKindOfClass:[Label class]] ? item : nil;
        Image *image = [item isKindOfClass:[Image class]] ? item : nil;
        
        if (label) {
            [spriteBatch drawStringWithSpriteFont:label.font text:label.text to:label.position tintWithColor:label.color
                                         rotation:label.rotation origin:label.origin scale:label.scale effects:SpriteEffectsNone layerDepth:label.layerDepth];
        }
        
        if (image) {
            [spriteBatch draw:image.texture to:image.position fromRectangle:image.sourceRectangle tintWithColor:image.color
                     rotation:image.rotation origin:image.origin scale:image.scale effects:SpriteEffectsNone layerDepth:image.layerDepth];
        }
    }
    
    for (int i = 0; i < level.lives; i++) {
        [spriteBatch draw:lifeSprite.texture to:[Vector2 vectorWithX:self.game.gameWindow.clientBounds.width - (i+1) * 40 y:0] fromRectangle:lifeSprite.sourceRectangle tintWithColor:[Color whiteSmoke]
                 rotation:0 origin:lifeSprite.origin scaleUniform:0.25 effects:SpriteEffectsNone layerDepth:0.7];
    }
    
    
    [spriteBatch end];
}

- (void) unloadContent {
    //	[content unload];
}

- (void) dealloc
{
    [content release];
    [spriteBatch release];
    [super dealloc];
}

@end
