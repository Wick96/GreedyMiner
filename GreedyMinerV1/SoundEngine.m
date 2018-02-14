#import "SoundEngine.h"

#import "Retronator.Xni.Framework.Content.h"

SoundEngine *instance;

@implementation SoundEngine

+ (void) initializeWithGame:(Game*)game {
    instance = [[SoundEngine alloc] initWithGame:game];
    [game.components addComponent:instance];
}

- (void) initialize {
    soundEffects[SoundEffectTypeDig] = [self.game.content load:@"Dig"];
    soundEffects[SoundEffectTypeExp] = [self.game.content load:@"Exp"];
    soundEffects[SoundEffectTypeWin] = [self.game.content load:@"Win"];
    soundEffects[SoundEffectTypeClick] = [self.game.content load:@"click"];
}

- (void) play:(SoundEffectType)type withPan:(float)pan {
    [soundEffects[type] playWithVolume:1 pitch:0 pan:0];
}

+ (void) play:(SoundEffectType)type {
    [SoundEngine play:type withPan:0];
}

+ (void) play:(SoundEffectType)type withPan:(float)pan {
    [instance play:type withPan:pan];
}

- (void) dealloc
{
    for (int i = 0; i < SoundEffectTypes; i++) {
        [soundEffects[i] release];
    }
    [super dealloc];
}


@end

