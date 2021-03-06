//
//  MBAnimationSequencer
//  Mo Bitar
//
//  Created by Mo Bitar on 3/23/13.
//  Copyright (c) 2013 bitar.io. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    FXAnimationTypeViews,
    FXAnimationTypeLayers
} FXAnimationType;

typedef void (^FXAnimationBlock)(UIView *view, CGFloat duration);
typedef void (^FXLayerAnimationBlock)(CALayer *layer, CGFloat duration);

@class MBTimer;
@interface MBAnimationStep : NSObject

@property (nonatomic, strong) NSArray *views;
@property (nonatomic, strong) NSArray *layers;
@property (nonatomic) CGFloat duration;

// the amount of seconds to wait after previous step has completed before performing this animation
@property (nonatomic) CGFloat relativeOffset;

// do timer.currentValue to find out how many seconds have passed in the animation so far
@property (nonatomic, strong) MBTimer *timer;

// the number of seconds to wait between performing animations between views/layers
@property (nonatomic) CGFloat delayBetweenViews;

// showtime
- (void)perform;

// cleanup
- (void)removeAnimations;

// inforation

+ (CGFloat)durationForStepWithItemCount:(NSUInteger)count singleItemDuration:(CGFloat)duration delayBetweenEveryView:(CGFloat)delay;

// factory
+ (MBAnimationStep*)viewAnimationStepWithViews:(NSArray*)views duration:(CGFloat)duration block:(FXAnimationBlock)block;
+ (MBAnimationStep*)layerAnimationStepWithLayers:(NSArray*)layers duration:(CGFloat)duration block:(FXLayerAnimationBlock)block;

@end
