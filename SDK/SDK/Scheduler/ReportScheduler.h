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
                       reportApiClient:(ReportApiClient *)reportApiClient
                                device:(Device *)device
                                  time:(TimeProvider *)time
          firstReportDelayTimeInterval:(NSTimeInterval)firstReportDelayTimeInterval
                 reportingTimeInterval:(NSTimeInterval) reportingTimeInterval;

- (void)start;
- (void)reportMetrics;

@end
