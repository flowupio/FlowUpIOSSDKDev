//
//  CpuUsageCollector.h
//  SDK
//
//  Created by Sergio Gutiérrez on 23/05/17.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/sysctl.h>
#include <sys/types.h>
#include <mach/mach.h>
#include <mach/processor_info.h>
#include <mach/mach_host.h>
#import "Collector.h"

@interface CpuUsageCollector : NSObject <Collector>

@property (readonly, nonatomic) float cpuUsage;

@end
