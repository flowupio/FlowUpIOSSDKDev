//
//  FUPMetric.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPMetric.h"

@implementation FUPMetric

- (instancetype)initWithTimestamp:(NSTimeInterval)timestamp
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
                         cpuUsage:(NSUInteger)cpuUsage
{
    return [self initWithTimestamp:timestamp
                              name:@"CPU"
                    appVersionName:appVersionName
                         osVersion:osVersion
             isLowPowerModeEnabled:isLowPowerModeEnabled
                            values:@{@"consumption": [NSNumber numberWithUnsignedInteger:cpuUsage]}];
}

- (instancetype)initWithTimestamp:(NSTimeInterval)timestamp
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
                        frameTime:(FUPStatisticalValue *)frameTime
{
    return [self initWithTimestamp:timestamp
                              name:@"UI"
                    appVersionName:appVersionName
                         osVersion:osVersion
             isLowPowerModeEnabled:isLowPowerModeEnabled
                            values:@{@"frameTime": @{
                                             @"mean": frameTime.mean,
                                             @"p10": frameTime.percentile10,
                                             @"p90": frameTime.percentile90}}];
}

- (instancetype)initWithTimestamp:(NSTimeInterval)timestamp
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
                 diskUsageInBytes:(NSUInteger)diskUsageInBytes
          userDefaultsSizeInBytes:(NSUInteger)userDefaultsSizeInBytes
{
    return [self initWithTimestamp:timestamp
                              name:@"Disk"
                    appVersionName:appVersionName
                         osVersion:osVersion
             isLowPowerModeEnabled:isLowPowerModeEnabled
                            values:@{@"internalStorageWrittenBytes": [NSNumber numberWithUnsignedInteger:diskUsageInBytes],
                                     @"userDefaultsWrittenBytes": [NSNumber numberWithUnsignedInteger:userDefaultsSizeInBytes]}];
}

- (instancetype)initWithTimestamp:(NSTimeInterval)timestamp
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
               memoryUsageInBytes:(unsigned long long)memoryUsageInBytes
             memoryUsageInPercent:(NSUInteger)memoryUsageInPercent
{
    return [self initWithTimestamp:timestamp
                              name:@"Memory"
                    appVersionName:appVersionName
                         osVersion:osVersion
             isLowPowerModeEnabled:isLowPowerModeEnabled
                            values:@{@"bytesAllocated": [NSNumber numberWithUnsignedLongLong:memoryUsageInBytes],
                                     @"consumption": [NSNumber numberWithUnsignedInteger:memoryUsageInPercent]}];
}

- (instancetype)initWithTimestamp:(NSTimeInterval)timestamp
                             name:(NSString *)name
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
                           values:(NSDictionary *)values
{
    self = [super init];
    if (self) {
        _timestamp = timestamp;
        _name = name;
        _appVersionName = appVersionName;
        _osVersion = osVersion;
        _isLowPowerModeEnabled = isLowPowerModeEnabled;
        _values = values;
    }
    return self;
}

@end
