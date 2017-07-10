//
//  FUPMemoryUsageCollector.m
//  SDK
//
//  Created by Sergio Gutiérrez on 10/07/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPMemoryUsageCollector.h"

@interface FUPMemoryUsageCollector ()

@property (readonly, nonatomic) FUPMetricsStorage *storage;
@property (readonly, nonatomic) FUPDevice *device;
@property (readonly, nonatomic) FUPTime *time;

@end

@implementation FUPMemoryUsageCollector

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
    unsigned long long memoryUsageInBytes = [self memoryUsageInBytes];
    float memoryUsageInPercent = ((float) memoryUsageInBytes) / [NSProcessInfo processInfo].physicalMemory;
    FUPMetric *metric = [[FUPMetric alloc] initWithTimestamp:[self.time nowInMillis]
                                              appVersionName:self.device.appVersionName
                                                   osVersion:self.device.osVersion
                                       isLowPowerModeEnabled:self.device.isLowPowerModeEnabled
                                          memoryUsageInBytes:memoryUsageInBytes
                                        memoryUsageInPercent:memoryUsageInPercent * 100];
    [self.storage storeMetric:metric];
}

- (unsigned long long)memoryUsageInBytes
{
    struct mach_task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t result = task_info(mach_task_self_, MACH_TASK_BASIC_INFO, (task_info_t)&info, &size);

    if (result != KERN_SUCCESS) {
        NSLog(@"[FUPMemoryUsageCollector] Error retrieving app memory usage: %d", result);
        return 0;
    }

    return info.resident_size;
}

@end
