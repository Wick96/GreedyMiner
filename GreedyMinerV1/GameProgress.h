#import "Retronator.GreedyMiner.classes.h"

@interface GameProgress : NSObject <NSCoding> {
    BOOL levelUnlocked[LevelTypes];
    int score;
    BOOL music;
}

+ (GameProgress *) loadProgress;
+ (void) deleteProgress;
- (void) saveProgress;

- (BOOL) isLevelUnlocked:(LevelType)type;
- (int) returnScore;
- (BOOL) isMusic;

- (void) unlockLevel:(LevelType)type;
- (void) updateScore:(int)s;
- (void) setMusic:(BOOL)s;

@end
