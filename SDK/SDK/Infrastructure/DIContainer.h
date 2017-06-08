//
//  DIContainer.h
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReportScheduler.h"
#import "FUPCollectorScheduler.h"
#import "FUPConfigApiClient.h"
#import "FUPConfigSyncScheduler.h"
#import "FUPConfigService.h"
#import "ReportApiClient.h"
#import "Configuration.h"
#import "FUPDebugModeStorage.h"

@interface DIContainer : NSObject

+ (FUPCollectorScheduler *)collectorScheduler;
+ (FUPCpuUsageCollector *)cpuUsageCollector;
+ (ReportScheduler *)reportSchedulerWithApiKey:(NSString *)apiKey;
+ (FUPConfigSyncScheduler *)configSyncSchedulerWithApiKey:(NSString *)apiKey;
+ (FUPConfigStorage *)configStorage;
+ (FUPDebugModeStorage *)debugModeStorage;

@end
