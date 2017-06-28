//
//  FlowUp.m
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FlowUp.h"
#import "FUPDiContainer.h"

@implementation FlowUp

static BOOL isInitialized = NO;

+ (void)application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
             apiKey:(NSString *)apiKey
 isDebugModeEnabled:(BOOL)isDebugModeEnabled
{
    if (isInitialized) {
        return;
    }

    [FUPDiContainer debugModeStorage].isDebugModeEnabled = isDebugModeEnabled;

    FUPCollectorScheduler *collectorScheduler = [FUPDiContainer collectorScheduler];
    FUPReportScheduler *reportScheduler = [FUPDiContainer reportSchedulerWithApiKey:apiKey];
    FUPConfigSyncScheduler *configSyncScheduler = [FUPDiContainer configSyncSchedulerWithApiKey:apiKey];
    FUPConfigStorage *configStorage = [FUPDiContainer configStorage];

    [configSyncScheduler start];

    if (!configStorage.config.isEnabled) {
        NSLog(@"FlowUp is disabled for this device");
        return;
    }

    [collectorScheduler addCollectors:@[[FUPDiContainer cpuUsageCollector],
                                        [FUPDiContainer frameTimeCollector],
                                        [FUPDiContainer diskUsageCollector]]
                         timeInterval: CollectorSchedulerSamplingTimeInterval];
    [reportScheduler start];
    isInitialized = YES;
}

@end
