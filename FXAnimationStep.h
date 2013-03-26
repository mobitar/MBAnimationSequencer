//
//  FXAnimationStep.h
//  Flexbumin
//
//  Created by Mo Bitar on 3/25/13.
//  Copyright (c) 2013 Ora. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FXAnimationTypeViews,
    FXAnimationTypeLayers
} FXAnimationType;

typedef void (^FXAnimationBlock)(UIView *view, CGFloat duration);
typedef void (^FXLayerAnimationBlock)(CALayer *layer, CGFloat duration);

@class FXTimer;
@interface FXAnimationStep : NSObject

@property (nonatomic) NSArray *views;
@property (nonatomic) NSArray *layers;
@property (nonatomic) CGFloat duration;

// the amount of seconds to wait after previous step has completed before performing this animation
@property (nonatomic) CGFloat relativeOffset;

// do timer.currentValue to find out how many seconds have passed in the animation so far
@property (nonatomic) FXTimer *timer;

// the number of seconds to wait between performing animations between views/layers
@property (nonatomic) CGFloat delayBetweenViews;

// showtime
- (void)perform;

// cleanup
- (void)removeAnimations;

// inforation

+ (CGFloat)durationForStepWithItemCount:(NSUInteger)count singleItemDuration:(CGFloat)duration delayBetweenEveryView:(CGFloat)delay;

// factory
+ (FXAnimationStep*)viewAnimationStepWithBlock:(FXAnimationBlock)block toViews:(NSArray*)views duration:(CGFloat)duration;
+ (FXAnimationStep*)layerAnimationStepWithBlock:(FXLayerAnimationBlock)block toLayers:(NSArray*)layers duration:(CGFloat)duration;

@end
