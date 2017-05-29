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

- (void)testAcceptJsonHeaderIsBeingSent {
    stubRequest(@"GET", @"https://www.testingflowup.com/config").
    withHeader(@"Accept", @"application/json").
    andReturn(200);

    __block BOOL didGetConfig = NO;
    [self.apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *response) { didGetConfig = YES; }];

    expect(didGetConfig).toEventually(equal(YES));
}

- (void)testContentTypeJsonHeaderIsBeingSent {
    stubRequest(@"GET", @"https://www.testingflowup.com/config").
    withHeader(@"Content-Type", @"application/json; charset=utf-8").
    andReturn(200);

    __block BOOL didGetConfig = NO;
    [self.apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *response) { didGetConfig = YES; }];

    expect(didGetConfig).toEventually(equal(YES));
}

- (void)testApiKeyHeaderIsBeingSent {
    stubRequest(@"GET", @"https://www.testingflowup.com/config").
    withHeader(@"X-Api-Key", ApiKey).
    andReturn(200);

    __block BOOL didGetConfig = NO;
    [self.apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *response) { didGetConfig = YES; }];

    expect(didGetConfig).toEventually(equal(YES));
}

- (void)testUuidHeaderIsBeingSent {
    stubRequest(@"GET", @"https://www.testingflowup.com/config").
    withHeader(@"X-UUID", Uuid).
    andReturn(200);

    __block BOOL didGetConfig = NO;
    [self.apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *response) { didGetConfig = YES; }];

    expect(didGetConfig).toEventually(equal(YES));
}

- (void)testUserAgentHeaderIsBeingSent {
    stubRequest(@"GET", @"https://www.testingflowup.com/config").
    withHeader(@"User-Agent", [NSString stringWithFormat:@"FlowUpIOSSDK/%@", SDKVersion]).
    andReturn(200);

    __block BOOL didGetConfig = NO;
    [self.apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *response) { didGetConfig = YES; }];

    expect(didGetConfig).toEventually(equal(YES));
}

- (FUPConfigApiClient *)apiClient
{
    return [[FUPConfigApiClient alloc] initWithBaseUrl:@"https://www.testingflowup.com"
                                                apiKey:ApiKey
                                                  uuid:Uuid];
}

@end
