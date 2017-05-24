//
//  CPUUsageCollector.m
//  SDK
//
//  Created by Sergio Gutiérrez on 23/05/17.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "CPUUsageCollector.h"

@implementation CPUUsageCollector

- (instancetype)init
{
    self = [super init];
    if (self) {}
    return self;
}

- (void)start
{
    float cpuUsage = self.cpuUsage;
    NSLog(@"CPU: %f", cpuUsage);
}

- (float)cpuUsage
{
    NSArray *threads = [self threadsBasicInfo];
    NSLog(@"Threads: %@", threads);

    float result = 0;
    for (NSValue *thread in threads) {
        thread_basic_info_data_t threadInfo;
        [thread getValue:&threadInfo];
        float cpuUsage = threadInfo.cpu_usage;
        result += cpuUsage / TH_USAGE_SCALE;
    }

    NSLog(@"CPU usage: %f", result);

    return result * 100;
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
