//
//  MBAnimationSequencer
//  Mo Bitar
//
//  Created by Mo Bitar on 3/23/13.
//  Copyright (c) 2013 bitar.io. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CABasicAnimation, CAAnimation, CAKeyframeAnimation, CATransition;
@interface MBAnimationStore : NSObject

// General
+ (CABasicAnimation*)basicAnimationForKeyPath:(NSString*)keyPath fromValue:(id)fromValue toValue:(id)toValue duration:(CGFloat)duration fillMode:(NSString*)fillMode removeOnCompletion:(BOOL)removeOnCompletion;
+ (CAKeyframeAnimation*)keyFrameAnimationForKeyPath:(NSString*)keyPath values:(NSArray*)values times:(NSArray*)times path:(CGPathRef)path duration:(CGFloat)duration fillMode:(NSString*)fillMode removeOnCompletion:(BOOL)remove;
+ (CATransition*)transitionWithType:(NSString*)type subtype:(NSString*)subtype duration:(CGFloat)duration timingFunctionName:(NSString*)timingFunctionName removeOnCompletion:(BOOL)removeOnCompletion;
// Helpers
+ (void)applyTransform:(CATransform3D)transform toViews:(NSArray*)views layers:(NSArray*)layers;
NSValue *valueWith3DTransform(CATransform3D t);

// Custom
+ (CABasicAnimation*)pulseAnimation;
+ (CABasicAnimation*)pulseAnimationToMaxScale:(CATransform3D)scale;
+ (CAKeyframeAnimation*)bounceAnimationWithDuration:(CGFloat)duration maxScale:(CGFloat)maxScale;
+ (CATransition*)pushTransitionWithSubType:(NSString*)subtype duration:(CGFloat)duration;


@end
