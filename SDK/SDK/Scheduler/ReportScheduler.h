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

@interface ReportScheduler : NSObject

@property (readonly, nonatomic) Device *device;
@property (readonly, nonatomic) ReportApiClient *reportApiClient;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDevice:(Device*)device
               reportApiClient:(ReportApiClient *)reportApiClient;

- (void)start;

@end
