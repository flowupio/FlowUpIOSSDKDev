//
//  ReportScheduler.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "ReportScheduler.h"

@interface ReportScheduler ()

@property (readonly, nonatomic) MetricsStorage *storage;
@property (readonly, nonatomic) ReportApiClient *reportApiClient;
@property (readonly, nonatomic) Device *device;
@property (readonly, nonatomic) TimeProvider *time;
@property (readwrite, nonatomic) NSTimeInterval lastReportTimeInterval;

@end

@implementation ReportScheduler

- (instancetype)initWithMetricsStorage:(MetricsStorage *)metricsStorage
                       reportApiClient:(ReportApiClient *)reportApiClient
                                device:(Device *)device
                                  time:(TimeProvider *)time

{
    self = [super init];
    if (self) {
        _storage = metricsStorage;
        _device = device;
        _time = time;
        _reportApiClient = reportApiClient;
        _lastReportTimeInterval = 0;
    }
    return self;
}

- (void)start
{
    [NSTimer scheduledTimerWithTimeInterval:ReportSchedulerReportingTimeInterval repeats:YES block:^(NSTimer *timer) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self reportMetrics];
        });
    }];
}

- (void)reportMetrics
{
    if ([self.time now] - self.lastReportTimeInterval < ReportSchedulerTimeBetweenReportsTimeInterval) {
        return;
    }

    if (!self.storage.hasReports) {
        return;
    }

    NSArray<CpuMetric *> *cpuMetrics = [self.storage cpuMetricsAtMost:MaxNumberOfReportsPerRequest];
    Reports *reports = [self reportsWithCpuMetrics:cpuMetrics];
    [self.reportApiClient sendReports:reports completion:^(BOOL success) {
        if (success) {
            [self.storage removeNumberOfCpuMetrics:cpuMetrics.count];
        } else {
            NSLog(@"There was an error while reporting metrics");
        }
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
