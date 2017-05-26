//
//  ReportSchedulerTests.m
//  SDK
//
//  Created by Sergio Gutiérrez on 26/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ReportScheduler.h"
#import "CpuMetricMother.h"
#import <Nimble/Nimble.h>
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>
@import Nimble.Swift;

static NSTimeInterval const Now = 123;
static NSTimeInterval const RightAfterNow = Now + 1;
static NSTimeInterval const LongTimeSinceNow = Now + ReportSchedulerTimeBetweenReportsTimeInterval + 1;

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

- (void)testScheduler_WontReport_IfNoMetrics
{
    [self.scheduler start];

    [verifyCount(self.apiClient, never()) sendReports:anything() completion:anything()];
}

- (void)testScheduler_WontReport_IfNotEnoughTimeSinceLastReport
{
    [self.storage storeCpuMetric:[CpuMetricMother any]];
    [self.scheduler start];
    [self.storage storeCpuMetric:[CpuMetricMother any]];
    [self givenNotEnoughTimePassedToReport];
    [self.scheduler start];

    [verifyCount(self.apiClient, times(1)) sendReports:anything() completion:anything()];
}

- (void)testScheduler_Reports_IfItsTheFirstTime
{
    [self.storage storeCpuMetric:[CpuMetricMother any]];

    [self.scheduler start];

    [verify(self.apiClient) sendReports:anything() completion:anything()];
}

- (void)testScheduler_Reports_IfThereAreMetricsAndHasPassedEnoughTimeSinceLastReport
{
    [self.storage storeCpuMetric:[CpuMetricMother any]];
    [self.scheduler start];
    [self.storage storeCpuMetric:[CpuMetricMother any]];
    [self givenEnoughTimePassedToReport];
    [self.scheduler start];

    [verifyCount(self.apiClient, times(2)) sendReports:anything() completion:anything()];
}

- (void)testScheduler_RemovesMetrics_IfTheyHaveBeenSuccessfullyReported
{
    [self.storage storeCpuMetric:[CpuMetricMother any]];

    [self.scheduler start];

    expect(self.storage.hasReports).to(equal(NO));
}

- (void)givenNotEnoughTimePassedToReport
{
    [given([self.time now]) willReturnInt: RightAfterNow];
}

- (void)givenEnoughTimePassedToReport
{
    [given([self.time now]) willReturnInt: LongTimeSinceNow];
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
    TimeProvider *timeProvider = mock([TimeProvider class]);
    [given([timeProvider now]) willReturnInt: Now];
    return timeProvider;
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

