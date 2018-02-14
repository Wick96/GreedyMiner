#import "Express.Scene.h"

#import "Retronator.GreedyMiner.classes.h"

@interface GuiRenderer : DrawableGameComponent {
    SpriteBatch *spriteBatch;
    
    id<IScene> scene;
    
    // Camera
    Matrix *camera;
}

@property (nonatomic, readonly) Matrix *camera;

- (id) initWithGame:(Game*)theGame scene:(id<IScene>)theScene;

@end

