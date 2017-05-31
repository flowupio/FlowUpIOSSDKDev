//
//  FUPMetricsStorageTests.m
//  SDK
//
//  Created by Sergio Gutiérrez on 31/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "MetricsStorage.h"
#import <Nimble/Nimble.h>
@import Nimble.Swift;

@interface FUPMetricsStorageTests : XCTestCase

@property (readwrite, nonatomic) FUPSqlite *sqlite;
@property (readwrite, nonatomic) MetricsStorage *storage;

@end

@implementation FUPMetricsStorageTests

- (void)setUp {
    [super setUp];
    self.sqlite = [[FUPSqlite alloc] initWithFileName:@"testingdb.sqlite"];
    self.storage = [[MetricsStorage alloc] initWithSqlite:self.sqlite];
}

- (void)tearDown {
    [self.storage clear];
    [super tearDown];
}

- (void)testMetricsStorage_ReturnsMetricsStored_IfRetrievingOneMetric
{
    CpuMetric *metric = [self anyCpuMetric];
    [self.storage storeCpuMetric:metric];

    NSArray<CpuMetric *> *metrics = [self.storage cpuMetricsAtMost:1];

    expect(metrics.count).to(equal(1));
    expect(metrics[0].timestamp).to(equal(metric.timestamp));
    expect(metrics[0].appVersionName).to(equal(metric.appVersionName));
    expect(metrics[0].name).to(equal(metric.name));
    expect(metrics[0].osVersion).to(equal(metric.osVersion));
    expect(metrics[0].isLowPowerModeEnabled).to(equal(metric.isLowPowerModeEnabled));
    expect(metrics[0].cpuUsage).to(equal(metric.cpuUsage));
}

- (void)testMetricsStorage_ReturnsAllMetricsStored_IfRetrievingAllMetrics
{
    [self.storage storeCpuMetric:[self cpuMetricWithUsage:100]];
    [self.storage storeCpuMetric:[self cpuMetricWithUsage:101]];
    [self.storage storeCpuMetric:[self cpuMetricWithUsage:102]];

    NSArray<CpuMetric *> *metrics = [self.storage cpuMetricsAtMost:3];

    expect(metrics.count).to(equal(3));
    expect(metrics[0].cpuUsage).to(equal(100));
    expect(metrics[1].cpuUsage).to(equal(101));
    expect(metrics[2].cpuUsage).to(equal(102));
}

- (void)testMetricsStorage_ReturnsOnlyNumberOfMetricsSpecified_IfRetrievingOnlyThatNumberOfMetrics
{
    [self.storage storeCpuMetric:[self anyCpuMetric]];
    [self.storage storeCpuMetric:[self anyCpuMetric]];
    [self.storage storeCpuMetric:[self anyCpuMetric]];

    NSArray<CpuMetric *> *metrics = [self.storage cpuMetricsAtMost:1];

    expect(metrics.count).to(equal(1));
}

- (void)testMetricsStorage_ReturnsAllMetricsStored_IfRetrievingMoreThanStoredMetrics
{
    [self.storage storeCpuMetric:[self anyCpuMetric]];

    NSArray<CpuMetric *> *metrics = [self.storage cpuMetricsAtMost:5];

    expect(metrics.count).to(equal(1));
}

- (void)testMetricsStorage_DeletesMetrics_IfCleared
{
    [self.storage storeCpuMetric:[self anyCpuMetric]];

    [self.storage clear];

    expect(self.storage.hasReports).to(beFalse());
}

- (void)testMetricsStorage_DeletesMetrics_IfRemoved
{
    [self.storage storeCpuMetric:[self anyCpuMetric]];

    [self.storage removeNumberOfCpuMetrics:1];

    expect(self.storage.hasReports).to(beFalse());
}

- (void)testMetricsStorage_DeletesOnlyNumberOfMetricsSpecified_IfRemoveThatNumberOfMetrics
{
    [self.storage storeCpuMetric:[self anyCpuMetric]];
    [self.storage storeCpuMetric:[self anyCpuMetric]];
    [self.storage storeCpuMetric:[self anyCpuMetric]];

    [self.storage removeNumberOfCpuMetrics:1];

    NSArray<CpuMetric *> *metrics = [self.storage cpuMetricsAtMost:2];
    expect(metrics.count).to(equal(2));
}

- (void)testMetricsStorage_DeletesAllMetricsStored_IfRemovingMoreThanStoredMetrics
{
    [self.storage storeCpuMetric:[self anyCpuMetric]];

    [self.storage removeNumberOfCpuMetrics:5];

    expect(self.storage.hasReports).to(beFalse());
}

- (void)testMetricsStorage_ReportsThatHasMetrics_IfPreviouslyStoredMetrics
{
    [self.storage storeCpuMetric:[self anyCpuMetric]];

    expect(self.storage.hasReports).to(beTrue());
}

- (CpuMetric *)anyCpuMetric
{
    return [self cpuMetricWithUsage:12];
}

- (CpuMetric *)cpuMetricWithUsage:(NSInteger)cpuUsage
{
    return [[CpuMetric alloc] initWithTimestamp:1234
                                 appVersionName:@"Testing App"
                                      osVersion:@"10.0.0"
                          isLowPowerModeEnabled:NO
                                       cpuUsage:cpuUsage];
}

@end
