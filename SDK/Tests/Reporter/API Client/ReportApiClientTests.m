//
//  Tests.m
//  Tests
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ReportApiClient.h"
#import "FUPApiClientTests.h"
#import "NSDictionary+Matcheable.h"
#import "CpuMetricMother.h"
#import "FUPConfiguration.h"
#import <Nimble/Nimble.h>
#import <Nocilla/Nocilla.h>
@import Nimble.Swift;

@interface ReportApiClientTests : FUPApiClientTests

@end

@implementation ReportApiClientTests

- (void)testApiClient_SendsAcceptJsonHeader_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"Accept", @"application/json").
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClient] sendReports:[self anyReports]
                       completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsContentTypeJsonHeader_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"Content-Type", @"application/json; charset=utf-8").
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClient] sendReports:[self anyReports]
                       completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsApiKeyHeader_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"X-Api-Key", ApiKey).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClient] sendReports:[self anyReports]
                       completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsUuidHeader_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"X-UUID", Uuid).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClient] sendReports:[self anyReports]
                       completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsUserAgentHeader_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"User-Agent", [NSString stringWithFormat:@"FlowUpIOSSDK/%@", SDKVersion]).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClient] sendReports:[self anyReports]
                       completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsUserAgentHeaderWithDebugMode_IfDebugModeIsEnabled {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"User-Agent", [NSString stringWithFormat:@"FlowUpIOSSDK/%@-DEBUG", SDKVersion]).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClientWithDebugModeEnabled:YES] sendReports:[self anyReports]
                                               completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsDebugHeaderAsTrue_IfDebugModeIsEnabled {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"X-Debug-Mode", [NSString stringWithFormat:@"true"]).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClientWithDebugModeEnabled:YES] sendReports:[self anyReports]
                                               completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsDebugHeaderAsFalse_IfDebugModeIsDisabled {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withHeader(@"X-Debug-Mode", [NSString stringWithFormat:@"false"]).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClient] sendReports:[self anyReports]
                       completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}


- (void)testApiClient_SendReports_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withBody([self dictionaryFromJsonFileWithName:@"reportApiRequest"]).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClient] sendReports:[self anyReports]
                       completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_ReturnsNoError_IfServerReturnsSuccess {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withBody([self dictionaryFromJsonFileWithName:@"reportApiRequest"]).
    andReturn(200);

    __block BOOL success = NO;
    [[self apiClient] sendReports:[self anyReports]
                       completion:^(FUPApiClientError *error) { success = error == nil; }];

    expect(success).toEventually(equal(YES));
}

- (void)testApiClient_ReturnsServerError_IfServerReturnsInternalError {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withBody([self dictionaryFromJsonFileWithName:@"reportApiRequest"]).
    andReturn(500);

    __block FUPApiClientError *returnedError = nil;
    [[self apiClient] sendReports:[self anyReports]
                       completion:^(FUPApiClientError *error) { returnedError = error; }];

    expect(returnedError).toEventuallyNot(beNil());
    XCTAssertEqual(returnedError.code, FUPApiClientErrorCodeServerError);
}

- (void)testApiClient_ReturnsUnauthorizedError_IfServerReturnsStatusCode401 {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withBody([self dictionaryFromJsonFileWithName:@"reportApiRequest"]).
    andReturn(401);

    __block FUPApiClientError *returnedError = nil;
    [[self apiClient] sendReports:[self anyReports]
                       completion:^(FUPApiClientError *error) { returnedError = error; }];

    expect(returnedError).toEventuallyNot(beNil());
    XCTAssertEqual(returnedError.code, FUPApiClientErrorCodeUnauthorized);
}

- (void)testApiClient_ReturnsUnauthorizedError_IfServerReturnsStatusCode403 {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withBody([self dictionaryFromJsonFileWithName:@"reportApiRequest"]).
    andReturn(403);

    __block FUPApiClientError *returnedError = nil;
    [[self apiClient] sendReports:[self anyReports]
                       completion:^(FUPApiClientError *error) { returnedError = error; }];

    expect(returnedError).toEventuallyNot(beNil());
    XCTAssertEqual(returnedError.code, FUPApiClientErrorCodeUnauthorized);
}

- (void)testApiClient_ReturnsClientDisabledError_IfServerReturnsStatusCode412 {
    stubRequest(@"POST", @"https://www.testingflowup.com/report").
    withBody([self dictionaryFromJsonFileWithName:@"reportApiRequest"]).
    andReturn(412);

    __block FUPApiClientError *returnedError = nil;
    [[self apiClient] sendReports:[self anyReports]
                       completion:^(FUPApiClientError *error) { returnedError = error; }];

    expect(returnedError).toEventuallyNot(beNil());
    XCTAssertEqual(returnedError.code, FUPApiClientErrorCodeClientDisabled);
}


- (ReportApiClient *)apiClient
{
    return [self apiClientWithDebugModeEnabled:NO];
}

- (ReportApiClient *)apiClientWithDebugModeEnabled:(BOOL)isDebugModeEnabled
{
    FUPDebugModeStorage *debugModeStorage = [[FUPDebugModeStorage alloc] init];
    debugModeStorage.isDebugModeEnabled = isDebugModeEnabled;

    return [[ReportApiClient alloc] initWithBaseUrl:@"https://www.testingflowup.com"
                                             apiKey:ApiKey
                                               uuid:Uuid
                                   debugModeStorage:debugModeStorage];
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
