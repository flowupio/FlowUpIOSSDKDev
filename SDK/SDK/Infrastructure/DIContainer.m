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
    static CollectorScheduler *_scheduler;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _scheduler = [[CollectorScheduler alloc] init];
    });

    return _scheduler;
}

+ (ReportScheduler *)reportSchedulerWithApiKey:(NSString *)apiKey
{
    static ReportScheduler *_scheduler;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _scheduler = [[ReportScheduler alloc] initWithMetricsStorage:[DIContainer metricsStorage]
                                                     reportApiClient:[DIContainer reportApiClientWithApiKey:apiKey]
                                                              device:[DIContainer device]
                                                                time:[DIContainer time]];
    });

    return _scheduler;
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

+ (FUPConfigApiClient *)configApiClientWithApiKey:(NSString *)apiKey
{
    static FUPConfigApiClient *_apiClient;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        NSString *uuid = [DIContainer uuidGenerator].uuid;
        _apiClient = [[FUPConfigApiClient alloc] initWithBaseUrl:ApiBaseUrl
                                                       apiKey:apiKey
                                                         uuid:uuid];
    });

    return _apiClient;
}

+ (ReportApiClient *)reportApiClientWithApiKey:(NSString *)apiKey
{
    static ReportApiClient *_apiClient;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        NSString *uuid = [DIContainer uuidGenerator].uuid;
        _apiClient = [[ReportApiClient alloc] initWithBaseUrl:ApiBaseUrl
                                                       apiKey:apiKey
                                                         uuid:uuid];
    });

    return _apiClient;
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
