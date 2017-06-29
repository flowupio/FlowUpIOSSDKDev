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
#import "FUPMetric.h"
#import "FUPMetricsStorageMapper.h"
#import "FUPTimeIntervalUnits.h"
#import "FUPConfiguration.h"

@interface FUPMetricsStorage : NSObject

@property (readonly, nonatomic) BOOL hasReports;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSqlite:(FUPSqlite *)sqlite
                        mapper:(FUPMetricsStorageMapper *)mapper;

- (void)storeMetric:(FUPMetric *)metric;
- (NSArray<FUPMetric *> *)metricsAtMost:(NSInteger)numberOfMetrics;
- (void)removeNumberOfMetrics:(NSInteger)numberOfMetrics;
- (void)clear;

@end
