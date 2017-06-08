//
//  FUPUiMetric.h
//  SDK
//
//  Created by Sergio Gutiérrez on 08/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPMetric.h"
#import "FUPStatisticalValue.h"

@interface FUPUiMetric : FUPMetric

@property (readonly, nonatomic) FUPStatisticalValue *frameTime;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTimestamp:(NSTimeInterval)timestamp
                             name:(NSString *)name
                   appVersionName:(NSString *)appVersionName
                        osVersion:(NSString *)osVersion
            isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
                        frameTime:(FUPStatisticalValue *)frameTime;

@end
