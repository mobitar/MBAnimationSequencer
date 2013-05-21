//
//  MBAnimationSequencer
//  Mo Bitar
//
//  Created by Mo Bitar on 3/23/13.
//  Copyright (c) 2013 bitar.io. All rights reserved.
//

#import "MBAnimationStep.h"
#import "MBTimer.h"
#import "NSTimer+Blocks.h"
#import <QuartzCore/QuartzCore.h>

@interface MBAnimationStep ()
@property (nonatomic, copy) FXAnimationBlock viewBlock;
@property (nonatomic, copy) FXLayerAnimationBlock layerBlock;
@property (nonatomic) NSMutableArray *schedulers;
@end

@implementation MBAnimationStep

// if relativeOffset is nil, the animation waits until the previous step has completed
// if relative offset is >= 0, the animation starts after the previous step with the specified offset

+ (MBAnimationStep*)viewAnimationStepWithViews:(NSArray*)views duration:(CGFloat)duration block:(FXAnimationBlock)block {
    MBAnimationStep *step = [self stepWithDuration:duration];
    step.viewBlock = block;
    step.views = views;
    return step;
}

+ (MBAnimationStep*)layerAnimationStepWithLayers:(NSArray*)layers duration:(CGFloat)duration block:(FXLayerAnimationBlock)block {
    MBAnimationStep *step = [self stepWithDuration:duration];
    step.layerBlock = block;
    step.layers = layers;
    return step;
}

+ (MBAnimationStep*)stepWithDuration:(CGFloat)duration {
    MBAnimationStep *step = [MBAnimationStep new];
    step.duration = duration;
    return step;
}

#pragma mark Info

+ (CGFloat)durationForStepWithItemCount:(NSUInteger)count singleItemDuration:(CGFloat)duration delayBetweenEveryView:(CGFloat)delay {
    return (count * delay) + duration - delay;
}

- (id)init {
    if(self = [super init]) {
        _timer = [MBTimer new];
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

