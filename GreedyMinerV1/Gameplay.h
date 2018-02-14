#import "Retronator.GreedyMiner.classes.h"

#import "GameState.h"

@interface Gameplay : GameState {
    Level *level;
    GameHud *hud;
    
    Player *player;
    
    int score;
    int changeScore;
    int lastscore;
    
    GameRenderer *renderer;
    GuiRenderer *hudRenderer;
    PhysicsEngine *physics;

}

- (id) initSinglePlayerWithGame:(Game*)theGame levelClass:(Class)levelClass;

@end