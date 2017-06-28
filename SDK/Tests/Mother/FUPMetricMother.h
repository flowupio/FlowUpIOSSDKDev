//
//  FUPMetricMother.h
//  SDK
//
//  Created by Sergio Gutiérrez on 26/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPMetric.h"

@interface FUPMetricMother : NSObject

+ (FUPMetric *)any;
+ (FUPMetric *)anyCpu;
+ (FUPMetric *)anyCpuWithCpuUsage:(NSInteger)cpuUsage;
+ (FUPMetric *)anyUi;
+ (FUPMetric *)anyUiWithMeanFrameTime:(double)meanFrameTime
                         p10FrameTime:(double)p10FrameTime
                         p90FrameTime:(double)p90FrameTime;
+ (FUPMetric *)anyDisk;
+ (FUPMetric *)anyDiskWithDiskUsageInBytes:(NSUInteger)diskUsageInBytes
                   userDefaultsSizeInBytes:(NSUInteger)userDefaultsSizeInBytes;

@end
