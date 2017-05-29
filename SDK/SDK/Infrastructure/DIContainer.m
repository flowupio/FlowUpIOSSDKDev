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
                                                    config:[DIContainer configWithApiKey:apiKey]
                                                      time:[DIContainer time]];
}

+ (FUPConfigSyncScheduler *)configSyncSchedulerWithApiKey:(NSString *)apiKey
{
    return [[FUPConfigSyncScheduler alloc] initWithConfig:[DIContainer configWithApiKey:apiKey]
                                                     time:[DIContainer time]];
}

+ (FUPFlowUpConfig *)configWithApiKey:(NSString *)apiKey
{
    return [[FUPFlowUpConfig alloc] initWithApiClient:[DIContainer configApiClientWithApiKey:apiKey]
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
        _storage = [[MetricsStorage alloc] init];
    });

    return _storage;
}

+ (FUPConfigStorage *)configStorage
{
    static FUPConfigStorage *_storage;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _storage = [[FUPConfigStorage alloc] init];
    });

    return _storage;
}

+ (FUPConfigApiClient *)configApiClientWithApiKey:(NSString *)apiKey
{

    NSString *uuid = [DIContainer uuidGenerator].uuid;
    return [[FUPConfigApiClient alloc] initWithBaseUrl:ApiBaseUrl
                                                apiKey:apiKey
                                                  uuid:uuid];
}

+ (ReportApiClient *)reportApiClientWithApiKey:(NSString *)apiKey
{
    NSString *uuid = [DIContainer uuidGenerator].uuid;
    return [[ReportApiClient alloc] initWithBaseUrl:ApiBaseUrl
                                             apiKey:apiKey
                                               uuid:uuid];
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

@end
