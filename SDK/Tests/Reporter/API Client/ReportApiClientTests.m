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
#import "CpuMetricMother.h"
#import "Configuration.h"
#import <Nimble/Nimble.h>
#import <Nocilla/Nocilla.h>
@import Nimble.Swift;

@interface ReportApiClientTests : ApiClientTests

@property (readwrite, nonatomic) ReportApiClient *reportApiClient;

@end

@implementation ReportApiClientTests

- (void)setUp {
    [super setUp];
    self.reportApiClient = [self reportApiClient];
}

- (void)testApiClient_SendsAcceptJsonHeader_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"Accept", @"application/json").
    andReturn(200);

    __block BOOL didSendReport = NO;
    [self.reportApiClient sendReports:[self anyReports]
                           completion:^(BOOL success) { didSendReport = success; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsContentTypeJsonHeader_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"Content-Type", @"application/json; charset=utf-8").
    andReturn(200);

    __block BOOL didSendReport = NO;
    [self.reportApiClient sendReports:[self anyReports]
                           completion:^(BOOL success) { didSendReport = success; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsApiKeyHeader_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"X-Api-Key", ApiKey).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [self.reportApiClient sendReports:[self anyReports]
                           completion:^(BOOL success) { didSendReport = success; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsUuidHeader_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"X-UUID", Uuid).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [self.reportApiClient sendReports:[self anyReports]
                           completion:^(BOOL success) { didSendReport = success; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsUserAgentHeader_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"User-Agent", [NSString stringWithFormat:@"FlowUpIOSSDK/%@", SDKVersion]).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [self.reportApiClient sendReports:[self anyReports]
                           completion:^(BOOL success) { didSendReport = success; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendReports_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withBody([self dictionaryFromJsonFileWithName:@"reportApiRequest"]).
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
                                    cpuMetrics:@[[CpuMetricMother any]]];
}

@end
