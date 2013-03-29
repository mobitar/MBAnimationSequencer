//
//  MBAnimationSequencer
//  Mo Bitar
//
//  Created by Mo Bitar on 3/23/13.
//  Copyright (c) 2013 bitar.io. All rights reserved.
//

#import "MBAnimationSequencer.h"
#import "MBTimer.h"
#import "NSTimer+Blocks.h"
#import <QuartzCore/QuartzCore.h>


@interface MBAnimationSequencer ()
@property (nonatomic) NSMutableArray *steps;
@property (nonatomic) NSMutableArray *schedulers;
@property (nonatomic) NSMutableArray *removedSteps;

@property (nonatomic) MBAnimationStep *currentStep;
@property (nonatomic) CGFloat currentPlayCount;

@property (nonatomic) MBTimer *timer;
@end

@implementation MBAnimationSequencer {
    BOOL stop;
}

- (id)init {
    if(self = [super init]) {
        _steps = [NSMutableArray new];
        _timer = [MBTimer new];
        _removedSteps = [NSMutableArray new];
        _schedulers = [NSMutableArray new];
        _shouldRemoveAllAnimationsOnOverallCompletion = YES;
        _shouldRemoveAllAnimationsBetweenIterations = YES;
    }
    return self;
}

#pragma mark Setup

+ (void)spawnAnimationControllerToPlayAnimations:(NSArray*)animations removeOnCompletion:(BOOL)removeOnCompletion {
    [[self animationControllerWithAnimations:animations removeOnCompletion:removeOnCompletion] playFromBeginning];
}

+ (void)spawnAnimationControllerToPlayAnimations:(NSArray*)animations removeOnCompletion:(BOOL)removeOnCompletion delay:(CGFloat)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [[self animationControllerWithAnimations:animations removeOnCompletion:removeOnCompletion] playFromBeginning];
    });
}

+ (MBAnimationSequencer*)animationControllerWithAnimations:(NSArray*)animations removeOnCompletion:(BOOL)removeOnCompletion {
    MBAnimationSequencer *controller = [MBAnimationSequencer new];
    controller.steps = animations.mutableCopy;
    controller.shouldRemoveAllAnimationsOnOverallCompletion = removeOnCompletion;
    return controller;
}

- (void)addAnimationToSequence:(MBAnimationStep*)animation {
    [self.steps addObject:animation];
}

- (void)restoreRemovedSteps {
    if(self.removedSteps.count > 0) {
        self.steps = [NSMutableArray arrayWithArray:self.removedSteps];
        [self.removedSteps removeAllObjects];
    }
}

#pragma mark Showtime

- (void)playFromBeginningAfterDelay:(CGFloat)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self playFromBeginning];
    });
}

- (void)playFromBeginning {
    if(self.shouldRemoveAllAnimationsBetweenIterations)
        [self removeAnimationsFromAllSteps];
    
    [self restoreRemovedSteps];
    self.currentPlayCount ++;
    [self.timer start];
    [self playNextStep];
}

- (void)playFromStep:(MBAnimationStep*)step {
    [self performStep:step singleStep:NO];
}

- (void)playStep:(MBAnimationStep *)step {
    [self performStep:step singleStep:YES];
}

/*
    NOTE:
    if you've come here, it means any previous step has completed its animation,
    and the controller is ready to play the next one
*/
- (void)playNextStep {
    MBAnimationStep *step = [self.steps objectAtIndex:0];
    [self.steps removeObjectAtIndex:0];
    [self.removedSteps addObject:step];
    
    if(step.relativeOffset > 0) {
        if(self.currentStep.timer.currentValue >= step.relativeOffset) {
            [self performStep:step singleStep:NO];
        }
        
        else {
            CGFloat diff = step.relativeOffset - self.currentStep.timer.currentValue;
            [self.schedulers addObject:[NSTimer scheduledTimerWithTimeInterval:diff block:^{
                [self performStep:step singleStep:NO];
            } repeats:NO]];
        }
    }
    // no offset, play right away
    else [self performStep:step singleStep:NO];
}

- (void)performStep:(MBAnimationStep*)step singleStep:(BOOL)singleStep {
    _isAnimationInProgress = YES;
    
    [step perform];
    self.currentStep = step;
    [step.timer stop];
    [step.timer start];
    
    if(singleStep)
        return;
    
    if(self.steps.count > 0) {
        CGFloat delay = 0;
        MBAnimationStep *nextStep = [self.steps objectAtIndex:0];
        
        if(nextStep.relativeOffset) {
            if(nextStep.relativeOffset == 0)
                delay = 0.0;
            else delay = step.duration + nextStep.relativeOffset;
        }
        else {
            delay = step.duration;
        }
        
        [self.schedulers addObject:[NSTimer scheduledTimerWithTimeInterval:delay block:^{
            [self playNextStep];
        } repeats:NO]];
    }
    
    else if(self.repeatCount > 0 && self.currentPlayCount <= self.repeatCount) {
        [self.schedulers addObject: [NSTimer scheduledTimerWithTimeInterval:step.duration + self.delayBetweenRepititions block:^{
            [self playFromBeginning];
        } repeats:NO]];
       
    }
    
    // by this point, all animations have completed
    
    else if(self.shouldRemoveAllAnimationsOnOverallCompletion) {
        [self.schedulers addObject:[NSTimer scheduledTimerWithTimeInterval:step.duration block:^{
            [self removeAllAnimationsAndResetState];
        } repeats:NO]];
    }
    
    else {
        _isAnimationInProgress = NO;
    }
}

#pragma mark Cleanup

- (void)removeAnimationsFromAllSteps {
    for(MBAnimationStep *step in self.steps) {
        [step removeAnimations];
    }
    
    for(MBAnimationStep *step in self.removedSteps) {
        [step removeAnimations];
    }
}


- (void)removeAllAnimationsAndResetState {
    _isAnimationInProgress = NO;
    
    for(NSTimer *timer in self.schedulers) {
        [timer invalidate];
    }
    
    [self removeAnimationsFromAllSteps];
    
    [self.timer stop];
    
    self.currentPlayCount = 0;
    self.currentStep = nil;
    self.repeatCount = 0;
    self.delayBetweenRepititions = 0;
    
    [self.removedSteps removeAllObjects];
    [self.steps removeAllObjects];
    [self.schedulers removeAllObjects];
}
@end
