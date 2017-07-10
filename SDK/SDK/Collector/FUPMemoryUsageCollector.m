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
    mach_vm_size_t memoryUsageInBytes = [self memoryUsageInBytes];
}

- (mach_vm_size_t)memoryUsageInBytes
{
    struct mach_task_basic_info info;
    mach_msg_type_number_t size = sizeof(info);
    kern_return_t result = task_info(mach_task_self_, MACH_TASK_BASIC_INFO, (task_info_t)&info, &size);

    if (result != KERN_SUCCESS) {
        NSLog(@"[FUPMemoryUsageCollector] Error retrieving app memory usage: %d", result);
        return 0;
    }

    NSLog(@"Virtual Memory: %@", [NSByteCountFormatter stringFromByteCount:info.virtual_size countStyle:NSByteCountFormatterCountStyleMemory]);
    NSLog(@"App Memory: %@", [NSByteCountFormatter stringFromByteCount:info.resident_size countStyle:NSByteCountFormatterCountStyleMemory]);
    NSLog(@"Total Memory: %@", [NSByteCountFormatter stringFromByteCount:[NSProcessInfo processInfo].physicalMemory countStyle:NSByteCountFormatterCountStyleMemory]);
    return info.resident_size;
}

//--------------------------------------------------------------------------
// MARK: PRIVATE FUNCTION
//--------------------------------------------------------------------------
//private static func VMStatistics64() -> vm_statistics64 {
//    var size     = HOST_VM_INFO64_COUNT
//    var hostInfo = vm_statistics64()
//
//    let result = withUnsafeMutablePointer(to: &hostInfo) {
//        $0.withMemoryRebound(to: integer_t.self, capacity: Int(size)) {
//            host_statistics64(System.machHost, HOST_VM_INFO64, $0, &size)
//        }
//    }
//#if DEBUG
//    if result != KERN_SUCCESS {
//        print("ERROR - \(#file):\(#function) - kern_result_t = "
//              + "\(result)")
//    }
//#endif
//    return hostInfo
//}

@end
