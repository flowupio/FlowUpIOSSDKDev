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
                             name:(NSString *)name
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
{
    self = [super init];
    if (self) {
        _timestamp = timestamp;
        _name = name;
        _appVersionName = appVersionName;
        _osVersion = osVersion;
        _isLowPowerModeEnabled = isLowPowerModeEnabled;
    }
    return self;
}

@end
