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

static BOOL isInitialized = NO;

+ (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions apiKey:(NSString *)apiKey
{
    if (isInitialized) {
        return;
    }

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
    isInitialized = YES;
}

@end
