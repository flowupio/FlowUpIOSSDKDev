//
//  Metric.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "Metric.h"

@implementation Metric

- (instancetype)initWithTimestamp:(NSTimeInterval)timestamp
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
{
    self = [super init];
    if (self) {
        _timestamp = timestamp;
        _appVersionName = appVersionName;
        _osVersion = osVersion;
        _isLowPowerModeEnabled = isLowPowerModeEnabled;
    }
    return self;
}

@end