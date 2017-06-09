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

@end
