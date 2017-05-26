//
//  CpuUsageCollector.m
//  SDK
//
//  Created by Sergio Gutiérrez on 23/05/17.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "CpuUsageCollector.h"

@interface CpuUsageCollector ()

@property (readonly, nonatomic) MetricsStorage *storage;
@property (readonly, nonatomic) Device *device;
@property (readonly, nonatomic) TimeProvider *time;

@end

@implementation CpuUsageCollector

- (instancetype)initWithMetricsStorage:(MetricsStorage *)metricsStorage
                                device:(Device *)device
                                  time:(TimeProvider *)time
{
    self = [super init];
    if (self) {
        _storage = metricsStorage;
        _device = device;
        _time = time;
    }
    return self;
}

- (void)collect
{
    float cpuUsage = self.cpuUsage;
    CpuMetric *metric = [[CpuMetric alloc] initWithTimestamp:self.time.nowAsInt
                                              appVersionName:self.device.appVersionName
                                                   osVersion:self.device.osVersion
                                       isLowPowerModeEnabled:self.device.isLowPowerModeEnabled
                                                    cpuUsage:cpuUsage * 100];
    [self.storage storeCpuMetric:metric];
}

- (float)cpuUsage
{
    NSArray *threads = [self threadsBasicInfo];

    float result = 0;
    for (NSValue *thread in threads) {
        thread_basic_info_data_t threadInfo;
        [thread getValue:&threadInfo];
        float cpuUsage = threadInfo.cpu_usage;
        result += cpuUsage / TH_USAGE_SCALE;
    }

    return result;
}

- (NSArray *)threadsBasicInfo
{
    NSMutableArray *result = [[NSMutableArray alloc] init];

    thread_info_data_t threadInfo;
    mach_msg_type_number_t threadInfoCount[128];

    for (NSNumber *actPointer in [self threadsActPointers]) {
        *threadInfoCount = THREAD_INFO_MAX;
        kern_return_t kr = thread_info(actPointer.unsignedIntValue, THREAD_BASIC_INFO, threadInfo, threadInfoCount);

        if (kr != KERN_SUCCESS) {
            return @[];
        }

        [result addObject:[NSValue valueWithBytes:threadInfo objCType:@encode(thread_basic_info_data_t)]];
    }

    return result;
}

- (NSArray *)threadsActPointers
{
    NSMutableArray *threadsAct = [[NSMutableArray alloc] init];

    thread_act_array_t threadsArray;
    mach_msg_type_number_t count;

    kern_return_t result = task_threads(mach_task_self_, &threadsArray, &count);

    if (result != KERN_SUCCESS) {
        return threadsAct;
    }

    if (threadsArray == nil) {
        return threadsAct;
    }

    for (int i = 0; i < count; i++) {
        [threadsAct addObject:[NSNumber numberWithInt:threadsArray[i]]];
    }

    return threadsAct;
}

@end
