//
//  MBAnimationSequencer
//  Mo Bitar
//
//  Created by Mo Bitar on 3/23/13.
//  Copyright (c) 2013 bitar.io. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MBTimer : NSObject
@property (nonatomic, readonly) CGFloat currentValue;
- (void)start;
- (void)stop;
@end
