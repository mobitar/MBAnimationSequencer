//
//  MBAnimationSequencer
//  Mo Bitar
//
//  Created by Mo Bitar on 3/23/13.
//  Copyright (c) 2013 bitar.io. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBAnimationStep.h"
#import "MBAnimationStore.h"

@class MBAnimationStep;
@interface MBAnimationSequencer : NSObject

// looping options
@property (nonatomic) NSUInteger repeatCount;
@property (nonatomic) CGFloat delayBetweenRepititions;
@property (nonatomic) BOOL shouldRemoveAllAnimationsBetweenIterations;

// completion options
@property (nonatomic) BOOL shouldRemoveAllAnimationsOnOverallCompletion;

// information
@property (nonatomic, readonly) BOOL isAnimationInProgress;

// factory
+ (MBAnimationSequencer*)animationControllerWithAnimations:(NSArray*)animations removeOnCompletion:(BOOL)removeOnCompletion;

// quickie
+ (void)spawnAnimationControllerToPlayAnimations:(NSArray*)animations removeOnCompletion:(BOOL)removeOnCompletion;
+ (void)spawnAnimationControllerToPlayAnimations:(NSArray*)animations removeOnCompletion:(BOOL)removeOnCompletion delay:(CGFloat)delay;

// preparation
- (void)addAnimationToSequence:(MBAnimationStep*)animation;

// showtime
- (void)playFromBeginning;
- (void)playFromBeginningAfterDelay:(CGFloat)delay;
- (void)playFromStep:(MBAnimationStep*)step;
- (void)playStep:(MBAnimationStep *)step;
- (void)stop;

// cleanup
- (void)removeAllAnimationsAndResetState;
@end
