//
//  MetricsStorage.h
//  SDK
//
//  Created by Sergio Gutiérrez on 26/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reports.h"

@interface MetricsStorage : NSObject

@property (readonly, nonatomic) BOOL hasReports;

- (void)storeCpuMetric:(CpuMetric *)cpuMetric;
- (NSArray<CpuMetric *> *)cpuMetricsAtMost:(NSInteger)numberOfCpuMetrics;
- (void)removeNumberOfCpuMetrics:(NSInteger)numberOfCpuMetrics;

@end
