//
//  FlowUp.m
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FlowUp.h"
#import "DIContainer.h"

#ifdef DEBUG
#   define NSLog(...) NSLog(__VA_ARGS__)
#else
#   define NSLog(...) (void)0
#endif

@implementation FlowUp

+ (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions apiKey:(NSString *)apiKey
{
    CollectorScheduler *collectorScheduler = [DIContainer collectorScheduler];
    ReportScheduler *reportScheduler = [DIContainer reportSchedulerWithApiKey:apiKey];
    FUPConfigSyncScheduler *configSyncScheduler = [DIContainer configSyncSchedulerWithApiKey:apiKey];
    FUPConfigStorage *configStorage = [DIContainer configStorage];


    [configSyncScheduler start];

    if (!configStorage.config.isEnabled) {
        NSLog(@"FlowUp is disabled for this device");
        return;
    }

    [collectorScheduler addCollectors:@[[DIContainer cpuUsageCollector]]
                         timeInterval: CollectorSchedulerSamplingTimeInterval];
    [reportScheduler start];
}

@end
