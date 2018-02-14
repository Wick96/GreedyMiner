#import "Retronator.Xni.Framework.Content.h"
#import "Artificial.Mirage.h"
#import "Express.Scene.h"

#import "Retronator.GreedyMiner.classes.h"

@interface GameHud : GameComponent {
    SimpleScene *scene;
    
    Label *playerScore;
    
    Color *playerColor;
    

}

@property (nonatomic, readonly) id<IScene> scene;

- (void) changePlayerScoreFor:(int)value;

@end
