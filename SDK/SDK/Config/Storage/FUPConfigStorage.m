//
//  FUPConfigStorage.m
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPConfigStorage.h"

@interface FUPConfigStorage ()

@property (readonly, nonatomic) dispatch_queue_t queue;

@end

@implementation FUPConfigStorage

- (instancetype)init
{
    self = [super init];
    if (self) {
        _queue = dispatch_queue_create("Config Storage Queue", DISPATCH_QUEUE_SERIAL);
    }
    return self;
}

- (FUPConfig *)config
{
    return [self readConfig];
}

- (void)setConfig:(FUPConfig *)config
{
    [self storeConfig:config];
}

- (void)clear
{
    dispatch_sync(self.queue, ^{
        sqlite3 *db = [self openDatabaseConnection];
        [self deleteConfigInDatabase:db];
    });
}

- (void)storeConfig:(FUPConfig *)config
{
    dispatch_sync(self.queue, ^{
        sqlite3 *db = [self openDatabaseConnection];
        [self insertConfig:config inDatabase:db];
    });
}

- (FUPConfig *)readConfig
{
    __block FUPConfig *config;
    dispatch_sync(self.queue, ^{
        sqlite3 *db = [self openDatabaseConnection];
        config = [self readConfigFromDatabase:db];
    });
    return config;
}

- (FUPConfig *)readConfigFromDatabase:(sqlite3 *)database
{
    sqlite3_stmt *statement = nil;
    NSString *selectSql = [NSString stringWithFormat:@"SELECT * FROM config"];
    const char *selectStatement = [selectSql UTF8String];

    if (sqlite3_prepare_v2(database, selectStatement, -1, &statement, nil) != SQLITE_OK) {
        NSLog(@"[FUPConfigStorage] There was an error retrieving the stored config");
        return [[FUPConfig alloc] initWithIsEnabled:YES];
    }

    if (sqlite3_step(statement) != SQLITE_ROW) {
        NSLog(@"[FUPConfigStorage] There was no config stored");
        return [[FUPConfig alloc] initWithIsEnabled:YES];
    }

    int rawValue = sqlite3_column_int(statement, 1);
    BOOL isEnabled = [[NSNumber numberWithInt:rawValue] boolValue];
    return [[FUPConfig alloc] initWithIsEnabled:isEnabled];
}

- (void)createTableInDatabase:(sqlite3 *)database
{
    const char *createTableStatement = "CREATE TABLE IF NOT EXISTS config (id TEXT NOT NULL PRIMARY KEY DEFAULT 'UNIQUE_ID', enabled INTEGER DEFAULT 1)";
    char *error;
    if (sqlite3_exec(database, createTableStatement, nil, nil, &error) == SQLITE_OK) {
        NSLog(@"[FUPConfigStorage] Config table created");
    } else {
        NSLog(@"[FUPConfigStorage] There was an error creating the config SQL table: %s", error);
        sqlite3_free(error);
    }
}

- (void)insertConfig:(FUPConfig *)config inDatabase:(sqlite3 *)database
{
    sqlite3_stmt *statement = nil;
    NSString *insertSql = [NSString stringWithFormat:@"INSERT OR REPLACE INTO config (id, enabled) values ('UNIQUE_ID', \"%@\")", [NSNumber numberWithBool:config.isEnabled]];
    const char *insertStatement = [insertSql UTF8String];
    sqlite3_prepare_v2(database, insertStatement, -1, &statement, nil);
    if (sqlite3_step(statement) == SQLITE_DONE) {
        NSLog(@"[FUPConfigStorage] Config stored");
    } else {
        NSLog(@"[FUPConfigStorage] There was an error inserting a new config value");
    }
}

- (void)deleteConfigInDatabase:(sqlite3 *)database
{
    sqlite3_stmt *statement = nil;
    NSString *deleteSql = [NSString stringWithFormat:@"DELETE FROM config WHERE id = 'UNIQUE_ID')"];
    const char *deleteStatement = [deleteSql UTF8String];
    sqlite3_prepare_v2(database, deleteStatement, -1, &statement, nil);
    if (sqlite3_step(statement) == SQLITE_DONE) {
        NSLog(@"[FUPConfigStorage] Config deleted");
    } else {
        NSLog(@"[FUPConfigStorage] There was an error deleting the stored config");
    }
}

- (NSString *)databasePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"flowupdb.sqlite"];
    NSString *destinationPath = [documentDirectory stringByAppendingPathComponent:@"flowupdb.sqlite"];
    [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:nil];
    return destinationPath;
}

- (sqlite3 *)openDatabaseConnection
{
    static sqlite3 *db;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        NSString *dbPath = [self databasePath];
        if (sqlite3_open([dbPath UTF8String], &db) == SQLITE_OK) {
            [self createTableInDatabase:db];
        } else {
            NSLog(@"[FUPConfigStorage] Unable to open a database connection");
        }
    });

    return db;
}

@end
