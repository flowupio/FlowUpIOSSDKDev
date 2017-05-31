//
//  FUPConfigStorage.m
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPConfigStorage.h"

static NSString *const CreateTableStatement =
@"CREATE TABLE IF NOT EXISTS config(\
id TEXT NOT NULL PRIMARY KEY DEFAULT 'UNIQUE_ID', \
enabled INTEGER DEFAULT 1)";

@interface FUPConfigStorage ()

@property (readonly, nonatomic) FUPSqlite *sqlite;

@end

@implementation FUPConfigStorage

- (instancetype)initWithSqlite:(FUPSqlite *)sqlite
{
    self = [super init];
    if (self) {
        _sqlite = sqlite;
    }
    return self;
}

- (FUPConfig *)config
{
    FUPConfig *config = [self readConfigFromDatabase];
    return config != nil ? config : [[FUPConfig alloc] initWithIsEnabled:YES];
}

- (void)setConfig:(FUPConfig *)config
{
    [self.sqlite createTable:@"config" withStatement:CreateTableStatement];
    NSString *insertStatement = [NSString stringWithFormat:
                                 @"INSERT OR REPLACE INTO config\
                                 (id, enabled) \
                                 values ('UNIQUE_ID', \"%@\")",
                                 [NSNumber numberWithBool:config.isEnabled]];
    BOOL success = [self.sqlite runStatement:insertStatement];
    if (success) {
        NSLog(@"[FUPConfigStorage] Config stored [%@]", config.isEnabled ? @"YES" : @"NO");
    } else {
        NSLog(@"[FUPConfigStorage] There was an error inserting a new config value");
    }
}

- (void)clear
{
    [self.sqlite createTable:@"config" withStatement:CreateTableStatement];
    BOOL success = [self.sqlite runStatement:@"DELETE FROM config WHERE id = 'UNIQUE_ID')"];
    if (success) {
        NSLog(@"[FUPConfigStorage] Config deleted");
    } else {
        NSLog(@"[FUPConfigStorage] There was an error deleting the stored config");
    }
}

- (FUPConfig *)readConfigFromDatabase
{
    [self.sqlite createTable:@"config" withStatement:CreateTableStatement];
    __block FUPConfig *config = nil;
    NSString *query = @"SELECT * FROM config";

    [self.sqlite runQuery:query block:^BOOL(sqlite3_stmt *statement) {
        int rawValue = sqlite3_column_int(statement, 1);
        config = [[FUPConfig alloc] initWithIsEnabled:[[NSNumber numberWithInt:rawValue] boolValue]];
        return NO;
    }];

    return config;
}

@end
