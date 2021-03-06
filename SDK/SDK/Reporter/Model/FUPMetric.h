//
//  FUPMetric.h
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPStatisticalValue.h"

@interface FUPMetric : NSObject

@property (readonly, nonatomic) NSTimeInterval timestamp;
@property (readonly, nonatomic, copy) NSString *name;
@property (readonly, nonatomic, copy) NSString *appVersionName;
@property (readonly, nonatomic, copy) NSString *osVersion;
@property (readonly, nonatomic) BOOL isLowPowerModeEnabled;
@property (readonly, nonatomic) NSDictionary *values;

- (instancetype)init NS_UNAVAILABLE;

- (instancetype)initWithTimestamp:(NSTimeInterval)timestamp
                             name:(NSString *)name
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
                           values:(NSDictionary *)values;

- (instancetype)initWithTimestamp:(NSTimeInterval)timestamp
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
                         cpuUsage:(NSUInteger)cpuUsage;

- (instancetype)initWithTimestamp:(NSTimeInterval)timestamp
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
                        frameTime:(FUPStatisticalValue *)frameTime;

- (instancetype)initWithTimestamp:(NSTimeInterval)timestamp
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
                 diskUsageInBytes:(NSUInteger)diskUsageInBytes
          userDefaultsSizeInBytes:(NSUInteger)userDefaultsSizeInBytes;

- (instancetype)initWithTimestamp:(NSTimeInterval)timestamp
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
               memoryUsageInBytes:(unsigned long long)memoryUsageInBytes
             memoryUsageInPercent:(NSUInteger)memoryUsageInPercent;

@end
