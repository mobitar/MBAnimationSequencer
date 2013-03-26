//
//  FXTimer.m
//  Flexbumin
//
//  Created by Mo Bitar on 3/23/13.
//  Copyright (c) 2013 Ora. All rights reserved.
//

#import "FXTimer.h"

@implementation FXTimer {
    NSDate *startDate;
}
@synthesize currentValue = _currentValue;

- (void)start {
   startDate = [NSDate date];
}

- (CGFloat)currentValue {
    return [[NSDate date] timeIntervalSinceDate:startDate];
}

- (void)stop {
    startDate = nil;
}
@end
