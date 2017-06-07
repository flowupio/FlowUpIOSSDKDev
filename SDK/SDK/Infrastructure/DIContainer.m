//
//  DIContainer.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "DIContainer.h"

@implementation DIContainer

+ (CollectorScheduler *)collectorScheduler
{
    return [[CollectorScheduler alloc] init];
}

+ (ReportScheduler *)reportSchedulerWithApiKey:(NSString *)apiKey
{
    return [[ReportScheduler alloc] initWithMetricsStorage:[DIContainer metricsStorage]
                                           reportApiClient:[DIContainer reportApiClientWithApiKey:apiKey]
                                                    device:[DIContainer device]
                                             configService:[DIContainer configServiceWithApiKey:apiKey]
                                                      time:[DIContainer time]];
}

+ (FUPConfigSyncScheduler *)configSyncSchedulerWithApiKey:(NSString *)apiKey
{
    return [[FUPConfigSyncScheduler alloc] initWithConfigService:[DIContainer configServiceWithApiKey:apiKey]
                                                            time:[DIContainer time]];
}

+ (FUPConfigService *)configServiceWithApiKey:(NSString *)apiKey
{
    return [[FUPConfigService alloc] initWithApiClient:[DIContainer configApiClientWithApiKey:apiKey]
                                               storage:[DIContainer configStorage]];
}

+ (CpuUsageCollector *)cpuUsageCollector
{
    return [[CpuUsageCollector alloc] initWithMetricsStorage:[DIContainer metricsStorage]
                                                      device:[DIContainer device]
                                                        time:[DIContainer time]];
}

+ (MetricsStorage *)metricsStorage
{
    static MetricsStorage *_storage;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _storage = [[MetricsStorage alloc] initWithSqlite:[DIContainer sqlite]];
    });

    return _storage;
}

+ (FUPConfigStorage *)configStorage
{
    static FUPConfigStorage *_storage;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _storage = [[FUPConfigStorage alloc] initWithSqlite:[DIContainer sqlite]];
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

    NSString *uuid = [DIContainer uuidGenerator].uuid;
    return [[FUPConfigApiClient alloc] initWithBaseUrl:ApiBaseUrl
                                                apiKey:apiKey
                                                  uuid:uuid
                                      debugModeStorage:[DIContainer debugModeStorage]];
}

+ (ReportApiClient *)reportApiClientWithApiKey:(NSString *)apiKey
{
    NSString *uuid = [DIContainer uuidGenerator].uuid;
    return [[ReportApiClient alloc] initWithBaseUrl:ApiBaseUrl
                                             apiKey:apiKey
                                               uuid:uuid
                                   debugModeStorage:[DIContainer debugModeStorage]];
}

+ (Device *)device
{
    return [[Device alloc] initWithUuidGenerator:[DIContainer uuidGenerator]];
}

+ (UuidGenerator *)uuidGenerator
{
    return [[UuidGenerator alloc] init];
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
