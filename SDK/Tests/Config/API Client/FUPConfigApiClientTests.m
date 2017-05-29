//
//  FUPConfigApiClientTests.m
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ApiClientTests.h"
#import "FUPConfigApiClient.h"
#import <Nimble/Nimble.h>
#import <Nocilla/Nocilla.h>
@import Nimble.Swift;

@interface FUPConfigApiClientTests : ApiClientTests

@property (readwrite, nonatomic) FUPConfigApiClient *apiClient;

@end

@implementation FUPConfigApiClientTests

- (void)setUp {
    [super setUp];
    self.apiClient = [self apiClient];
}

- (void)testApiClient_SendsAcceptJsonHeader_Always {
    stubRequest(@"GET", @"https://www.testingflowup.com/config").
    withHeader(@"Accept", @"application/json").
    andReturn(200);

    __block BOOL didGetConfig = NO;
    [self.apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *response) { didGetConfig = YES; }];

    expect(didGetConfig).toEventually(equal(YES));
}

- (void)testApiClient_SendsContentTypeJsonHeader_Always {
    stubRequest(@"GET", @"https://www.testingflowup.com/config").
    withHeader(@"Content-Type", @"application/json; charset=utf-8").
    andReturn(200);

    __block BOOL didGetConfig = NO;
    [self.apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *response) { didGetConfig = YES; }];

    expect(didGetConfig).toEventually(equal(YES));
}

- (void)testApiClient_SendsApiKeyHeader_Always {
    stubRequest(@"GET", @"https://www.testingflowup.com/config").
    withHeader(@"X-Api-Key", ApiKey).
    andReturn(200);

    __block BOOL didGetConfig = NO;
    [self.apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *response) { didGetConfig = YES; }];

    expect(didGetConfig).toEventually(equal(YES));
}

- (void)testApiClient_SendsUuidHeader_Always {
    stubRequest(@"GET", @"https://www.testingflowup.com/config").
    withHeader(@"X-UUID", Uuid).
    andReturn(200);

    __block BOOL didGetConfig = NO;
    [self.apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *response) { didGetConfig = YES; }];

    expect(didGetConfig).toEventually(equal(YES));
}

- (void)testApiClient_SendsUserAgentHeader_Always {
    stubRequest(@"GET", @"https://www.testingflowup.com/config").
    withHeader(@"User-Agent", [NSString stringWithFormat:@"FlowUpIOSSDK/%@", SDKVersion]).
    andReturn(200);

    __block BOOL didGetConfig = NO;
    [self.apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *response) { didGetConfig = YES; }];

    expect(didGetConfig).toEventually(equal(YES));
}

- (void)testApiClient_ReturnsUnknownError_IfThereIsAServerError {
    stubRequest(@"GET", @"https://www.testingflowup.com/config").
    withHeader(@"User-Agent", [NSString stringWithFormat:@"FlowUpIOSSDK/%@", SDKVersion]).
    andReturn(500);

    __block FUPApiClientError *error = NO;
    [self.apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *response) { error = response.error; }];


    expect(error).toEventuallyNot(beNil());
    XCTAssertEqual(error.code, FUPApiClientErrorCodeUnknown);
}

- (void)testApiClient_ReturnsUnknownError_IfServerReturnsUnauthorized {
    stubRequest(@"GET", @"https://www.testingflowup.com/config").
    withHeader(@"User-Agent", [NSString stringWithFormat:@"FlowUpIOSSDK/%@", SDKVersion]).
    andReturn(401);

    __block FUPApiClientError *error = NO;
    [self.apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *response) { error = response.error; }];


    expect(error).toEventuallyNot(beNil());
    XCTAssertEqual(error.code, FUPApiClientErrorCodeUnknown);
}

- (void)testApiClient_ReturnsConfigResponse_IfSuccess {
    stubRequest(@"GET", @"https://www.testingflowup.com/config").
    withHeader(@"User-Agent", [NSString stringWithFormat:@"FlowUpIOSSDK/%@", SDKVersion]).
    andReturn(200).
    withHeader(@"Content-Type", @"application/json").
    withBody([self stringFromJsonFileWithName:@"getConfigResponse"]);

    __block FUPConfig *config = nil;
    [self.apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *response) { config = response.value; }];

    expect(config).toEventuallyNot(beNil());
    expect(config.isEnabled).to(beFalse());
}

- (void)testApiClient_ReturnsConfigEnabled_IfNoEnabledFieldInResponse {
    stubRequest(@"GET", @"https://www.testingflowup.com/config").
    withHeader(@"User-Agent", [NSString stringWithFormat:@"FlowUpIOSSDK/%@", SDKVersion]).
    andReturn(200).
    withHeader(@"Content-Type", @"application/json").
    withBody([self stringFromJsonFileWithName:@"emptyConfigResponse"]);

    __block FUPConfig *config = nil;
    [self.apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *response) { config = response.value; }];

    expect(config).toEventuallyNot(beNil());
    expect(config.isEnabled).to(beTrue());
}

- (FUPConfigApiClient *)apiClient
{
    return [[FUPConfigApiClient alloc] initWithBaseUrl:@"https://www.testingflowup.com"
                                                apiKey:ApiKey
                                                  uuid:Uuid];
}

@end
