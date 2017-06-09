//
//  FUPDiskUsageCollector.h
//  SDK
//
//  Created by Sergio Gutiérrez on 09/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPCollector.h"
#import "FUPMetric.h"
#import "FUPMetricsStorage.h"
#import "FUPDevice.h"
#import "FUPTime.h"

@interface FUPDiskUsageCollector : NSObject <FUPCollector>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithMetricsStorage:(FUPMetricsStorage *)metricsStorage
                                device:(FUPDevice *)device
                                  time:(FUPTime *)time;

@end
