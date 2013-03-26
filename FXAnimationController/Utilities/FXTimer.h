//
//  FXTimer.h
//  Flexbumin
//
//  Created by Mo Bitar on 3/23/13.
//  Copyright (c) 2013 Ora. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FXTimer : NSObject
@property (nonatomic, readonly) CGFloat currentValue;
- (void)start;
- (void)stop;
@end
