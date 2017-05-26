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
@property (readonly, nonatomic) Device *device;
@property (readonly, nonatomic) ReportApiClient *reportApiClient;

@end

@implementation ReportScheduler

- (instancetype)initWithMetricsStorage:(MetricsStorage *)metricsStorage
                                device:(Device*)device
                       reportApiClient:(ReportApiClient *)reportApiClient
{
    self = [super init];
    if (self) {
        _storage = metricsStorage;
        _device = device;
        _reportApiClient = reportApiClient;
    }
    return self;
}

- (void)start
{
    [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer *timer) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSArray<CpuMetric *> *cpuMetrics = [self.storage cpuMetricsAtMost:MaxNumberOfReportsPerRequest];
            Reports *reports = [self reportsWithCpuMetrics:cpuMetrics];
            [self.reportApiClient sendReports:reports completion:^(BOOL success) {
                if (success) {
                    [self.storage removeNumberOfCpuMetrics:cpuMetrics.count];
                } else {
                    NSLog(@"There was an error while reporting metrics");
                }
            }];
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
