//
//  MetricsStorage.m
//  SDK
//
//  Created by Sergio Gutiérrez on 26/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "MetricsStorage.h"

static NSString *const TableCreatedKey = @"FlowUp.MetricsTableCreated";

@interface MetricsStorage ()

@property (readonly, nonatomic) dispatch_queue_t queue;
@property (readonly, nonatomic) FUPSqlite *sqlite;

@end

@implementation MetricsStorage

- (instancetype)initWithSqlite:(FUPSqlite *)sqlite
{
    self = [super init];
    if (self) {
        _queue = dispatch_queue_create("Reports Storage Write Queue", DISPATCH_QUEUE_SERIAL);
        _sqlite = sqlite;
    }
    return self;
}

- (void)storeCpuMetric:(CpuMetric *)cpuMetric
{
    async(self.queue, ^{
        [self createTable];
        NSString *insertStatement = [NSString stringWithFormat:
                                     @"INSERT INTO metrics \
                                     (timestamp, metric_name, app_version_name, os_version, is_low_power_enabled, value) \
                                     values (\"%f\", \"%@\", \"%@\", \"%@\", \"%@\", \"%d\")",
                                     cpuMetric.timestamp,
                                     cpuMetric.name,
                                     cpuMetric.appVersionName,
                                     cpuMetric.osVersion,
                                     [NSNumber numberWithBool:cpuMetric.isLowPowerModeEnabled],
                                     cpuMetric.cpuUsage];
        BOOL success = [self.sqlite runStatement:insertStatement];
        if (success) {
            NSLog(@"[MetricsStorage] Metrics stored");
        } else {
            NSLog(@"[MetricsStorage] There was an error inserting new metrics");
        }
    });
}

- (NSArray<CpuMetric *> *)cpuMetricsAtMost:(NSInteger)numberOfCpuMetrics
{
    NSMutableArray *metrics = [[NSMutableArray alloc] initWithCapacity:numberOfCpuMetrics];
    dispatch_sync(self.queue, ^{
        NSString *query = [NSString stringWithFormat:
                           @"SELECT * FROM metrics \
                           ORDER BY timestamp DESC \
                           LIMIT %d", numberOfCpuMetrics];
        [self.sqlite runQuery:query block:^BOOL(sqlite3_stmt *statement) {
            CpuMetric *metric = [[CpuMetric alloc] initWithTimestamp:sqlite3_column_double(statement, 1)
                                                      appVersionName:[NSString stringWithFormat:@"%s", sqlite3_column_text(statement, 2)]
                                                           osVersion:[NSString stringWithFormat:@"%s", sqlite3_column_text(statement, 3)]
                                               isLowPowerModeEnabled:[[NSNumber numberWithInt:sqlite3_column_int(statement, 4)] boolValue]
                                                            cpuUsage:sqlite3_column_int(statement, 5)];
            [metrics addObject:metric];
            return YES;
        }];
    });
    return metrics;
}

- (void)removeNumberOfCpuMetrics:(NSInteger)numberOfCpuMetrics
{
    async(self.queue, ^{
        NSString *deleteStatement = [NSString stringWithFormat: @"DELETE FROM metrics \
                                     WHERE _id IN ( \
                                     SELECT _id FROM metrics \
                                     ORDER BY timestamp DESC \
                                     LIMIT %d)", numberOfCpuMetrics];
        BOOL success = [self.sqlite runStatement:deleteStatement];

        if (!success) {
            NSLog(@"[MetricsStorage] There was an error deleting reported metrics");
        }
    });
}

- (void)clear
{
    async(self.queue, ^{
        NSString *deleteStatement = @"DELETE * FROM metrics";
        BOOL success = [self.sqlite runStatement:deleteStatement];

        if (!success) {
            NSLog(@"[MetricsStorage] There was an error deleting all reported metrics");
        }
    });
}

- (BOOL)hasReports
{
    __block BOOL hasReports = NO;
    dispatch_sync(self.queue, ^{
        NSString *query = @"SELECT COUNT(*) FROM metrics";
        [self.sqlite runQuery:query block:^BOOL(sqlite3_stmt *statement) {
            hasReports = sqlite3_column_int(statement, 0) > 0;
            return NO;
        }];
    });
    return hasReports;
}

- (void)createTable
{
    BOOL isTableCreated = [[NSUserDefaults standardUserDefaults] boolForKey:TableCreatedKey];

    if (!isTableCreated) {
        NSString *createTableStatement =
            @"CREATE TABLE IF NOT EXISTS metrics( \
                _id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, \
                timestamp INTEGER NOT NULL, \
                metric_name TEXT NOT NULL, \
                app_version_name TEXT NOT NULL, \
                os_version TEXT NOT NULL, \
                is_low_power_enabled INTEGER NOT NULL, \
                value INTEGER)";
        [self.sqlite runStatement:createTableStatement];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:TableCreatedKey];
    }
}

@end
