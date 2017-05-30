//
//  Time.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "TimeProvider.h"

@implementation TimeProvider

- (NSTimeInterval)now
{
    return [[NSDate alloc] init].timeIntervalSince1970;
}

- (int64_t)nowInMillis
{
    return MILLIS_IN_ONE_SECOND * [self now];
}

@end
