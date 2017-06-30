//
//  FUPConfiguration.h
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#ifndef FUPConfiguration_h
#define FUPConfiguration_h

#import "FUPTimeIntervalUnits.h"

static NSTimeInterval const CollectorSchedulerSamplingTimeInterval = 10;
static NSTimeInterval const ConfigSyncSchedulerFirstReportDelayTimeInterval = 5;
static NSTimeInterval const ConfigSyncSchedulerTimeBetweenSyncsTimeInterval = HOURS(6);
static NSTimeInterval const ConfigSyncSchedulerSyncingTimeInterval = MINUTES(5);
static NSTimeInterval const ReportSchedulerFirstReportDelayTimeInterval = 15;
static NSTimeInterval const ReportSchedulerReportingTimeInterval = 15;
static NSTimeInterval const ReportSchedulerTimeBetweenReportsTimeInterval = MINUTES(5);
static NSUInteger const MaxNumberOfReportsPerRequest = 898;
static NSString *const SDKVersion = @"0.0.3";
static NSString *const ApiBaseUrl = @"https://api.flowupapp.com";

#endif /* FUPConfiguration_h */
