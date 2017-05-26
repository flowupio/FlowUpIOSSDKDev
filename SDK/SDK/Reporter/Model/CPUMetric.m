//
//  CPUMetric.m
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "CPUMetric.h"

@implementation CPUMetric

- (instancetype)initWithTimestamp:(NSTimeInterval)timestamp
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
                         cpuUsage:(NSInteger)cpuUsage
{
    self = [super initWithTimestamp:timestamp
                     appVersionName:appVersionName
                          osVersion:osVersion
              isLowPowerModeEnabled:isLowPowerModeEnabled];
    if (self) {
        _cpuUsage = cpuUsage;
    }
    return self;
}

@end
