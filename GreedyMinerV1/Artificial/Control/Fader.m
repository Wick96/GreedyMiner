//
//  Fader.m
//  Artificial I
//
//  Created by Matej Jan on 4.12.10.
//  Copyright 2010 Retronator. All rights reserved.
//

#import "Fader.h"

@interface Fader()

- (void) fadeWithTarget:(float)theTarget;

@end


@implementation Fader

- (id) initWithMin:(float)minValue max:(float)maxValue duration:(NSTimeInterval)theDuration {
    if (self = [super init]) {
        min = minValue;
        max = maxValue;
        duration = theDuration;
        value = minValue;
        finished = YES;
    }
    return self;
}

@synthesize finished;
@synthesize value;
@synthesize min;
@synthesize max;
@synthesize duration;

- (void) fadeIn {
    [self fadeWithTarget:max];
}

- (void) fadeOut {
    [self fadeWithTarget:min];
}

- (void) fadeWithTarget:(float)theTarget {
    target = theTarget;
    float distance = target - value;
    rate = copysignf(fabsf(max-min)/duration, distance);
    remaining = fabsf(distance);
    finished = NO;
}

- (void) updateWithElapsed:(NSTimeInterval)elapsed {
    if (finished) {
        return;
    }
    
    float change = rate * elapsed;
    value += change;
    remaining -= fabsf(change);
    
    if (remaining < 0) {
        value = target;
        remaining = 0;
        finished = YES;
    }
}

@end
