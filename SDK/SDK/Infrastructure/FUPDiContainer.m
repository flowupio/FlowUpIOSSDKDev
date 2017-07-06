//
//  FUPDiContainer.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPDiContainer.h"

@implementation FUPDiContainer

+ (FUPCollectorScheduler *)collectorSchedulerWithApiKey:(NSString *)apiKey
{
    return [[FUPCollectorScheduler alloc] initWithSafetyNet:[FUPDiContainer safetyNetWithApiKey:apiKey]
                                              configService:[FUPDiContainer configServiceWithApiKey:apiKey]
                                               queueStorage:[FUPDiContainer queueStorage]];
}

+ (FUPReportScheduler *)reportSchedulerWithApiKey:(NSString *)apiKey
{
    return [[FUPReportScheduler alloc] initWithMetricsStorage:[FUPDiContainer metricsStorage]
                                              reportApiClient:[FUPDiContainer reportApiClientWithApiKey:apiKey]
                                                       device:[FUPDiContainer device]
                                                configService:[FUPDiContainer configServiceWithApiKey:apiKey]
                                                    safetyNet:[FUPDiContainer safetyNetWithApiKey:apiKey]
                                                 reachability:[FUPDiContainer reachability]
                                                 queueStorage:[FUPDiContainer queueStorage]
                                                         time:[FUPDiContainer time]];
}

+ (FUPConfigSyncScheduler *)configSyncSchedulerWithApiKey:(NSString *)apiKey
{
    return [[FUPConfigSyncScheduler alloc] initWithConfigService:[FUPDiContainer configServiceWithApiKey:apiKey]
                                                       safetyNet:[FUPDiContainer safetyNetWithApiKey:apiKey]
                                                            time:[FUPDiContainer time]];
}

+ (FUPConfigService *)configServiceWithApiKey:(NSString *)apiKey
{
    return [[FUPConfigService alloc] initWithApiClient:[FUPDiContainer configApiClientWithApiKey:apiKey]
                                               storage:[FUPDiContainer configStorage]];
}

+ (FUPSafetyNet *)safetyNetWithApiKey:(NSString *)apiKey
{
    return [[FUPSafetyNet alloc] initWithCrashReporterApiClient:[FUPDiContainer crashReporterApiClientWithApiKey:apiKey]
                                                         device:[FUPDiContainer device]];
}

+ (FUPCpuUsageCollector *)cpuUsageCollector
{
    return [[FUPCpuUsageCollector alloc] initWithMetricsStorage:[FUPDiContainer metricsStorage]
                                                         device:[FUPDiContainer device]
                                                           time:[FUPDiContainer time]];
}

+ (FUPFrameTimeCollector *)frameTimeCollector
{
    return [[FUPFrameTimeCollector alloc] initWithMetricsStorage:[FUPDiContainer metricsStorage]
                                                          device:[FUPDiContainer device]
                                                            time:[FUPDiContainer time]
                                                      calculator:[FUPDiContainer calculator]];
}

+ (FUPDiskUsageCollector *)diskUsageCollector
{
    return [[FUPDiskUsageCollector alloc] initWithMetricsStorage:[FUPDiContainer metricsStorage]
                                                          device:[FUPDiContainer device]
                                                            time:[FUPDiContainer time]];
}

+ (FUPMetricsStorage *)metricsStorage
{
    static FUPMetricsStorage *_storage;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _storage = [[FUPMetricsStorage alloc] initWithSqlite:[FUPDiContainer sqlite]
                                                      mapper:[FUPDiContainer metricsStorageMapper]];
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

+ (FUPCrashReporterApiClient *)crashReporterApiClientWithApiKey:(NSString *)apiKey
{

    NSString *uuid = [FUPDiContainer uuidGenerator].uuid;
    return [[FUPCrashReporterApiClient alloc] initWithBaseUrl:ApiBaseUrl
                                                       apiKey:apiKey
                                                         uuid:uuid
                                             debugModeStorage:[FUPDiContainer debugModeStorage]];
}

+ (FUPReportApiClient *)reportApiClientWithApiKey:(NSString *)apiKey
{
    NSString *uuid = [FUPDiContainer uuidGenerator].uuid;
    return [[FUPReportApiClient alloc] initWithBaseUrl:ApiBaseUrl
                                                apiKey:apiKey
                                                  uuid:uuid
                                      debugModeStorage:[FUPDiContainer debugModeStorage]];
}

+ (FUPMetricsStorageMapper *)metricsStorageMapper
{
    return [[FUPMetricsStorageMapper alloc] init];
}

+ (FUPReachability *)reachability
{
    return [FUPReachability reachabilityForInternetConnection];
}

+ (FUPQueueStorage *)queueStorage
{
    static FUPQueueStorage *_storage;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _storage = [[FUPQueueStorage alloc] init];
    });

    return _storage;
}

+ (FUPDevice *)device
{
    return [[FUPDevice alloc] initWithUuidGenerator:[FUPDiContainer uuidGenerator]];
}

+ (FUPUuidGenerator *)uuidGenerator
{
    return [[FUPUuidGenerator alloc] init];
}

+ (FUPTime *)time
{
    return [[FUPTime alloc] init];
}

+ (FUPCalculator *)calculator
{
    return [[FUPCalculator alloc] init];
}

+ (FUPSqlite *)sqlite
{
    return [[FUPSqlite alloc] initWithFileName:@"flowupdb.sqlite"
                                  queueStorage:[FUPDiContainer queueStorage]];
}

@end
