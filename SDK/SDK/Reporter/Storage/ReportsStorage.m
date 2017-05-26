//
//  ReportsStorage.m
//  SDK
//
//  Created by Sergio Gutiérrez on 26/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "ReportsStorage.h"

@interface ReportsStorage ()

@property (readonly, nonatomic) dispatch_queue_t writeQueue;
@property (readonly, nonatomic) NSMutableArray<CpuMetric *> *storedCpuMetrics;

@end

@implementation ReportsStorage


- (instancetype)init
{
    self = [super init];
    if (self) {
        _writeQueue = dispatch_queue_create("Reports Storage Write Queue", DISPATCH_QUEUE_SERIAL);
        _storedCpuMetrics = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)storeCpuMetric:(CpuMetric *)cpuMetric
{
    dispatch_async(self.writeQueue, ^{
        [self.storedCpuMetrics addObject:cpuMetric];
    });
}

- (NSArray<CpuMetric *> *)cpuMetricsAtMost:(NSInteger)numberOfCpuMetrics
{
    NSRange range = NSMakeRange(0, MIN(numberOfCpuMetrics, [self.storedCpuMetrics count]));
    return [self.storedCpuMetrics subarrayWithRange:range];
}

- (void)removeNumberOfCpuMetrics:(NSInteger)numberOfCpuMetrics
{
    NSRange range = NSMakeRange(0, MIN(numberOfCpuMetrics, [self.storedCpuMetrics count]));
    dispatch_async(self.writeQueue, ^{
        [self.storedCpuMetrics removeObjectsInRange:range];
    });
}

@end
