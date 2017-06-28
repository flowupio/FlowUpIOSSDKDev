//
//  FUPSafetyNetTests.m
//  SDK
//
//  Created by Sergio Gutiérrez on 26/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FUPSafetyNet.h"
#import <Nimble/Nimble.h>
#import <OCHamcrest/OCHamcrest.h>
#import <OCMockito/OCMockito.h>
@import Nimble.Swift;


@interface FUPSafetyNetTests : XCTestCase

@property (readwrite, nonatomic) FUPCrashReporterApiClient *apiClient;
@property (readwrite, nonatomic) FUPDevice *device;
@property (readwrite, nonatomic) FUPSafetyNet *safetyNet;

@end

@implementation FUPSafetyNetTests

- (void)setUp
{
    [super setUp];
    self.apiClient = mock([FUPCrashReporterApiClient class]);
    self.device = mock([FUPDevice class]);
    self.safetyNet = [[FUPSafetyNet alloc] initWithCrashReporterApiClient:self.apiClient
                                                                   device:self.device];
}

- (void)testSafetyNet_SendsCrashReport_IfBlockThrowsException
{
    [self.safetyNet runBlock:^{
        [self throwAnyException];
    }];

    [verify(self.apiClient) sendReport:anything() completion:anything()];
}

- (void)testSafetyNet_WontSendReport_IfBlockDoesNotThrowException
{
    [self.safetyNet runBlock:^{}];

    [verifyCount(self.apiClient, never()) sendReport:anything() completion:anything()];
}

- (void)throwAnyException
{
    @throw [NSException exceptionWithName:@"Exception Name"
                                   reason:@"Exception Reason"
                                 userInfo:@{}];
}

@end
