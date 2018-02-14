#import "Retronator.Xni.Framework.Content.h"
#import "Express.Graphics.h"
#import "Retronator.GreedyMiner.classes.h"

@interface GameRenderer : DrawableGameComponent {
    // Resources
    ContentManager *content;
    
    Sprite *minerSprite, *dirtSprite, *lifeSprite, *lavaSprite, *fireballSprite;
    Sprite *stoneSprite, *goldSprite, *diamondSprite, *treasureSprite;
    
    AnimatedSprite *minerSprite2[3];
    AnimatedSprite *minerSprite3[4];
    
    Texture2D *background;
    Vector2 *lightPosition;
    
    // Graphics objects
    SpriteBatch *spriteBatch;
    
    // Level
    Level *level;
    
    // Camera
    Matrix *camera;
}

@property (nonatomic, readonly) Matrix *camera;

- (id) initWithGame:(Game*)theGame level:(Level*)theLevel;

@end
