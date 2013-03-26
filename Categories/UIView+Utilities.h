//
//  UIView+Utilities.h
//  nubhub
//
//  Created by Mo Bitar on 3/18/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (Utilities)

// frame operations
- (void)setXOrigin:(CGFloat)x;
- (void)setYOrigin:(CGFloat)y;
- (void)setOrigin:(CGPoint)origin;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)setSize:(CGSize)size;
- (void)setOrigin:(CGPoint)origin size:(CGSize)size;
- (void)shiftBy:(CGSize)shift;
- (void)offsetSizeBy:(CGSize)size;
- (void)centerWithRespectToView:(UIView*)view;
- (void)centerVerticallyWithRespectToView:(UIView*)view;
- (void)centerHorizontallyWithRespectToView:(UIView*)view;

// beauty
- (CAGradientLayer*)addGradientWithColors:(NSArray*)colors locations:(NSArray*)locations vertical:(BOOL)vertical;
- (void)addBorderWithColor:(UIColor*)color width:(CGFloat)width;
- (void)addShadowWithColor:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity;

// info
- (CGSize)size;
- (CGPoint)origin;
- (CGFloat)frameEndX;
- (CGPoint)frameEndPoint;
- (CGFloat)width;
- (CGFloat)height;
- (CGFloat)yOrigin;
- (CGFloat)yOriginPlusHeight;
- (CGFloat)xOriginPlusWidth;

// utilities
- (void)resignFirstRespondersRecursively;
- (UIView*)viewFromNibNamed:(NSString*)name;
@end
