//
//  FUPSqlite.m
//  SDK
//
//  Created by Sergio Gutiérrez on 31/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPSqlite.h"

static NSString *const TableCreatedKeyFormat = @"FlowUp.%@TableCreated";

@interface FUPSqlite ()

@property (readonly, nonatomic) dispatch_queue_t queue;
@property (readonly, nonatomic) NSString *fileName;

@end

@implementation FUPSqlite

- (instancetype)initWithFileName:(NSString *)fileName
{
    self = [super init];
    if (self) {
        _queue = dispatch_queue_create("SQLit access Queue", DISPATCH_QUEUE_SERIAL);
        _fileName = fileName;
    }
    return self;
}

- (sqlite3 *)db
{
    static sqlite3 *db;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        NSString *dbPath = [self databasePath];
        if (sqlite3_open([dbPath UTF8String], &db) != SQLITE_OK) {
            NSLog(@"[FUPConfigStorage] Unable to open a database connection");
        }
    });

    return db;
}

- (BOOL)runStatement:(NSString *)statement
{
    __block BOOL success;

    async(self.queue, ^{
        char *error;
        success = sqlite3_exec(self.db, [statement UTF8String], nil, nil, &error) == SQLITE_OK;

        if (!success) {
            NSLog(@"[FUPSqlite] There was an error running \"%@\" in SQLite: %s", statement, error);
            sqlite3_free(error);
        }
    });

    return success;
}

- (BOOL)runQuery:(NSString *)query block:(BOOL (^)(sqlite3_stmt *))block
{
    __block BOOL success = YES;

    dispatch_sync(self.queue, ^{
        sqlite3_stmt *statement = nil;

        if (sqlite3_prepare_v2(self.db, [query UTF8String], -1, &statement, nil) != SQLITE_OK) {
            NSLog(@"[FUPSqlite] There was an error performing query \"%@\"", query);
            success = NO;
            return;
        }

        if (sqlite3_step(statement) != SQLITE_ROW) {
            NSLog(@"[FUPSqlite] There was no item stored for query \"%@\"", query);
            success = NO;
            return;
        }

        BOOL shouldGoToNext;
        do {
            shouldGoToNext = block(statement);
            shouldGoToNext &= sqlite3_step(statement) == SQLITE_ROW;
        } while (shouldGoToNext);
    });

    return success;
}

- (void)createTable:(NSString *)tableName withStatement:(NSString *)statement
{
    NSString *tableCreatedKey = [NSString stringWithFormat:TableCreatedKeyFormat, tableName];
    BOOL isTableCreated = [[NSUserDefaults standardUserDefaults] boolForKey:tableCreatedKey];

    if (!isTableCreated) {
        [self runStatement:statement];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:tableCreatedKey];
    }
}

- (NSString *)databasePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.fileName];
    NSString *destinationPath = [documentDirectory stringByAppendingPathComponent:self.fileName];
    [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:nil];
    return destinationPath;
}

@end
