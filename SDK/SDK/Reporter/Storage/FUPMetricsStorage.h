//
//  FUPMetricsStorage.h
//  SDK
//
//  Created by Sergio Gutiérrez on 26/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPReports.h"
#import "FUPAsync.h"
#import "FUPSqlite.h"

@interface FUPMetricsStorage : NSObject

@property (readonly, nonatomic) BOOL hasReports;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSqlite:(FUPSqlite *)sqlite;

- (void)storeCpuMetric:(FUPCpuMetric *)cpuMetric;
- (NSArray<FUPCpuMetric *> *)cpuMetricsAtMost:(NSInteger)numberOfCpuMetrics;
- (void)removeNumberOfCpuMetrics:(NSInteger)numberOfCpuMetrics;
- (void)clear;

@end
