//
//  ReportSchedulerTests.m
//  SDK
//
//  Created by Sergio Gutiérrez on 26/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ReportScheduler.h"
#import "ApiClientTests.h"
#import "Configuration.h"
@import Nimble;
@import Nocilla;
@import OCMockito;

@interface ReportSchedulerTests : XCTestCase

@property (readwrite, nonatomic) MetricsStorage *storage;
@property (readwrite, nonatomic) ReportScheduler *scheduler;
@property (readwrite, nonatomic) ReportApiClient *apiClient;
@property (readwrite, nonatomic) Device *device;
@property (readwrite, nonatomic) TimeProvider *time;

@end

@implementation ReportSchedulerTests

- (void)setUp {
    [super setUp];
    self.apiClient = [self reportApiClient];
    self.storage = [self metricsStorage];
    self.device = [self device];
    self.apiClient = [self reportApiClient];
    self.scheduler = [self reportScheduler];
}

- (MetricsStorage *)metricsStorage
{
    return [[MetricsStorage alloc] init];
}

- (ReportApiClient *)reportApiClient
{
    return mock([ReportApiClient class]);
}

- (Device *)device
{
    return mock([Device class]);
}

- (TimeProvider *)timeProvider
{
    return mock([TimeProvider class]);
}

- (ReportScheduler *)reportScheduler
{
    return [[ReportScheduler alloc] initWithMetricsStorage:self.storage
                                           reportApiClient:self.apiClient
                                                    device:self.device
                                                      time:self.time
                              firstReportDelayTimeInterval:0
                                     reportingTimeInterval:0];
}

@end

