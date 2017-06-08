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
    return [[FUPMetric alloc] initWithTimestamp:1234
                                 appVersionName:@"App Version Name"
                                      osVersion:@"OS Version"
                          isLowPowerModeEnabled:NO
                                       cpuUsage:23];
}

@end
