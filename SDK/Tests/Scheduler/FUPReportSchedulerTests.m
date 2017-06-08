//
//  ReportSchedulerTests.m
//  SDK
//
//  Created by Sergio Gutiérrez on 26/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FUPTestAsync.h"
#import "FUPReportScheduler.h"
#import "FUPCpuMetricMother.h"
#import <Nimble/Nimble.h>
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>
@import Nimble.Swift;

static NSTimeInterval const Now = 123;
static NSTimeInterval const RightAfterNow = Now + 1;
static NSTimeInterval const LongTimeSinceNow = Now + ReportSchedulerTimeBetweenReportsTimeInterval + 1;

@interface ReportSchedulerTests : XCTestCase

@property (readwrite, nonatomic) FUPMetricsStorage *storage;
@property (readwrite, nonatomic) FUPReportScheduler *scheduler;
@property (readwrite, nonatomic) FUPReportApiClient *apiClient;
@property (readwrite, nonatomic) FUPDevice *device;
@property (readwrite, nonatomic) FUPConfigService *configService;
@property (readwrite, nonatomic) FUPTime *time;

@end

@implementation ReportSchedulerTests

- (void)setUp {
    [super setUp];
    FUPSqlite *sqlite = [[FUPSqlite alloc] initWithFileName:@"testingdb.sqlite"];
    self.apiClient = mock([FUPReportApiClient class]);
    self.storage = [[FUPMetricsStorage alloc] initWithSqlite:sqlite];
    self.device = mock([FUPDevice class]);
    self.configService = mock([FUPConfigService class]);
    self.time = mock([FUPTime class]);
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
    [self.storage storeCpuMetric:[FUPCpuMetricMother any]];
    [self.scheduler reportMetrics];
    [self.storage storeCpuMetric:[FUPCpuMetricMother any]];

    [self.scheduler reportMetrics];

    [verifyCount(self.apiClient, times(1)) sendReports:anything() completion:anything()];
}

- (void)testScheduler_Reports_IfItsTheFirstTime
{
    [self givenApiClientReportsSuccessfully];
    [self.storage storeCpuMetric:[FUPCpuMetricMother any]];

    [self.scheduler reportMetrics];

    [verify(self.apiClient) sendReports:anything() completion:anything()];
}

- (void)testScheduler_Reports_IfThereAreMetricsAndHasPassedEnoughTimeSinceLastReport
{
    [self givenEnoughTimePassedToReportTheSecondTime];
    [self givenApiClientReportsSuccessfully];
    [self.storage storeCpuMetric:[FUPCpuMetricMother any]];
    [self.scheduler reportMetrics];
    [self.storage storeCpuMetric:[FUPCpuMetricMother any]];

    [self.scheduler reportMetrics];

    [verifyCount(self.apiClient, times(2)) sendReports:anything() completion:anything()];
}

- (void)testScheduler_RemovesMetrics_IfTheyHaveBeenSuccessfullyReported
{
    [self givenApiClientReportsSuccessfully];
    [self.storage storeCpuMetric:[FUPCpuMetricMother any]];

    [self.scheduler reportMetrics];

    expect(self.storage.hasReports).to(equal(NO));
}

- (void)testScheduler_DontRemoveMetrics_IfThereWasAnUnknownErrorReporting
{
    [self givenApiClientReports:[FUPApiClientError unknown]];
    [self.storage storeCpuMetric:[FUPCpuMetricMother any]];

    [self.scheduler reportMetrics];

    expect(self.storage.hasReports).to(equal(YES));
}

- (void)testScheduler_RemoveMetrics_IfThereWasAServerErrorReporting
{
    [self givenApiClientReports:[FUPApiClientError serverError]];
    [self.storage storeCpuMetric:[FUPCpuMetricMother any]];

    [self.scheduler reportMetrics];

    expect(self.storage.hasReports).to(equal(NO));
}

- (void)testScheduler_RemoveMetrics_IfThereWasAnUnauthorizedErrorReporting
{
    [self givenApiClientReports:[FUPApiClientError unauthorized]];
    [self.storage storeCpuMetric:[FUPCpuMetricMother any]];

    [self.scheduler reportMetrics];

    expect(self.storage.hasReports).to(equal(NO));
}

- (void)testScheduler_RemoveMetrics_IfThereWasAClientDisabledErrorReporting
{
    [self givenApiClientReports:[FUPApiClientError clientDisabled]];
    [self.storage storeCpuMetric:[FUPCpuMetricMother any]];

    [self.scheduler reportMetrics];

    expect(self.storage.hasReports).to(equal(NO));
}

- (void)testScheduler_DisablesSdk_IfThereWasAServerErrorReporting
{
    [self givenApiClientReports:[FUPApiClientError serverError]];
    [self.storage storeCpuMetric:[FUPCpuMetricMother any]];

    [self.scheduler reportMetrics];

    [verify(self.configService) disable];
}

- (void)testScheduler_DisablesSdk_IfThereWasAnUnauthorizedErrorReporting
{
    [self givenApiClientReports:[FUPApiClientError unauthorized]];
    [self.storage storeCpuMetric:[FUPCpuMetricMother any]];

    [self.scheduler reportMetrics];

    [verify(self.configService) disable];
}

- (void)testScheduler_DisablesSdk_IfThereWasAClientDisabledErrorReporting
{
    [self givenApiClientReports:[FUPApiClientError clientDisabled]];
    [self.storage storeCpuMetric:[FUPCpuMetricMother any]];

    [self.scheduler reportMetrics];

    [verify(self.configService) disable];
}

- (void)testScheduler_DoesNotDisableSdk_IfThereWasAnUnknownError
{
    [self givenApiClientReports:[FUPApiClientError unknown]];
    [self.storage storeCpuMetric:[FUPCpuMetricMother any]];

    [self.scheduler reportMetrics];

    [verifyCount(self.configService, never()) disable];
}

- (void)givenApiClientReportsSuccessfully
{
    [self givenApiClientReports:nil];
}

- (void)givenApiClientReports:(FUPApiClientError *)error
{
    [givenVoid([self.apiClient sendReports:anything() completion:anything()]) willDo:^id (NSInvocation *invocation){
        NSArray *args = [invocation mkt_arguments];
        ((id(^)())(args[1]))(error);
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
    [given([self.configService enabled]) willReturnBool:YES];
}

- (void)givenSdkIsDisabled
{
    [given([self.configService enabled]) willReturnBool:NO];
}

- (FUPReportScheduler *)reportScheduler
{
    return [[FUPReportScheduler alloc] initWithMetricsStorage:self.storage
                                           reportApiClient:self.apiClient
                                                    device:self.device
                                             configService:self.configService
                                                      time:self.time];
}

@end

