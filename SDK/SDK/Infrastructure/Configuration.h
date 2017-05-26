//
//  Configuration.h
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#ifndef Configuration_h
#define Configuration_h

#import "TimeIntervalUnits.h"

static NSTimeInterval SamplingTimeInterval = 10;
static NSTimeInterval ReportSchedulerFirstReportDelayTimeInterval = 15;
static NSTimeInterval ReportSchedulerReportingTimeInterval = 15;
static NSTimeInterval ReportSchedulerTimeBetweenReportsTimeInterval = MINUTES(5);
static NSUInteger MaxNumberOfReportsPerRequest = 898;
static NSString *const SDKVersion = @"0.0.1";
static NSString *const ApiBaseUrl = @"https://api.flowupapp.com";

#endif /* Configuration_h */
