//
//  FlowUp.m
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FlowUp.h"
#import "DIContainer.h"

@implementation FlowUp

+ (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions apiKey:(NSString *)apiKey
{
    FUPConfigApiClient *apiClient = [DIContainer configApiClientWithApiKey:apiKey];
    [apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *result) {

    }];
//    CollectorScheduler *collectorScheduler = [DIContainer collectorScheduler];
//    ReportScheduler *reportScheduler = [DIContainer reportSchedulerWithApiKey:apiKey];
//
//
//    [collectorScheduler addCollectors:@[[DIContainer cpuUsageCollector]]
//                         timeInterval: SamplingTimeInterval];
//
//    [reportScheduler start];
}

@end
