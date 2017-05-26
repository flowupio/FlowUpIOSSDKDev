//
//  CPUMetric.h
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Metric.h"

@interface CPUMetric : Metric

@property (readonly, nonatomic) NSInteger cpuUsage;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTimestamp:(NSTimeInterval)timestamp
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
                         cpuUsage:(NSInteger)cpuUsage;

@end
