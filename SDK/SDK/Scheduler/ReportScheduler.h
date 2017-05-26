//
//  ReportScheduler.h
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Device.h"
#import "ReportApiClient.h"
#import "CpuUsageCollector.h"
#import "TimeProvider.h"
#import "MetricsStorage.h"

@interface ReportScheduler : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithMetricsStorage:(MetricsStorage *)metricsStorage
                                device:(Device*)device
                       reportApiClient:(ReportApiClient *)reportApiClient;

- (void)start;

@end
