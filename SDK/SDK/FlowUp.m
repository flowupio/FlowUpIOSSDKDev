//
//  FlowUp.m
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FlowUp.h"
#import "CPUUsageCollector.h"
#import "ReportApiClient.h"
#import "AFNetworking.h"
#import "AFNetworkActivityLogger.h"

@interface FlowUp ()

+ (CPUUsageCollector *)cpuUsageCollector;
+ (ReportApiClient *)reportApiClient;

@end

@implementation FlowUp

+ (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            float cpuUsage = FlowUp.cpuUsageCollector.cpuUsage;

            CPUMetric *cpuMetric = [[CPUMetric alloc] initWithTimestamp:0
                                                         appVersionName:@""
                                                              osVersion:@""
                                                  isLowPowerModeEnabled:NO
                                                               cpuUsage:cpuUsage * 100];

            Reports *reports = [[Reports alloc] initWithAppPackage:@""
                                                  installationUuid:@""
                                                       deviceModel:@""
                                                     screenDensity:@""
                                                        screenSize:@""
                                                     numberOfCores:4
                                                        cpuMetrics:@[cpuMetric]];

            [FlowUp.reportApiClient sendReports:reports completion:^(BOOL success) {}];
        });
    }];
}

#pragma mark - Properties

+ (CPUUsageCollector *)cpuUsageCollector
{
    static CPUUsageCollector *_collector;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _collector = [[CPUUsageCollector alloc] init];
    });

    return _collector;
}

+ (ReportApiClient *)reportApiClient
{
    static ReportApiClient *_apiClient;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _apiClient = [[ReportApiClient alloc] initWithBaseUrl:@"https://api.flowupapp.com"];
    });
    
    return _apiClient;
}

@end
