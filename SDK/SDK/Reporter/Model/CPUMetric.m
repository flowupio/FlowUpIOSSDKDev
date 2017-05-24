//
//  CPUMetric.m
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "CPUMetric.h"

@implementation CPUMetric

- (instancetype)initWithCpuUsage:(NSInteger)cpuUsage
{
    self = [super init];
    if (self) {
        _cpuUsage = cpuUsage;
    }
    return self;
}

@end
