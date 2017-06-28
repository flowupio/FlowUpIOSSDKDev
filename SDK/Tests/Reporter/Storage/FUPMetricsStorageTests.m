//
//  FUPMetricsStorageTests.m
//  SDK
//
//  Created by Sergio Gutiérrez on 31/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FUPMetricsStorage.h"
#import "FUPMetricMother.h"
#import <Nimble/Nimble.h>
@import Nimble.Swift;

@interface FUPMetricsStorageTests : XCTestCase

@property (readwrite, nonatomic) FUPSqlite *sqlite;
@property (readwrite, nonatomic) FUPMetricsStorage *storage;

@end

@implementation FUPMetricsStorageTests

- (void)setUp {
    [super setUp];
    FUPMetricsStorageMapper *mapper = [[FUPMetricsStorageMapper alloc] init];
    self.sqlite = [[FUPSqlite alloc] initWithFileName:@"testingdb.sqlite"];
    self.storage = [[FUPMetricsStorage alloc] initWithSqlite:self.sqlite
                                                      mapper:mapper];
}

- (void)tearDown {
    [self.storage clear];
    [super tearDown];
}

- (void)testMetricsStorage_ReturnsMetricsStored_IfRetrievingOneMetric
{
    FUPMetric *metric = [FUPMetricMother any];
    [self.storage storeMetric:metric];

    NSArray<FUPMetric *> *metrics = [self.storage metricsAtMost:1];

    expect(metrics.count).to(equal(1));
    expect(metrics[0].timestamp).to(equal(metric.timestamp));
    expect(metrics[0].appVersionName).to(equal(metric.appVersionName));
    expect(metrics[0].name).to(equal(metric.name));
    expect(metrics[0].osVersion).to(equal(metric.osVersion));
    expect(metrics[0].isLowPowerModeEnabled).to(equal(metric.isLowPowerModeEnabled));
    expect(metrics[0].values).to(equal(metric.values));
}

- (void)testMetricsStorage_ReturnsAllMetricsStored_IfRetrievingAllMetrics
{
    [self.storage storeMetric:[FUPMetricMother anyCpuWithCpuUsage:100]];
    [self.storage storeMetric:[FUPMetricMother anyCpuWithCpuUsage:101]];
    [self.storage storeMetric:[FUPMetricMother anyCpuWithCpuUsage:102]];

    NSArray<FUPMetric *> *metrics = [self.storage metricsAtMost:3];

    expect(metrics.count).to(equal(3));
    expect(metrics[0].values).to(equal(@{@"consumption": @100}));
    expect(metrics[1].values).to(equal(@{@"consumption": @101}));
    expect(metrics[2].values).to(equal(@{@"consumption": @102}));
}

- (void)testMetricsStorage_ReturnsOnlyNumberOfMetricsSpecified_IfRetrievingOnlyThatNumberOfMetrics
{
    [self.storage storeMetric:[FUPMetricMother any]];
    [self.storage storeMetric:[FUPMetricMother any]];
    [self.storage storeMetric:[FUPMetricMother any]];

    NSArray<FUPMetric *> *metrics = [self.storage metricsAtMost:1];

    expect(metrics.count).to(equal(1));
}

- (void)testMetricsStorage_ReturnsAllMetricsStored_IfRetrievingMoreThanStoredMetrics
{
    [self.storage storeMetric:[FUPMetricMother any]];

    NSArray<FUPMetric *> *metrics = [self.storage metricsAtMost:5];

    expect(metrics.count).to(equal(1));
}

- (void)testMetricsStorage_DeletesMetrics_IfCleared
{
    [self.storage storeMetric:[FUPMetricMother any]];

    [self.storage clear];

    expect(self.storage.hasReports).to(beFalse());
}

- (void)testMetricsStorage_DeletesMetrics_IfRemoved
{
    [self.storage storeMetric:[FUPMetricMother any]];

    [self.storage removeNumberOfMetrics:1];

    expect(self.storage.hasReports).to(beFalse());
}

- (void)testMetricsStorage_DeletesOnlyNumberOfMetricsSpecified_IfRemoveThatNumberOfMetrics
{
    [self.storage storeMetric:[FUPMetricMother any]];
    [self.storage storeMetric:[FUPMetricMother any]];
    [self.storage storeMetric:[FUPMetricMother any]];

    [self.storage removeNumberOfMetrics:1];

    NSArray<FUPMetric *> *metrics = [self.storage metricsAtMost:2];
    expect(metrics.count).to(equal(2));
}

- (void)testMetricsStorage_DeletesAllMetricsStored_IfRemovingMoreThanStoredMetrics
{
    [self.storage storeMetric:[FUPMetricMother any]];

    [self.storage removeNumberOfMetrics:5];

    expect(self.storage.hasReports).to(beFalse());
}

- (void)testMetricsStorage_ReportsThatHasMetrics_IfPreviouslyStoredMetrics
{
    [self.storage storeMetric:[FUPMetricMother any]];

    expect(self.storage.hasReports).to(beTrue());
}

- (void)testMetricsStorage_NeverStoresMoreThanMaximumNumberOfReports
{
    for (int i = 0; i < 1001; i++) {
        [self.storage storeMetric:[FUPMetricMother any]];
    }

    NSArray<FUPMetric *> *metrics = [self.storage metricsAtMost:1001];

    expect(metrics.count).to(equal(1000));
}

@end
