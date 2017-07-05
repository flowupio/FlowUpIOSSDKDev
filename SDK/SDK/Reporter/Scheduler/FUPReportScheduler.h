//
//  FUPReportScheduler.h
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPDevice.h"
#import "FUPReportApiClient.h"
#import "FUPCpuUsageCollector.h"
#import "FUPConfigService.h"
#import "FUPTime.h"
#import "FUPMetricsStorage.h"
#import "FUPSafetyNet.h"
#import "FUPReachability.h"

@interface FUPReportScheduler : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithMetricsStorage:(FUPMetricsStorage *)metricsStorage
                       reportApiClient:(FUPReportApiClient *)reportApiClient
                                device:(FUPDevice *)device
                         configService:(FUPConfigService *)configService
                             safetyNet:(FUPSafetyNet *)safetyNet
                                  time:(FUPTime *)time;

- (void)start;
- (void)reportMetrics;

@end
