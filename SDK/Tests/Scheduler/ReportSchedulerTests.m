//
//  ReportSchedulerTests.m
//  SDK
//
//  Created by Sergio Gutiérrez on 26/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TestAsync.h"
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
@property (readwrite, nonatomic) FUPFlowUpConfig *config;
@property (readwrite, nonatomic) TimeProvider *time;

@end

@implementation ReportSchedulerTests

- (void)setUp {
    [super setUp];
    self.apiClient = mock([ReportApiClient class]);
    self.storage = [[MetricsStorage alloc] init];
    self.device = mock([Device class]);
    self.config = mock([FUPFlowUpConfig class]);
    self.time = mock([TimeProvider class]);
    self.scheduler = [self reportScheduler];

    [self.storage removeNumberOfCpuMetrics:1000];
    [self givenSdkIsEnabled];
    [self givenWeAreNow];
}

- (void)testScheduler_WontReport_IfNoMetrics
{
    [self givenApiClientReportsSuccessfully];
    [self.scheduler reportMetrics];

    [verifyCount(self.apiClient, never()) sendReports:anything() completion:anything()];
}

- (void)testScheduler_WontReport_IfSdkIsDisabled
{
    [self givenSdkIsDisabled];
    [self givenApiClientReportsSuccessfully];
    [self.scheduler reportMetrics];

    [verifyCount(self.apiClient, never()) sendReports:anything() completion:anything()];
}

- (void)testScheduler_WontReport_IfNotEnoughTimeSinceLastReport
{
    [self givenNotEnoughTimePassedToReportTheSecondTime];
    [self givenApiClientReportsSuccessfully];
    [self.storage storeCpuMetric:[CpuMetricMother any]];
    [self.scheduler reportMetrics];
    [self.storage storeCpuMetric:[CpuMetricMother any]];

    [self.scheduler reportMetrics];

    [verifyCount(self.apiClient, times(1)) sendReports:anything() completion:anything()];
}

- (void)testScheduler_Reports_IfItsTheFirstTime
{
    [self givenApiClientReportsSuccessfully];
    [self.storage storeCpuMetric:[CpuMetricMother any]];

    [self.scheduler reportMetrics];

    [verify(self.apiClient) sendReports:anything() completion:anything()];
}

- (void)testScheduler_Reports_IfThereAreMetricsAndHasPassedEnoughTimeSinceLastReport
{
    [self givenEnoughTimePassedToReportTheSecondTime];
    [self givenApiClientReportsSuccessfully];
    [self.storage storeCpuMetric:[CpuMetricMother any]];
    [self.scheduler reportMetrics];
    [self.storage storeCpuMetric:[CpuMetricMother any]];

    [self.scheduler reportMetrics];

    [verifyCount(self.apiClient, times(2)) sendReports:anything() completion:anything()];
}

- (void)testScheduler_RemovesMetrics_IfTheyHaveBeenSuccessfullyReported
{
    [self givenApiClientReportsSuccessfully];
    [self.storage storeCpuMetric:[CpuMetricMother any]];

    [self.scheduler reportMetrics];

    expect(self.storage.hasReports).to(equal(NO));
}

- (void)testScheduler_DontRemoveMetrics_IfThereWasAnErrorReporting
{
    [self givenApiClientReportsAnError];
    [self.storage storeCpuMetric:[CpuMetricMother any]];

    [self.scheduler reportMetrics];

    expect(self.storage.hasReports).to(equal(YES));
}

- (void)givenApiClientReportsSuccessfully
{
    [self givenApiClientReports:YES];
}

- (void)givenApiClientReportsAnError
{
    [self givenApiClientReports:NO];
}

- (void)givenApiClientReports:(BOOL)success
{
    [givenVoid([self.apiClient sendReports:anything() completion:anything()]) willDo:^id (NSInvocation *invocation){
        NSArray *args = [invocation mkt_arguments];
        ((id(^)())(args[1]))(success);
        return nil;
    }];
}

- (void)givenWeAreNow
{
    [given([self.time now]) willReturnInt: Now];
}

- (void)givenNotEnoughTimePassedToReportTheSecondTime
{
    [[[given([self.time now])
       willReturnInt:Now]
      willReturnInt:Now]
     willReturnInt:RightAfterNow];
}

- (void)givenEnoughTimePassedToReportTheSecondTime
{
    [[given([self.time now])
      willReturnInt:Now]
     willReturnInt:LongTimeSinceNow];
}

- (void)givenSdkIsEnabled
{
    [given([self.config enabled]) willReturnBool:YES];
}

- (void)givenSdkIsDisabled
{
    [given([self.config enabled]) willReturnBool:NO];
}

- (ReportScheduler *)reportScheduler
{
    return [[ReportScheduler alloc] initWithMetricsStorage:self.storage
                                           reportApiClient:self.apiClient
                                                    device:self.device
                                                    config:self.config
                                                      time:self.time];
}

@end

