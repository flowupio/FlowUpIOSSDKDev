//
//  CPUUsageCollector.m
//  FlowUpIOSSDK
//
//  Created by Sergio Gutiérrez on 23/05/17.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "CPUUsageCollector.h"



//mach_msg_type_number_t HOST_CPU_LOAD_INFO_COUNT = UInt32(MemoryLayout<host_cpu_load_info_data_t>.size / MemoryLayout<integer_t>.size)

@implementation CPUUsageCollector

- (void)start
{
    kern_return_t kr;
    mach_msg_type_number_t count;
    host_cpu_load_info_data_t r_load;

    count = HOST_CPU_LOAD_INFO_COUNT;
    kr = host_statistics(mach_host_self(), HOST_CPU_LOAD_INFO, (int *)&r_load, &count);
    if (kr != KERN_SUCCESS) {
        printf("oops: %s\n", mach_error_string(kr));
        return;
    }

    NSLog(@"system: %u", r_load.cpu_ticks[CPU_STATE_SYSTEM]);
    NSLog(@"user: %u", r_load.cpu_ticks[CPU_STATE_USER] + r_load.cpu_ticks[CPU_STATE_NICE]);
    NSLog(@"idle: %u", r_load.cpu_ticks[CPU_STATE_IDLE]);
}

@end
