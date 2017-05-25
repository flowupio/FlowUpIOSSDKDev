//
//  Tests.m
//  Tests
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ReportApiClient.h"
#import "ApiClientTests.h"
#import "NSDictionary+Matcheable.h"
#import "Configuration.h"
@import Nimble;
@import Nocilla;

static NSString *const ApiKey = @"This is my Api Key";
static NSString *const Uuid = @"00ecccb6-415b-11e7-a919-92ebcb67fe33";

@interface ReportApiClientTests : ApiClientTests

@property (readwrite, nonatomic) ReportApiClient *reportApiClient;

@end

@implementation ReportApiClientTests

- (void)setUp {
    [super setUp];
    self.reportApiClient = [self reportApiClient];
    [[LSNocilla sharedInstance] start];
}

- (void)tearDown {
    [super tearDown];
    [[LSNocilla sharedInstance] clearStubs];
    [[LSNocilla sharedInstance] stop];
}

- (void)testAcceptJsonHeaderIsBeingSent {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"Accept", @"application/json").
    andReturn(200);

    __block BOOL didSendReport = NO;
    [self.reportApiClient sendReports:[self anyReports]
                           completion:^(BOOL success) { didSendReport = success; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testContentTypeJsonHeaderIsBeingSent {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"Content-Type", @"application/json; charset=utf-8").
    andReturn(200);

    __block BOOL didSendReport = NO;
    [self.reportApiClient sendReports:[self anyReports]
                           completion:^(BOOL success) { didSendReport = success; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiKeyHeaderIsBeingSent {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"X-Api-Key", ApiKey).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [self.reportApiClient sendReports:[self anyReports]
                           completion:^(BOOL success) { didSendReport = success; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testUuidHeaderIsBeingSent {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"X-UUID", Uuid).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [self.reportApiClient sendReports:[self anyReports]
                           completion:^(BOOL success) { didSendReport = success; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testUserAgentHeaderIsBeingSent {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"User-Agent", [NSString stringWithFormat:@"FlowUpIOSSDK/%@", SDKVersion]).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [self.reportApiClient sendReports:[self anyReports]
                           completion:^(BOOL success) { didSendReport = success; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testReportsAreBeingSent {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withBody([self fromJsonFileWithName:@"reportApiRequest"]).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [self.reportApiClient sendReports:[self anyReports]
                           completion:^(BOOL success) { didSendReport = success; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (ReportApiClient *)reportApiClient
{
    return [[ReportApiClient alloc] initWithBaseUrl:@"https://www.testingflowup.com"
                                             apiKey:ApiKey
                                               uuid:Uuid];
}

- (Reports *)anyReports
{
    return [[Reports alloc] initWithAppPackage:@"App package"
                              installationUuid:@"Installation UUID"
                                   deviceModel:@"Device model"
                                 screenDensity:@"Screen Density"
                                    screenSize:@"Screen Size"
                                 numberOfCores:4
                                    cpuMetrics:@[[self anyCpuMetric]]];
}

- (CpuMetric *)anyCpuMetric
{
    return [[CpuMetric alloc] initWithTimestamp:1234
                                 appVersionName:@"App Version Name"
                                      osVersion:@"OS Version"
                          isLowPowerModeEnabled:NO
                                       cpuUsage:23];
}

@end
