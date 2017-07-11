//
//  FUPReportScheduler.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPReportScheduler.h"

static NSTimeInterval const NeverReported = -1;
static NSString *const QueueName = @"Report Scheduler Queue";

@interface FUPReportScheduler ()

@property (readonly, nonatomic) FUPMetricsStorage *storage;
@property (readonly, nonatomic) FUPReportApiClient *reportApiClient;
@property (readonly, nonatomic) FUPDevice *device;
@property (readonly, nonatomic) FUPTime *time;
@property (readonly, nonatomic) FUPConfigService *configService;
@property (readonly, nonatomic) FUPReachability *reachability;
@property (readonly, nonatomic) FUPSafetyNet *safetyNet;
@property (readonly, nonatomic) FUPQueueStorage *queueStorage;

@property (readwrite, nonatomic) NSTimeInterval lastReportTimeInterval;

@end

@implementation FUPReportScheduler

- (instancetype)initWithMetricsStorage:(FUPMetricsStorage *)metricsStorage
                       reportApiClient:(FUPReportApiClient *)reportApiClient
                                device:(FUPDevice *)device
                         configService:(FUPConfigService *)configService
                             safetyNet:(FUPSafetyNet *)safetyNet
                          reachability:(FUPReachability *)reachability
                          queueStorage:(FUPQueueStorage *)queueStorage
                                  time:(FUPTime *)time
{
    self = [super init];
    if (self) {
        _storage = metricsStorage;
        _reportApiClient = reportApiClient;
        _device = device;
        _configService = configService;
        _safetyNet = safetyNet;
        _reachability = reachability;
        _time = time;
        _queueStorage = queueStorage;
        _lastReportTimeInterval = NeverReported;
    }
    return self;
}

- (void)start
{
    NSLog(@"[FUPReportScheduler] Start");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ReportSchedulerFirstReportDelayTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self registerToReachabilityChanges];
        [NSTimer scheduledTimerWithTimeInterval:ReportSchedulerReportingTimeInterval repeats:YES block:^(NSTimer *timer) {
            [self reportMetricsSafely];
        }];
    });
}

- (void)registerToReachabilityChanges
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangeReachabilityStatus:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];

    [self.reachability startNotifier];
}

- (void)didChangeReachabilityStatus:(NSNotification *)notification
{
    if ([notification.name isEqualToString:kReachabilityChangedNotification]) {
        [self reportMetricsSafely];
    }
}

- (void)reportMetricsSafely
{
    async([self.queueStorage queueWithName:QueueName], ^{
        [self.safetyNet runBlock:^{
            [self reportMetrics];
        }];
    });
}

- (void)reportMetrics
{
    NSLog(@"[FUPReportScheduler] Report metrics");
    if (!self.configService.enabled) {
        NSLog(@"[FUPReportScheduler] FlowUp is disabled for this device");
        return;
    }

    if (self.lastReportTimeInterval != NeverReported && [self.time now] - self.lastReportTimeInterval < ReportSchedulerTimeBetweenReportsTimeInterval) {
        NSLog(@"[FUPReportScheduler] Did not pass enought time to report");
        return;
    }

    if (!self.storage.hasReports) {
        NSLog(@"[FUPReportScheduler] Do not have any report to send");
        return;
    }

    if ([self.reachability currentReachabilityStatus] != ReachableViaWiFi) {
        NSLog(@"[FUPReportScheduler] Current internet connection is not a WiFi connection");
        return;
    }

    NSArray<FUPMetric *> *metrics = [self.storage metricsAtMost:MaxNumberOfReportsPerRequest];
    FUPReports *reports = [self reportsWithMetrics:metrics];
    [self.reportApiClient sendReports:reports completion:^(FUPApiClientError *error) {
        if (error == nil) {
            NSLog(@"[FUPReportScheduler] Reports successfully sent [%ld]", (long)metrics.count);
            [self removeReportedMetricsCount:metrics.count];
        } else if (error.code == FUPApiClientErrorCodeUnauthorized || error.code == FUPApiClientErrorCodeServerError) {
            NSLog(@"[FUPReportScheduler] There was an error sending the reports: Unauthorized OR Server error");
            [self removeReportedMetricsCount:metrics.count];
            [self disableSdk];
        } else if (error.code == FUPApiClientErrorCodeClientDisabled) {
            NSLog(@"[FUPReportScheduler] There was an error sending the reports: Client Disabled");
            [self.storage clear];
            [self disableSdk];
        } else {
            NSLog(@"[FUPReportScheduler] There was an error sending the reports: Unknown");
        }
    }];
}

- (void)removeReportedMetricsCount:(NSInteger)metricsCount
{
    [self.storage removeNumberOfMetrics:metricsCount];
    self.lastReportTimeInterval = [self.time now];
}

- (void)disableSdk
{
    [self.configService disable];
}

- (FUPReports *)reportsWithMetrics:(NSArray<FUPMetric *> *)metrics
{
    return [[FUPReports alloc] initWithAppPackage:self.device.appPackage
                                 installationUuid:self.device.installationUuid
                                      deviceModel:self.device.deviceModel
                                    screenDensity:self.device.screenDensity
                                       screenSize:self.device.screenSize
                                    numberOfCores:self.device.numberOfCores
                                       cpuMetrics:[self filteredMetrics:metrics byName:@"CPU"]
                                        uiMetrics:[self filteredMetrics:metrics byName:@"UI"]
                                      diskMetrics:[self filteredMetrics:metrics byName:@"Disk"]
                                    memoryMetrics:[self filteredMetrics:metrics byName:@"Memory"]];
}

- (NSArray <FUPMetric *> *)filteredMetrics:(NSArray<FUPMetric *> *)metrics byName:(NSString *)name
{
    return [metrics filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return [((FUPMetric *)evaluatedObject).name isEqualToString:name];
    }]];
}

@end
