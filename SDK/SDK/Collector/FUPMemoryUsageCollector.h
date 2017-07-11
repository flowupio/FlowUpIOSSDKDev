//
//  FUPMemoryUsageCollector.h
//  SDK
//
//  Created by Sergio Gutiérrez on 10/07/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <mach/vm_statistics.h>
#include <mach/mach.h>
#include <mach/processor_info.h>
#include <mach/mach_host.h>
#import "FUPCollector.h"
#import "FUPCollector.h"
#import "FUPMetricsStorage.h"
#import "FUPDevice.h"
#import "FUPTime.h"

@interface FUPMemoryUsageCollector : NSObject <FUPCollector>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithMetricsStorage:(FUPMetricsStorage *)metricsStorage
                                device:(FUPDevice *)device
                                  time:(FUPTime *)time;

@end
