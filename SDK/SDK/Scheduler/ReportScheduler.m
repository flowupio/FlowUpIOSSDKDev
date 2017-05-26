//
//  ReportScheduler.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "ReportScheduler.h"

static NSTimeInterval const NeverReported = -1;

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
        _lastReportTimeInterval = NeverReported;
    }
    return self;
}

- (void)start
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ReportSchedulerFirstReportDelayTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [NSTimer scheduledTimerWithTimeInterval:ReportSchedulerReportingTimeInterval repeats:YES block:^(NSTimer *timer) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self reportMetrics];
            });
        }];        
    });
}

- (void)reportMetrics
{
    if (self.lastReportTimeInterval != NeverReported && [self.time now] - self.lastReportTimeInterval < ReportSchedulerTimeBetweenReportsTimeInterval) {
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
            self.lastReportTimeInterval = [self.time now];
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
