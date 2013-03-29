//
//  MBAnimationSequencer
//  Mo Bitar
//
//  Created by Mo Bitar on 3/23/13.
//  Copyright (c) 2013 bitar.io. All rights reserved.
//

#import "MBAnimationStore.h"
#import <QuartzCore/QuartzCore.h>

@implementation MBAnimationStore

#pragma mark General

+ (CABasicAnimation*)basicAnimationForKeyPath:(NSString*)keyPath fromValue:(id)fromValue toValue:(id)toValue duration:(CGFloat)duration fillMode:(NSString*)fillMode removeOnCompletion:(BOOL)removeOnCompletion {
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:keyPath];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];

    if(fromValue)
        animation.fromValue = fromValue;
    if(toValue)
        animation.toValue = toValue;

    animation.duration = duration;
    if(fillMode)
        animation.fillMode = fillMode;
    animation.removedOnCompletion = removeOnCompletion;
    return animation;
}

+ (CAKeyframeAnimation*)keyFrameAnimationForKeyPath:(NSString*)keyPath values:(NSArray*)values times:(NSArray*)times path:(CGPathRef)path duration:(CGFloat)duration fillMode:(NSString*)fillMode removeOnCompletion:(BOOL)remove {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:keyPath];
    if(path)
        animation.path = path;
    if(values)
        animation.values = values;
    if(times)
        animation.keyTimes = times;
    if(fillMode)
        animation.fillMode = fillMode;
    
    animation.duration = duration;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.rotationMode = kCAAnimationRotateAuto;
    animation.removedOnCompletion = remove;
    return animation;
}

+ (CATransition*)transitionWithType:(NSString*)type subtype:(NSString*)subtype duration:(CGFloat)duration timingFunctionName:(NSString*)timingFunctionName removeOnCompletion:(BOOL)removeOnCompletion {
    CATransition *transition = [CATransition animation];
    transition.type = type;
    transition.subtype = subtype;
    transition.duration = duration;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:timingFunctionName];
    transition.removedOnCompletion = removeOnCompletion;
    return transition;
}

#pragma mark Helpers

+ (void)applyTransform:(CATransform3D)transform toViews:(NSArray*)views layers:(NSArray*)layers {
    for(UIView *view in views)
        view.layer.transform = transform;
    for(CALayer *layer in layers)
        layer.transform = transform;
}

#pragma mark Custom

+ (CABasicAnimation*)pulseAnimationToMaxScale:(CATransform3D)scale {
    CABasicAnimation *animation = [self basicAnimationForKeyPath:@"transform" fromValue:nil toValue:[NSValue valueWithCATransform3D:scale] duration:0.35 fillMode:nil removeOnCompletion:YES];
    animation.autoreverses = YES;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.repeatCount = HUGE_VAL;
    return animation;
}

// set your layer's transform with a scale before applying this to generate a pulsing effect
+ (CABasicAnimation*)pulseAnimation {
    return [self pulseAnimationToMaxScale:CATransform3DIdentity];
}

NSValue *valueWith3DScaleTransform(float x, float y, float z) {
    return [NSValue valueWithCATransform3D:CATransform3DMakeScale(x, y, z)];
}

NSValue *valueWith3DTransform(CATransform3D t) {
    return [NSValue valueWithCATransform3D:t];
}

+ (CAKeyframeAnimation*)bounceAnimationWithDuration:(CGFloat)duration maxScale:(CGFloat)maxScale {
    NSArray *frameValues = @[valueWith3DScaleTransform(1,1,1),
                             valueWith3DScaleTransform(maxScale, maxScale, 1),
                             valueWith3DScaleTransform(0.8, 0.8, 1),
                             valueWith3DScaleTransform(1, 1, 1)];
    NSArray *frameTimes = @[@(0.0), @(0.5), @(0.9), @(1.0)];
    return [self keyFrameAnimationForKeyPath:@"transform" values:frameValues times:frameTimes path:nil duration:duration fillMode:kCAFillModeForwards removeOnCompletion:NO];
}

+ (CATransition*)pushTransitionWithSubType:(NSString*)subtype duration:(CGFloat)duration {
    return [self transitionWithType:kCATransitionPush subtype:subtype duration:duration timingFunctionName:kCAMediaTimingFunctionEaseInEaseOut removeOnCompletion:YES];
}

@end
