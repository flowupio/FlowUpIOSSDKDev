//
//  FUPDiContainer.h
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPReportScheduler.h"
#import "FUPCollectorScheduler.h"
#import "FUPConfigApiClient.h"
#import "FUPConfigSyncScheduler.h"
#import "FUPConfigService.h"
#import "FUPReportApiClient.h"
#import "FUPConfiguration.h"
#import "FUPDebugModeStorage.h"
#import "FUPFrameTimeCollector.h"

@interface FUPDiContainer : NSObject

+ (FUPCollectorScheduler *)collectorScheduler;
+ (FUPCpuUsageCollector *)cpuUsageCollector;
+ (FUPFrameTimeCollector *)frameTimeCollector;
+ (FUPReportScheduler *)reportSchedulerWithApiKey:(NSString *)apiKey;
+ (FUPConfigSyncScheduler *)configSyncSchedulerWithApiKey:(NSString *)apiKey;
+ (FUPConfigStorage *)configStorage;
+ (FUPDebugModeStorage *)debugModeStorage;

@end
