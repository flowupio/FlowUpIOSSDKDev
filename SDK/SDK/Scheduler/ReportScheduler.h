//
//  ReportScheduler.h
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Device.h"
#import "ReportApiClient.h"
#import "CpuUsageCollector.h"
#import "TimeProvider.h"

@interface ReportScheduler : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDevice:(Device*)device
               reportApiClient:(ReportApiClient *)reportApiClient
                          time:(TimeProvider *)time;

- (void)start;

@end
