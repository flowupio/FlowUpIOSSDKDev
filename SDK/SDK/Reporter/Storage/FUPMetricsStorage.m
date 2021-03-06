//
//  MetricsStorage.m
//  SDK
//
//  Created by Sergio Gutiérrez on 26/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPMetricsStorage.h"

static NSString *const CreateTableStatement =
@"CREATE TABLE IF NOT EXISTS metrics( \
_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, \
timestamp FLOAT NOT NULL, \
metric_name TEXT NOT NULL, \
app_version_name TEXT NOT NULL, \
os_version TEXT NOT NULL, \
is_low_power_enabled INTEGER NOT NULL, \
additional_values TEXT NOT NULL)";

static NSUInteger const TableVersion = 1;

static NSUInteger const MaxNumberOfStoredReports = HOURS(4) / CollectorSchedulerSamplingTimeInterval;

@interface FUPMetricsStorage ()

@property (readonly, nonatomic) FUPSqlite *sqlite;
@property (readonly, nonatomic) FUPMetricsStorageMapper *mapper;

@end

@implementation FUPMetricsStorage

- (instancetype)initWithSqlite:(FUPSqlite *)sqlite
                        mapper:(FUPMetricsStorageMapper *)mapper
{
    self = [super init];
    if (self) {
        _sqlite = sqlite;
        _mapper = mapper;
    }
    return self;
}

- (void)storeMetric:(FUPMetric *)metric
{
    [self.sqlite createTable:@"metrics" withVersion:TableVersion withStatement:CreateTableStatement];
    NSString *insertStatement = [NSString stringWithFormat:
                                 @"INSERT INTO metrics \
                                 (timestamp, metric_name, app_version_name, os_version, is_low_power_enabled, additional_values) \
                                 values (%f, \"%@\", \"%@\", \"%@\", %@, \"%@\")",
                                 metric.timestamp,
                                 metric.name,
                                 metric.appVersionName,
                                 metric.osVersion,
                                 [NSNumber numberWithBool:metric.isLowPowerModeEnabled],
                                 [self.mapper stringFromMetricValues:metric.values]];
    BOOL success = [self.sqlite runStatement:insertStatement];
    [self cleanOldReports];
    if (success) {
        NSLog(@"[FUPMetricsStorage] Metrics stored");
    } else {
        NSLog(@"[FUPMetricsStorage] There was an error inserting new metrics");
    }

}

- (NSArray<FUPMetric *> *)metricsAtMost:(NSInteger)numberOfCpuMetrics
{
    [self.sqlite createTable:@"metrics" withVersion:TableVersion withStatement:CreateTableStatement];
    NSMutableArray *metrics = [[NSMutableArray alloc] initWithCapacity:numberOfCpuMetrics];
    NSString *query = [NSString stringWithFormat:
                       @"SELECT * FROM metrics \
                       ORDER BY timestamp ASC \
                       LIMIT %ld", (long)numberOfCpuMetrics];
    [self.sqlite runQuery:query block:^BOOL(sqlite3_stmt *statement) {
        FUPMetric *metric = [self.mapper metricFromStatement:statement];
        if (metric != nil) {
            [metrics addObject:metric];
        } else {
            NSLog(@"[FUPMetricsStorage] Unable to read metric from SQL storage");
        }
        return YES;
    }];
    return metrics;
}

- (void)removeNumberOfMetrics:(NSInteger)numberOfMetrics
{
    [self.sqlite createTable:@"metrics" withVersion:TableVersion withStatement:CreateTableStatement];
    NSString *deleteStatement = [NSString stringWithFormat: @"DELETE FROM metrics \
                                 WHERE _id IN ( \
                                 SELECT _id FROM metrics \
                                 ORDER BY timestamp ASC \
                                 LIMIT %ld)", (long)numberOfMetrics];
    BOOL success = [self.sqlite runStatement:deleteStatement];

    if (!success) {
        NSLog(@"[FUPMetricsStorage] There was an error deleting reported metrics");
    }
}

- (void)clear
{
    [self.sqlite createTable:@"metrics" withVersion:TableVersion withStatement:CreateTableStatement];
    NSString *deleteStatement = @"DELETE FROM metrics";
    BOOL success = [self.sqlite runStatement:deleteStatement];

    if (!success) {
        NSLog(@"[FUPMetricsStorage] There was an error deleting all reported metrics");
    }
}

- (BOOL)hasReports
{
    return [self numberOfReports] > 0;
}

- (int)numberOfReports
{
    [self.sqlite createTable:@"metrics" withVersion:TableVersion withStatement:CreateTableStatement];
    __block int numberOfReports = 0;
    NSString *query = @"SELECT COUNT(*) FROM metrics";
    [self.sqlite runQuery:query block:^BOOL(sqlite3_stmt *statement) {
        numberOfReports = sqlite3_column_int(statement, 0);
        return NO;
    }];
    return numberOfReports;
}

- (void)cleanOldReports
{
    [self.sqlite createTable:@"metrics" withVersion:TableVersion withStatement:CreateTableStatement];
    int numberOfReports = [self numberOfReports];
    if (numberOfReports > MaxNumberOfStoredReports) {
        [self removeNumberOfMetrics:numberOfReports - MaxNumberOfStoredReports];
    }
}

@end
