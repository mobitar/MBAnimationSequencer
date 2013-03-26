//
//  FXAnimationStore.h
//  Flexbumin
//
//  Created by Mo Bitar on 3/25/13.
//  Copyright (c) 2013 Ora. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CABasicAnimation, CAAnimation, CAKeyframeAnimation, CATransition;
@interface FXAnimationStore : NSObject

// General
+ (CABasicAnimation*)basicAnimationForKeyPath:(NSString*)keyPath fromValue:(id)fromValue toValue:(id)toValue duration:(CGFloat)duration fillMode:(NSString*)fillMode removeOnCompletion:(BOOL)removeOnCompletion;
+ (CAKeyframeAnimation*)keyFrameAnimationForKeyPath:(NSString*)keyPath values:(NSArray*)values times:(NSArray*)times path:(CGPathRef)path duration:(CGFloat)duration fillMode:(NSString*)fillMode removeOnCompletion:(BOOL)remove;
+ (CATransition*)transitionWithType:(NSString*)type subtype:(NSString*)subtype duration:(CGFloat)duration timingFunctionName:(NSString*)timingFunctionName removeOnCompletion:(BOOL)removeOnCompletion;
// Helpers
+ (void)applyTransform:(CATransform3D)transform toViews:(NSArray*)views layers:(NSArray*)layers;

// Custom
+ (CABasicAnimation*)pulseAnimation;
+ (CAKeyframeAnimation*)bounceAnimationWithDuration:(CGFloat)duration maxScale:(CGFloat)maxScale;
+ (CATransition*)pushTransitionWithSubType:(NSString*)subtype duration:(CGFloat)duration;
@end
