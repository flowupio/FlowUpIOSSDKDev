//
//  FUPConfigStorageTests.m
//  SDK
//
//  Created by Sergio Gutiérrez on 31/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FUPConfigStorage.h"
#import <Nimble/Nimble.h>
@import Nimble.Swift;

@interface FUPConfigStorageTests : XCTestCase

@property (readwrite, nonatomic) FUPSqlite *sqlite;
@property (readwrite, nonatomic) FUPConfigStorage *storage;

@end

@implementation FUPConfigStorageTests

- (void)setUp {
    [super setUp];
    self.sqlite = [[FUPSqlite alloc] initWithFileName:@"testingdb.sqlite"
                                         queueStorage:[[FUPQueueStorage alloc] init]];
    self.storage = [[FUPConfigStorage alloc] initWithSqlite:self.sqlite];
}

- (void)tearDown {
    [self.storage clear];
    [super tearDown];
}

- (void)testConfigStorage_DeletesConfig_IfCleared
{
    self.storage.config = [self anyConfig];

    [self.storage clear];

    expect(self.storage.config).toNot(beNil());
}

- (void)testConfigStorage_ReturnsStoredConfig_IfConfigHasBeenStored
{
    self.storage.config = [self anyConfig];

    expect(self.storage.config.isEnabled).to(beTrue());
}

- (void)testConfigStorage_OverridesPreviousConfig_IfConfigHasBeenStored
{
    self.storage.config = [self anyConfig];
    self.storage.config = [[FUPConfig alloc] initWithIsEnabled:NO];

    expect(self.storage.config.isEnabled).to(beFalse());
}

- (FUPConfig *)anyConfig
{
    return [[FUPConfig alloc] initWithIsEnabled:YES];
}

@end
