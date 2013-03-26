//
//  UIView+Utilities.m
//  nubhub
//
//  Created by Mo Bitar on 3/18/13.
//  Copyright (c) 2013 progenius. All rights reserved.
//

#import "UIView+Utilities.h"

@implementation UIView (Utilities)

#pragma mark Frame Operations

- (void)setXOrigin:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setYOrigin:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin size:(CGSize)size {
    CGRect frame = self.frame;
    frame.origin = origin, frame.size = size;
    self.frame = frame;
}

- (void)shiftBy:(CGSize)shift {
    CGRect frame = self.frame;
    frame.origin.x += shift.width;
    frame.origin.y += shift.height;
    self.frame = frame;
}

- (void)offsetSizeBy:(CGSize)size {
    CGRect frame = self.frame;
    frame.size.width += size.width;
    frame.size.height += size.height;
    self.frame = frame;
}

- (void)centerWithRespectToView:(UIView*)view {
    CGRect frame = self.frame;
    frame.origin = CGPointMake(view.bounds.size.width/2.0 - frame.size.width/2.0, view.bounds.size.height/2.0 - frame.size.height/2.0);
    self.frame = frame;
}

- (void)centerHorizontallyWithRespectToView:(UIView*)view {
    CGRect frame = self.frame;
    frame.origin = CGPointMake(view.bounds.size.width/2.0 - frame.size.width/2.0, frame.origin.y);
    self.frame = frame;
}

- (void)centerVerticallyWithRespectToView:(UIView*)view {
    CGRect frame = self.frame;
    frame.origin = CGPointMake(frame.origin.x, view.bounds.size.height/2.0 - frame.size.height/2.0);
    self.frame = frame;
}

#pragma mark - Info

- (CGSize)size {
    return self.bounds.size;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (CGFloat)frameEndX {
    return self.frame.origin.x + self.width;
}

- (CGPoint)frameEndPoint {
    return CGPointMake(self.frame.origin.x + self.width, self.frame.origin.y + self.height);
}

- (CGFloat)width {
    return self.bounds.size.width;
}

- (CGFloat)height {
    return self.bounds.size.height;
}

- (CGFloat)yOrigin {
    return self.frame.origin.y;
}

- (CGFloat)yOriginPlusHeight {
    CGRect frame = self.frame;
    return frame.origin.y + frame.size.height;
}

- (CGFloat)xOriginPlusWidth {
    CGRect frame = self.frame;
    return frame.origin.x + frame.size.width;
}

#pragma mark Beauty

- (CAGradientLayer*)addGradientWithColors:(NSArray*)colors locations:(NSArray*)locations vertical:(BOOL)vertical {
    CAGradientLayer *grad = [CAGradientLayer layer];
    grad.frame = self.bounds;
    grad.locations = locations;
    grad.colors = colors;
    if(! vertical) {
        grad.startPoint = CGPointMake(0, 0.5);
        grad.endPoint = CGPointMake(1, 0.5);
    }
    [self.layer addSublayer:grad];
    return grad;
}

- (void)addBorderWithColor:(UIColor*)color width:(CGFloat)width {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}

- (void)addShadowWithColor:(UIColor*)color offset:(CGSize)offset radius:(CGFloat)radius opacity:(CGFloat)opacity {
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowOpacity = opacity;
    self.layer.shadowRadius = radius;
    self.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
}

#pragma mark Utilities

- (void)resignFirstRespondersRecursively {
    [self resignFirstResponderForSubviewsOfView:self];
}

- (void)resignFirstResponderForSubviewsOfView:(UIView *)aView {
    for (UIView *subview in [aView subviews]) {
        if ([subview isKindOfClass:[UITextField class]] || [subview isKindOfClass:[UITextView class]])
            [(id)subview resignFirstResponder];
        [self resignFirstResponderForSubviewsOfView:subview];
    }
}

- (UIView*)viewFromNibNamed:(NSString*)name {
    NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:name owner:self options:nil];
    return [topLevelObjects objectAtIndex:0];
}
@end
