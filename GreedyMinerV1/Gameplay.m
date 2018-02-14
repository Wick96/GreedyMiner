#import "Gameplay.h"

#import "Retronator.GreedyMiner.h"

@interface Gameplay ()

- (void) startInitWithLevelClass:(Class)levelClass;
- (void) finishInit;

@end


@implementation Gameplay

- (id) initSinglePlayerWithGame:(Game *)theGame levelClass:(Class)levelClass
{
    self = [super initWithGame:theGame];
    if (self != nil) {
        
        [self startInitWithLevelClass:levelClass];
        
        player = [[HumanPlayer alloc] initWithGame:self.game miner:level.miner];
        
        [self finishInit];
    }
    return self;
}

- (void) startInitWithLevelClass:(Class)levelClass
{
    level = [[levelClass alloc] initWithGame:self.game];
    level.lives = 3;
}

- (void) finishInit
{
    physics = [[PhysicsEngine alloc] initWithGame:self.game level:level];
    physics.updateOrder = 20;
    
    renderer = [[GameRenderer alloc] initWithGame:self.game level:level];
    
    hud = [[GameHud alloc] initWithGame:self.game];
    
    hudRenderer = [[GuiRenderer alloc] initWithGame:self.game scene:hud.scene];
    hudRenderer.drawOrder = 1;
    
    
    player.updateOrder = 0;
    physics.updateOrder = 2;
    level.updateOrder = 3;
    level.scene.updateOrder = 4;
    self.updateOrder = 5;
    lastscore = level.dirtCount*10 + level.goldCount*100 + level.diamondCount*200 + level.treasureCount*500;
    changeScore = 0;

}

- (void) activate {
    [self.game.components addComponent:level];
    [self.game.components addComponent:hud];
    [self.game.components addComponent:hudRenderer];
    [self.game.components addComponent:renderer];
    [self.game.components addComponent:physics];
    [self.game.components addComponent:player];
}

- (void) deactivate {
    [self.game.components removeComponent:hud];
    [self.game.components removeComponent:hudRenderer];
    [self.game.components removeComponent:level];
    [self.game.components removeComponent:renderer];
    [self.game.components removeComponent:physics];
    [self.game.components removeComponent:player];
}

- (void) initialize {
    [super initialize];
    
    if([player isKindOfClass:[HumanPlayer class]]){
        [(HumanPlayer*)player setCamera:renderer.camera];
    }
    
    [level resetLevel];

}

- (void) updateWithGameTime:(GameTime *)gameTime {
    if (level.miner.destroyed) {
        level.lives--;
        level.miner.destroyed=NO;
        [SoundEngine play:SoundEffectTypeWin];
        HumanPlayer *hplayer = (HumanPlayer*)player;
        [hplayer resetPlayer];
        
        [level resetLevel];
        
        // Check game lost condition.
        if (level.lives < 0) {
            [greedyMiner.progress updateScore:[greedyMiner.progress returnScore]];
            [greedyMiner popState];
        }
    }
    
    // Check level won condition
    if (level.dirtCount == 0 && level.goldCount == 0 && level.diamondCount==0 && level.treasureCount==0){
        LevelType levelType = [[level class] levelType];
        [greedyMiner.progress unlockLevel:levelType];
        [greedyMiner.progress updateScore:score];
        [SoundEngine play:SoundEffectTypeWin];
        [greedyMiner popState];
    }
    
    if(lastscore>level.dirtCount*10 + level.goldCount*100 + level.diamondCount*200 + level.treasureCount*500){
        int new = level.dirtCount*10 + level.goldCount*100 + level.diamondCount*200 + level.treasureCount*500;
        score=score+lastscore-new;
        lastscore=new;
        changeScore++;
        [hud changePlayerScoreFor:score];
    }
    
    if(changeScore==0){
        score = [greedyMiner.progress returnScore];
        [hud changePlayerScoreFor:score];
    }
}


- (void) dealloc
{
    [hud release];
    [hudRenderer release];
    [level release];
    [renderer release];
    [physics release];
    [player release];
    [super dealloc];
}



@end

