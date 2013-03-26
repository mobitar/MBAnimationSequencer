//
//  FXAnimationController.h
//  Flexbumin
//
//  Created by Mo Bitar on 3/23/13.
//  Copyright (c) 2013 Ora. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FXAnimationStep.h"
#import "FXAnimationStore.h"

@class FXAnimationStep;
@interface FXAnimationController : NSObject

// looping options
@property (nonatomic) NSUInteger repeatCount;
@property (nonatomic) CGFloat delayBetweenRepititions;
@property (nonatomic) BOOL shouldRemoveAllAnimationsBetweenIterations;

// completion options
@property (nonatomic) BOOL shouldRemoveAllAnimationsOnOverallCompletion;

// information
@property (nonatomic, readonly) BOOL isAnimationInProgress;

// factory
+ (FXAnimationController*)animationControllerWithAnimations:(NSArray*)animations removeOnCompletion:(BOOL)removeOnCompletion;

// quickie
+ (void)spawnAnimationControllerToPlayAnimations:(NSArray*)animations removeOnCompletion:(BOOL)removeOnCompletion;
+ (void)spawnAnimationControllerToPlayAnimations:(NSArray*)animations removeOnCompletion:(BOOL)removeOnCompletion delay:(CGFloat)delay;

// preparation
- (void)addAnimationToSequence:(FXAnimationStep*)animation;

// showtime
- (void)playFromBeginning;
- (void)playFromStep:(FXAnimationStep*)step;
- (void)playStep:(FXAnimationStep *)step;

// cleanup
- (void)removeAllAnimationsAndResetState;
@end
