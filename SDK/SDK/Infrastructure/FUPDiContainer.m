//
//  FUPDiContainer.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPDiContainer.h"

@implementation FUPDiContainer

+ (FUPCollectorScheduler *)collectorScheduler
{
    return [[FUPCollectorScheduler alloc] init];
}

+ (ReportScheduler *)reportSchedulerWithApiKey:(NSString *)apiKey
{
    return [[ReportScheduler alloc] initWithMetricsStorage:[FUPDiContainer metricsStorage]
                                           reportApiClient:[FUPDiContainer reportApiClientWithApiKey:apiKey]
                                                    device:[FUPDiContainer device]
                                             configService:[FUPDiContainer configServiceWithApiKey:apiKey]
                                                      time:[FUPDiContainer time]];
}

+ (FUPConfigSyncScheduler *)configSyncSchedulerWithApiKey:(NSString *)apiKey
{
    return [[FUPConfigSyncScheduler alloc] initWithConfigService:[FUPDiContainer configServiceWithApiKey:apiKey]
                                                            time:[FUPDiContainer time]];
}

+ (FUPConfigService *)configServiceWithApiKey:(NSString *)apiKey
{
    return [[FUPConfigService alloc] initWithApiClient:[FUPDiContainer configApiClientWithApiKey:apiKey]
                                               storage:[FUPDiContainer configStorage]];
}

+ (FUPCpuUsageCollector *)cpuUsageCollector
{
    return [[FUPCpuUsageCollector alloc] initWithMetricsStorage:[FUPDiContainer metricsStorage]
                                                      device:[FUPDiContainer device]
                                                        time:[FUPDiContainer time]];
}

+ (MetricsStorage *)metricsStorage
{
    static MetricsStorage *_storage;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _storage = [[MetricsStorage alloc] initWithSqlite:[FUPDiContainer sqlite]];
    });

    return _storage;
}

+ (FUPConfigStorage *)configStorage
{
    static FUPConfigStorage *_storage;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _storage = [[FUPConfigStorage alloc] initWithSqlite:[FUPDiContainer sqlite]];
    });

    return _storage;
}

+ (FUPDebugModeStorage *)debugModeStorage
{
    static FUPDebugModeStorage *_storage;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _storage = [[FUPDebugModeStorage alloc] init];
    });

    return _storage;
}

+ (FUPConfigApiClient *)configApiClientWithApiKey:(NSString *)apiKey
{

    NSString *uuid = [FUPDiContainer uuidGenerator].uuid;
    return [[FUPConfigApiClient alloc] initWithBaseUrl:ApiBaseUrl
                                                apiKey:apiKey
                                                  uuid:uuid
                                      debugModeStorage:[FUPDiContainer debugModeStorage]];
}

+ (ReportApiClient *)reportApiClientWithApiKey:(NSString *)apiKey
{
    NSString *uuid = [FUPDiContainer uuidGenerator].uuid;
    return [[ReportApiClient alloc] initWithBaseUrl:ApiBaseUrl
                                             apiKey:apiKey
                                               uuid:uuid
                                   debugModeStorage:[FUPDiContainer debugModeStorage]];
}

+ (FUPDevice *)device
{
    return [[FUPDevice alloc] initWithUuidGenerator:[FUPDiContainer uuidGenerator]];
}

+ (FUPUuidGenerator *)uuidGenerator
{
    return [[FUPUuidGenerator alloc] init];
}

+ (TimeProvider *)time
{
    return [[TimeProvider alloc] init];
}

+ (FUPSqlite *)sqlite
{
    return [[FUPSqlite alloc] initWithFileName:@"flowupdb.sqlite"];
}

@end
