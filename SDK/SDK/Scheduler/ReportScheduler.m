//
//  ReportScheduler.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "ReportScheduler.h"

@interface ReportScheduler ()

@property (readonly, nonatomic) Device *device;
@property (readonly, nonatomic) ReportApiClient *reportApiClient;
@property (readonly, nonatomic) TimeProvider *time;

@end

@implementation ReportScheduler

- (instancetype)initWithDevice:(Device*)device
               reportApiClient:(ReportApiClient *)reportApiClient
                          time:(TimeProvider *)time
{
    self = [super init];
    if (self) {
        _device = device;
        _reportApiClient = reportApiClient;
        _time = time;
    }
    return self;
}

- (void)start
{
    [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer *timer) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            CpuMetric *cpuMetric = [self cpuMetric];
//            Reports *reports = [self reportsWithCpuMetrics:@[cpuMetric]];
//
//            [self.reportApiClient sendReports:reports completion:^(BOOL success) {}];
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
