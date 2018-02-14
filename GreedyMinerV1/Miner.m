//
//  Miner.m
//  GreedyMinerV1
//
//  Created by Tone Novak on 02/12/17.
//  Copyright © 2017 Tone Novak. All rights reserved.
//

#import "Miner.h"

#import "Retronator.GreedyMiner.h"
#import "Artificial.Everywhere.h"

@implementation Miner

- (id) initWithGameTime:(GameTime *)gameTime
{
    self = [super init];
    if (self != nil) {
        position = [[Vector2 alloc] init];
        velocity = [[Vector2 alloc] init];
        lifetime = [[Lifetime alloc] initWithStart:gameTime.totalGameTime duration:1];
        width = 32;
        height = 32;
        mass = 1;
        cantmove = NO;
        
    }
    return self;
}

-(id) init{
    self = [super init];
    if (self != nil) {
        position = [[Vector2 alloc] init];
        velocity = [[Vector2 alloc] init];
        width = 32;
        height = 32;
        mass = 1;
        
    }
    return self;
}

@synthesize position, velocity, width, height, mass, destroyed, lifetime, minning, cantmove;

- (BOOL) collidingWithItem:(id)item {
    return YES;
}

- (void) collidedWithItem:(id)item {
    if([item isKindOfClass:[Lava class]]){
        destroyed=YES;
    }
    else if([item isKindOfClass:[FBall class]]){
        destroyed=YES;
    }
    else if([item isKindOfClass:[Stone class]]){
        cantmove=YES;
    }
    else if([item isKindOfClass:[RectangleWall class]]){
        RectangleWall *wall = (RectangleWall*) item;
        if(wall.fly){
            minning=YES;
        }
        else{
            minning=NO;
        }
        
    }
    else if([item isKindOfClass:[Dirt class]] || [item isKindOfClass:[Gold class]] || [item isKindOfClass:[Diamond class]] || [item isKindOfClass:[Treasure class]]){
        [SoundEngine play:SoundEffectTypeDig];
    }
    
}

- (void) dealloc
{
    [position release];
    [super dealloc];
}

@end
