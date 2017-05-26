//
//  ReportScheduler.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "ReportScheduler.h"

@implementation ReportScheduler

- (instancetype)initWithDevice:(Device*)device
               reportApiClient:(ReportApiClient *)reportApiClient
{
    self = [super init];
    if (self) {
        _device = device;
        _reportApiClient = reportApiClient;
    }
    return self;
}

- (void)start
{
    [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            float cpuUsage = [[CpuUsageCollector alloc] init].cpuUsage;

            CpuMetric *cpuMetric = [[CpuMetric alloc] initWithTimestamp:0
                                                         appVersionName:@""
                                                              osVersion:@""
                                                  isLowPowerModeEnabled:NO
                                                               cpuUsage:cpuUsage * 100];

            Reports *reports = [self reportsWithCpuMetrics:@[cpuMetric]];

            [self.reportApiClient sendReports:reports completion:^(BOOL success) {}];
        });
    }];
}

- (Reports *)reportsWithCpuMetrics:(NSArray<CpuMetric *> *)cpuMetrics
{
    return [[Reports alloc] initWithAppPackage:self.device.appPackage
                              installationUuid:self.device.installationUuid
                                   deviceModel:self.device.deviceModel
                                 screenDensity:self.device.screenDensity
                                    screenSize:self.device.screenSize
                                 numberOfCores:self.device.numberOfCores
                                    cpuMetrics:cpuMetrics];
}

@end
