//
//  FUPConfigStorage.m
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPConfigStorage.h"

static NSString *const TableCreatedKey = @"FlowUp.ConfigTableCreated";

@interface FUPConfigStorage ()

@property (readonly, nonatomic) dispatch_queue_t queue;
@property (readonly, nonatomic) FUPSqlite *sqlite;

@end

@implementation FUPConfigStorage

- (instancetype)initWithSqlite:(FUPSqlite *)sqlite
{
    self = [super init];
    if (self) {
        _queue = dispatch_queue_create("Config Storage Queue", DISPATCH_QUEUE_SERIAL);
        _sqlite = sqlite;
    }
    return self;
}

- (FUPConfig *)config
{
    __block FUPConfig *config;
    dispatch_sync(self.queue, ^{
        [self createTable];
        config = [self readConfigFromDatabase];
    });
    return config;
}

- (void)setConfig:(FUPConfig *)config
{
    async(self.queue, ^{
        [self createTable];
        NSString *insertStatement = [NSString stringWithFormat:
                                     @"INSERT OR REPLACE INTO config\
                                        (id, enabled) \
                                        values ('UNIQUE_ID', \"%@\")", [NSNumber numberWithBool:config.isEnabled]];
        BOOL success = [self.sqlite runStatement:insertStatement];
        if (success) {
            NSLog(@"[FUPConfigStorage] Config stored");
        } else {
            NSLog(@"[FUPConfigStorage] There was an error inserting a new config value");
        }
    });
}

- (void)clear
{
    async(self.queue, ^{
        [self createTable];
        BOOL success = [self.sqlite runStatement:@"DELETE FROM config WHERE id = 'UNIQUE_ID')"];
        if (success) {
            NSLog(@"[FUPConfigStorage] Config deleted");
        } else {
            NSLog(@"[FUPConfigStorage] There was an error deleting the stored config");
        }
    });
}

- (FUPConfig *)readConfigFromDatabase
{
    __block FUPConfig *config;
    NSString *query = @"SELECT * FROM config";

    BOOL success = [self.sqlite runQuery:query block:^BOOL(sqlite3_stmt *statement) {
        int rawValue = sqlite3_column_int(statement, 1);
        BOOL isEnabled = [[NSNumber numberWithInt:rawValue] boolValue];
        config = [[FUPConfig alloc] initWithIsEnabled:isEnabled];
        return NO;
    }];

    if (success) {
        return config;
    } else {
        return [[FUPConfig alloc] initWithIsEnabled:YES];
    }
}

- (void)createTable
{
    BOOL isTableCreated = [[NSUserDefaults standardUserDefaults] boolForKey:TableCreatedKey];

    if (!isTableCreated) {
        NSString *createTableStatement =
            @"CREATE TABLE IF NOT EXISTS config(\
                id TEXT NOT NULL PRIMARY KEY DEFAULT 'UNIQUE_ID', \
                enabled INTEGER DEFAULT 1)";
        [self.sqlite runStatement:createTableStatement];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:TableCreatedKey];
    }
}

@end
