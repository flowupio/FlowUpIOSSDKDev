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
    return [FUPMetricMother anyUiWithMeanFrameTime:1.0 p10FrameTime:0.5 p90FrameTime:1.9];
}

+ (FUPMetric *)anyUiWithMeanFrameTime:(double)meanFrameTime
                         p10FrameTime:(double)p10FrameTime
                         p90FrameTime:(double)p90FrameTime
{
    FUPStatisticalValue *frameTime = [[FUPStatisticalValue alloc] initWithMean:[NSNumber numberWithDouble:meanFrameTime]
                                                                  percentile10:[NSNumber numberWithDouble:p10FrameTime]
                                                                  percentile90:[NSNumber numberWithDouble:p90FrameTime]];
    return [[FUPMetric alloc] initWithTimestamp:1234
                                 appVersionName:@"App Version Name"
                                      osVersion:@"OS Version"
                          isLowPowerModeEnabled:NO
                                      frameTime:frameTime];
}

+ (FUPMetric *)anyDisk
{
    return [FUPMetricMother anyDiskWithDiskUsageInBytes:1000 userDefaultsSizeInBytes:2000];
}

+ (FUPMetric *)anyDiskWithDiskUsageInBytes:(NSUInteger)diskUsageInBytes
                   userDefaultsSizeInBytes:(NSUInteger)userDefaultsSizeInBytes
{
    return [[FUPMetric alloc] initWithTimestamp:1234
                                 appVersionName:@"App Version Name"
                                      osVersion:@"OS Version"
                          isLowPowerModeEnabled:NO
                               diskUsageInBytes:diskUsageInBytes
                        userDefaultsSizeInBytes:userDefaultsSizeInBytes];
}

@end
