#import "Retronator.Xni.Framework.Audio.h"
#import "Retronator.GreedyMiner.classes.h"

@interface SoundEngine : GameComponent {
    SoundEffect *soundEffects[SoundEffectTypes];
}

+ (void) initializeWithGame:(Game*)game;
+ (void) play:(SoundEffectType)type;

@end
