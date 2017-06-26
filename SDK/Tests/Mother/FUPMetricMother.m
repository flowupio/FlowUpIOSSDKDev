//
//  FUPMetricMother.m
//  SDK
//
//  Created by Sergio Gutiérrez on 26/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPMetricMother.h"

@implementation FUPMetricMother

+ (FUPMetric *)any
{
    return [FUPMetricMother anyCpu];
}

+ (FUPMetric *)anyCpu
{
    return [FUPMetricMother anyCpuWithCpuUsage:10];
}

+ (FUPMetric *)anyCpuWithCpuUsage:(NSInteger)cpuUsage
{
    return [[FUPMetric alloc] initWithTimestamp:1234
                                 appVersionName:@"App Version Name"
                                      osVersion:@"OS Version"
                          isLowPowerModeEnabled:NO
                                       cpuUsage:cpuUsage];
}

+ (FUPMetric *)anyUi
{
    FUPStatisticalValue *frameTime = [[FUPStatisticalValue alloc] initWithMean:[NSNumber numberWithDouble:1.0]
                                                                  percentile10:[NSNumber numberWithDouble:0.5]
                                                                  percentile90:[NSNumber numberWithDouble:1.9]];
    return [[FUPMetric alloc] initWithTimestamp:1234
                                 appVersionName:@"App Version Name"
                                      osVersion:@"OS Version"
                          isLowPowerModeEnabled:NO
                                       frameTime:frameTime];
}

@end
