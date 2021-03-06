//
//  MBAnimationSequencer
//  Mo Bitar
//
//  Created by Mo Bitar on 3/23/13.
//  Copyright (c) 2013 bitar.io. All rights reserved.
//

#import "MBTimer.h"

@implementation MBTimer {
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
