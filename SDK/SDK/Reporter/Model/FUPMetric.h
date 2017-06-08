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
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
                         cpuUsage:(NSInteger)cpuUsage;

- (instancetype)initWithTimestamp:(NSTimeInterval)timestamp
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
                        frameTime:(FUPStatisticalValue *)frameTime;

@end
