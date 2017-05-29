//
//  FUPFlowUpConfigTests.m
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FUPFlowUpConfig.h"
#import <Nimble/Nimble.h>
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>
@import Nimble.Swift;

@interface FUPFlowUpConfigTests : XCTestCase

@property (readwrite, nonatomic) FUPConfigApiClient *apiClient;
@property (readwrite, nonatomic) FUPConfigStorage *storage;
@property (readwrite, nonatomic) FUPFlowUpConfig *config;

@end

@implementation FUPFlowUpConfigTests

- (void)setUp {
    [super setUp];
    self.apiClient = mock([FUPConfigApiClient class]);
    self.storage = mock([FUPConfigStorage class]);
    self.config = [[FUPFlowUpConfig alloc] initWithApiClient:self.apiClient
                                                     storage:self.storage];
}

- (void)testConfig_ReturnsFalse_IfApiClientReturnsError
{
    [self givenApiClientReturnsError];

    __block BOOL didUpdateConfig = YES;
    [self.config updateWithCompletion:^(BOOL success) { didUpdateConfig = success; }];

    expect(didUpdateConfig).to(beFalse());
}

- (void)testConfig_ReturnsTrue_IfApiClientReturnsSuccess
{
    [self givenApiClientReturnsConfig];

    __block BOOL didUpdateConfig = YES;
    [self.config updateWithCompletion:^(BOOL success) { didUpdateConfig = success; }];

    expect(didUpdateConfig).to(beTrue());
}

- (void)testConfig_StoresConfig_IfApiClientReturnsSuccess
{
    [self givenApiClientReturnsConfig];

    [self.config updateWithCompletion:^(BOOL success) {}];

    [verify(self.storage) setConfig:anything()];
}

- (void)testConfig_ReturnsStoredConfig_IfConfigHasBeenPersisted
{
    FUPConfig *config = [self givenAPersistedConfig];

    BOOL isEnabled = self.config.enabled;

    expect(isEnabled).to(equal(config.isEnabled));
}

- (void)testConfig_StoresDisabledConfig_IfConfigIsDisabled
{
    [self givenAPersistedConfig];

    [self.config disable];

    [self thenConfigWithIsEnabledValueIsStored:NO];
}

- (FUPConfig *)givenAPersistedConfig
{
    FUPConfig *config = [self anyConfig];
    [given([self.storage config]) willReturn:config];
    return config;
}

- (void)givenApiClientReturnsConfig
{
    [self givenApiClientReturnsResult:[[FUPResult alloc] initWithValue:[self anyConfig]]];
}

- (void)givenApiClientReturnsError
{
    [self givenApiClientReturnsResult:[[FUPResult alloc] initWithError:[FUPApiClientError unknown]]];
}

- (void)givenApiClientReturnsResult:(FUPResult<FUPConfig *,FUPApiClientError *> *)result
{
    [givenVoid([self.apiClient getConfigWithCompletion:anything()]) willDo:^id (NSInvocation *invocation){
        NSArray *args = [invocation mkt_arguments];
        ((id(^)())(args[0]))(result);
        return nil;
    }];
}

- (void)thenConfigWithIsEnabledValueIsStored:(BOOL)isEnabled
{
    HCArgumentCaptor *argument = [[HCArgumentCaptor alloc] init];
    [verify(self.storage) setConfig:(id)argument];
    FUPConfig *storedConfig = argument.value;
    expect(storedConfig.isEnabled).to(equal(isEnabled));
}

- (FUPConfig *)anyConfig
{
    return [[FUPConfig alloc] initWithIsEnabled:NO];
}

@end
