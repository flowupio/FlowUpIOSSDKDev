//
//  FUPCpuMetricMother.m
//  SDK
//
//  Created by Sergio Gutiérrez on 26/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPCpuMetricMother.h"

@implementation FUPCpuMetricMother

+ (FUPCpuMetric *)any
{
    return [[FUPCpuMetric alloc] initWithTimestamp:1234
                                    appVersionName:@"App Version Name"
                                         osVersion:@"OS Version"
                             isLowPowerModeEnabled:NO
                                          cpuUsage:23];
}

@end
