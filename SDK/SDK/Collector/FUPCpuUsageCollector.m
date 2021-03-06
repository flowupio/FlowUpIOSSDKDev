//
//  FUPCpuUsageCollector.m
//  SDK
//
//  Created by Sergio Gutiérrez on 23/05/17.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPCpuUsageCollector.h"

@interface FUPCpuUsageCollector ()

@property (readonly, nonatomic) FUPMetricsStorage *storage;
@property (readonly, nonatomic) FUPDevice *device;
@property (readonly, nonatomic) FUPTime *time;

@end

@implementation FUPCpuUsageCollector

- (instancetype)initWithMetricsStorage:(FUPMetricsStorage *)metricsStorage
                                device:(FUPDevice *)device
                                  time:(FUPTime *)time
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
    FUPMetric *metric = [[FUPMetric alloc] initWithTimestamp:[self.time nowInMillis]
                                              appVersionName:self.device.appVersionName
                                                   osVersion:self.device.osVersion
                                       isLowPowerModeEnabled:self.device.isLowPowerModeEnabled
                                                    cpuUsage:cpuUsage * 100];
    [self.storage storeMetric:metric];
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
            NSLog(@"[FUPCpuUsageCollector] Error retrieving app CPU usage: %d", kr);
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
        NSLog(@"[FUPCpuUsageCollector] Error retrieving app threads info: %d", result);
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
