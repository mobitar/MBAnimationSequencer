//
//  FXAnimationStep.m
//  Flexbumin
//
//  Created by Mo Bitar on 3/25/13.
//  Copyright (c) 2013 Ora. All rights reserved.
//

#import "FXAnimationStep.h"
#import "FXTimer.h"
#import "NSTimer+Blocks.h"
#import <QuartzCore/QuartzCore.h>

@interface FXAnimationStep ()
@property (nonatomic, copy) FXAnimationBlock viewBlock;
@property (nonatomic, copy) FXLayerAnimationBlock layerBlock;
@property (nonatomic) NSMutableArray *schedulers;
@end

@implementation FXAnimationStep

// if relativeOffset is nil, the animation waits until the previous step has completed
// if relative offset is >= 0, the animation starts after the previous step with the specified offset

+ (FXAnimationStep*)viewAnimationStepWithBlock:(FXAnimationBlock)block toViews:(NSArray*)views duration:(CGFloat)duration {
    FXAnimationStep *step = [self stepWithDuration:duration];
    step.viewBlock = block;
    step.views = views;
    return step;
}

+ (FXAnimationStep*)layerAnimationStepWithBlock:(FXLayerAnimationBlock)block toLayers:(NSArray*)layers duration:(CGFloat)duration{
    FXAnimationStep *step = [self stepWithDuration:duration];
    step.layerBlock = block;
    step.layers = layers;
    return step;
}

+ (FXAnimationStep*)stepWithDuration:(CGFloat)duration {
    FXAnimationStep *step = [FXAnimationStep new];
    step.duration = duration;
    return step;
}

#pragma mark Info

+ (CGFloat)durationForStepWithItemCount:(NSUInteger)count singleItemDuration:(CGFloat)duration delayBetweenEveryView:(CGFloat)delay {
    return (count * delay) + duration - delay;
}

- (id)init {
    if(self = [super init]) {
        _timer = [FXTimer new];
    }
    return self;
}

- (void)setDelayBetweenViews:(CGFloat)delayBetweenViews {
    _delayBetweenViews = delayBetweenViews;
    self.schedulers = [NSMutableArray new];
}

- (void)perform {
    CGFloat currentOffset = 0;
    [self.timer start];
    for(UIView *view in self.views) {
        [self.schedulers addObject:[NSTimer scheduledTimerWithTimeInterval:currentOffset block:^{
            [self performViewBlockForView:view];
        } repeats:NO]];
        
        if(self.delayBetweenViews)
            currentOffset +=  self.delayBetweenViews;
    }
    for(CALayer *layer in self.layers) {
        [self.schedulers addObject:[NSTimer scheduledTimerWithTimeInterval:currentOffset block:^{
            [self performLayerBlockForLayer:layer];
        } repeats:NO]];
        if(self.delayBetweenViews)
            currentOffset +=  self.delayBetweenViews;
    }
}

- (void)performViewBlockForView:(UIView*)view {
    self.viewBlock(view, self.duration);
}

- (void)performLayerBlockForLayer:(CALayer*)layer {
    self.layerBlock(layer, self.duration);
}

- (void)removeAnimations {
    for(NSTimer *timer in self.schedulers) {
        [timer invalidate];
    }
    
    [self.schedulers removeAllObjects];
    
    for(UIView *view in self.views) {
        [view.layer removeAllAnimations];
    }
    
    for(CALayer *layer in self.layers)
        [layer removeAllAnimations];
    
    [self.timer stop];
}

@end

