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
    stubRequest(@"POST", @"https://www.testingflowup.com/crashReport").
    withHeader(@"Accept", @"application/json").
    andReturn(200);

    __block BOOL didSendReport = NO;
    [[self apiClient] sendReports:[self anyReports]
                       completion:^(FUPApiClientError *error) { didSendReport = YES; }];

    expect(didSendReport).toEventually(equal(YES));
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
                                      debugModeStorage:debugModeStorage
            device:<#(FUPDevice *)#>];
}

@end
