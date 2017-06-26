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

+ (FUPReportScheduler *)reportSchedulerWithApiKey:(NSString *)apiKey
{
    return [[FUPReportScheduler alloc] initWithMetricsStorage:[FUPDiContainer metricsStorage]
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

+ (FUPSafetyNet *)safetyNetWithApiKey:(NSString *)apiKey
{
    return [[FUPSafetyNet alloc] initWithCrashReporterApiClient:[FUPDiContainer crashReporterApiClientWithApiKey:apiKey]];
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
                                             debugModeStorage:[FUPDiContainer debugModeStorage]
                                                       device:[FUPDiContainer device]];
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
    return [[FUPSqlite alloc] initWithFileName:@"flowupdb.sqlite"];
}

@end
