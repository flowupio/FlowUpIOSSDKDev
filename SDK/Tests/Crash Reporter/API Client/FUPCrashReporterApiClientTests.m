//
//  FUPCrashReporterApiClientTests.m
//  SDK
//
//  Created by Sergio Gutiérrez on 26/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FUPCrashReporterApiClient.h"
#import "FUPApiClientTests.h"
#import "NSDictionary+Matcheable.h"
#import "FUPMetricMother.h"
#import "FUPConfiguration.h"
#import <Nimble/Nimble.h>
#import <Nocilla/Nocilla.h>
@import Nimble.Swift;

@interface FUPCrashReporterApiClientTests : FUPApiClientTests

@end

@implementation FUPCrashReporterApiClientTests

- (void)testApiClient_SendsAcceptJsonHeader_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/errorReport").
    withHeader(@"Accept", @"application/json").
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClient] sendReport:[self anyReport]
                      completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsContentTypeJsonHeader_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/errorReport").
    withHeader(@"Content-Type", @"application/json; charset=utf-8").
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClient] sendReport:[self anyReport]
                      completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsApiKeyHeader_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/errorReport").
    withHeader(@"X-Api-Key", ApiKey).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClient] sendReport:[self anyReport]
                      completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsUuidHeader_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/errorReport").
    withHeader(@"X-UUID", Uuid).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClient] sendReport:[self anyReport]
                      completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsUserAgentHeader_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/errorReport").
    withHeader(@"User-Agent", [NSString stringWithFormat:@"FlowUpIOSSDK/%@", SDKVersion]).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClient] sendReport:[self anyReport]
                      completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsUserAgentHeaderWithDebugMode_IfDebugModeIsEnabled {
    stubRequest(@"POST", @"https://www.testingflowup.com/errorReport").
    withHeader(@"User-Agent", [NSString stringWithFormat:@"FlowUpIOSSDK/%@-DEBUG", SDKVersion]).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClientWithDebugModeEnabled:YES] sendReport:[self anyReport]
                                              completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsDebugHeaderAsTrue_IfDebugModeIsEnabled {
    stubRequest(@"POST", @"https://www.testingflowup.com/errorReport").
    withHeader(@"X-Debug-Mode", [NSString stringWithFormat:@"true"]).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClientWithDebugModeEnabled:YES] sendReport:[self anyReport]
                                              completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendsDebugHeaderAsFalse_IfDebugModeIsDisabled {
    stubRequest(@"POST", @"https://www.testingflowup.com/errorReport").
    withHeader(@"X-Debug-Mode", [NSString stringWithFormat:@"false"]).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClient] sendReport:[self anyReport]
                      completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_SendReport_Always {
    stubRequest(@"POST", @"https://www.testingflowup.com/errorReport").
    withBody([self dictionaryFromJsonFileWithName:@"crashReportApiRequest"]).
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClient] sendReport:[self anyReport]
                      completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
}

- (void)testApiClient_ReturnsNoError_IfServerReturnsSuccess {
    stubRequest(@"POST", @"https://www.testingflowup.com/errorReport").
    withBody([self dictionaryFromJsonFileWithName:@"crashReportApiRequest"]).
    andReturn(200);

    __block BOOL success = NO;
    [[self apiClient] sendReport:[self anyReport]
                      completion:^(FUPApiClientError *error) { success = error == nil; }];

    expect(success).toEventually(equal(YES));
}

- (void)testApiClient_ReturnsUnknownError_IfServerReturnsInternalError {
    stubRequest(@"POST", @"https://www.testingflowup.com/errorReport").
    withBody([self dictionaryFromJsonFileWithName:@"crashReportApiRequest"]).
    andReturn(500);

    __block FUPApiClientError *returnedError = nil;
    [[self apiClient] sendReport:[self anyReport]
                      completion:^(FUPApiClientError *error) { returnedError = error; }];

    expect(returnedError).toEventuallyNot(beNil());
    XCTAssertEqual(returnedError.code, FUPApiClientErrorCodeUnknown);
}

- (FUPCrashReport *)anyReport
{
    return [[FUPCrashReport alloc] initWithDeviceModel:@"Device Model"
                                             osVersion:@"OS Version"
                                 isLowPowerModeEnabled:NO
                                               message:@"There was an error"
                                            stackTrace:@"A\nB\nC"];
}

- (FUPCrashReporterApiClient *)apiClient
{
    return [self apiClientWithDebugModeEnabled:NO];
}

- (FUPCrashReporterApiClient *)apiClientWithDebugModeEnabled:(BOOL)isDebugModeEnabled
{
    FUPDebugModeStorage *debugModeStorage = [[FUPDebugModeStorage alloc] init];
    debugModeStorage.isDebugModeEnabled = isDebugModeEnabled;
    return [[FUPCrashReporterApiClient alloc] initWithBaseUrl:@"https://www.testingflowup.com"
                                                       apiKey:ApiKey
                                                         uuid:Uuid
                                             debugModeStorage:debugModeStorage];
}

@end
