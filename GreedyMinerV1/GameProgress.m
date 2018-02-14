#import "GameProgress.h"

#import "Retronator.GreedyMiner.h"

@implementation GameProgress

- (id) init
{
    self = [super init];
    if (self != nil) {
        // Unlock first opponent and level type.
        levelUnlocked[LevelTypeStart] = YES;
        score = 0;
        music = YES;
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self != nil) {
        for (int i = 0; i < LevelTypes; i++) {
            levelUnlocked[i] = [aDecoder decodeBoolForKey:[NSString stringWithFormat:@"levelUnlocked%i", i]];
        }
        score = [aDecoder decodeBoolForKey:[NSString stringWithFormat:@"score"]];
        music = [aDecoder decodeBoolForKey:[NSString stringWithFormat:@"music"]];
    }
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    for (int i = 0; i < LevelTypes; i++) {
        [aCoder encodeBool:levelUnlocked[i] forKey:[NSString stringWithFormat:@"levelUnlocked%i", i]];
    }
    [aCoder encodeBool:score forKey:[NSString stringWithFormat:@"score"]];
    [aCoder encodeBool:music forKey:[NSString stringWithFormat:@"music"]];
}

+ (GameProgress *) loadProgress {
    // Load game progress from file.
    GameProgress *progress = nil;
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *archivePath = [rootPath stringByAppendingPathComponent:[Constants progressFilePath]];
    progress = [NSKeyedUnarchiver unarchiveObjectWithFile:archivePath];
    
    // If there is no progress file, create a fresh instance.
    if (!progress) {
        progress = [[[GameProgress alloc] init] autorelease];
    }
    
    
    return progress;
}

+ (void) deleteProgress {
    // Delete game progress file.
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *archivePath = [rootPath stringByAppendingPathComponent:[Constants progressFilePath]];
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtPath:archivePath error:&error];
}

- (void) saveProgress {
    // Save game progress to file.
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *archivePath = [rootPath stringByAppendingPathComponent:[Constants progressFilePath]];
    [NSKeyedArchiver archiveRootObject:self toFile:archivePath];
}

- (BOOL) isLevelUnlocked:(LevelType)type {
    return levelUnlocked[type];
}


- (void) unlockLevel:(LevelType)type {
    levelUnlocked[type] = YES;
    [self saveProgress];
}


- (void) updateScore:(int)s{
    score = s;
    [self saveProgress];
}

- (int) returnScore{
    return score;
}

- (BOOL) isMusic {
    return music;
}

- (void) setMusic:(BOOL)s {
    music = s;
    [self saveProgress];
}

@end

