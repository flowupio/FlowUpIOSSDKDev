//
//  FUPUiMetric.m
//  SDK
//
//  Created by Sergio Gutiérrez on 08/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPUiMetric.h"

@implementation FUPUiMetric

- (instancetype)initWithTimestamp:(NSTimeInterval)timestamp
                             name:(NSString *)name
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
                        frameTime:(FUPStatisticalValue *)frameTime
{
    self = [super initWithTimestamp:timestamp
                               name:@"UI"
                     appVersionName:appVersionName
                          osVersion:osVersion
              isLowPowerModeEnabled:isLowPowerModeEnabled];
    if (self) {
        _frameTime = frameTime;
    }
    return self;
}

@end
