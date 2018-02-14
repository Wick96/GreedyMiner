#import "Artificial.Mirage.h"

#import "Express.Scene.h"

#import "Retronator.GreedyMiner.classes.h"

#import "GameState.h"

@interface Menu : GameState {
    SimpleScene *scene;
    GuiRenderer *renderer;
    
    SpriteFont *mainfont;
    Texture2D *buttonBackground;
    
    Button *back;
}

@end
