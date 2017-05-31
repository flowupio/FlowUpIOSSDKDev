//
//  FUPSqlite.m
//  SDK
//
//  Created by Sergio Gutiérrez on 31/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPSqlite.h"

@interface FUPSqlite ()

@property (readonly, nonatomic) NSString *fileName;

@end

@implementation FUPSqlite

- (instancetype)initWithFileName:(NSString *)fileName
{
    self = [super init];
    if (self) {
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
    char *error;
    BOOL success = sqlite3_exec(self.db, [statement UTF8String], nil, nil, &error) == SQLITE_OK;

    if (!success) {
        NSLog(@"[FUPSqlite] There was an error running \"%@\" in SQLite: %s", statement, error);
        sqlite3_free(error);
    }

    return success;
}

- (BOOL)runQuery:(NSString *)query block:(BOOL (^)(sqlite3_stmt *))block
{
    sqlite3_stmt *statement = nil;

    if (sqlite3_prepare_v2(self.db, [query UTF8String], -1, &statement, nil) != SQLITE_OK) {
        NSLog(@"[FUPSqlite] There was an error performing query \"%@\"", query);
        return NO;
    }

    if (sqlite3_step(statement) != SQLITE_ROW) {
        NSLog(@"[FUPSqlite] There was no item stored for query \"%@\"", query);
        return NO;
    }

    BOOL shouldGoToNext;
    do {
        shouldGoToNext = block(statement);
        shouldGoToNext &= sqlite3_step(statement) == SQLITE_ROW;
    } while (shouldGoToNext);

    return YES;
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
