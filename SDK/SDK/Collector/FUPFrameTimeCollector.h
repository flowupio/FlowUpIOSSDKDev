//
//  FUPFrameTimeCollector.h
//  SDK
//
//  Created by Sergio Gutiérrez on 08/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPCollector.h"
#import "FUPDevice.h"
#import "FUPMetricsStorage.h"
#import "FUPTime.h"
#import "FUPCalculator.h"

@interface FUPFrameTimeCollector : NSObject <FUPCollector>

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithMetricsStorage:(FUPMetricsStorage *)metricsStorage
                                device:(FUPDevice *)device
                                  time:(FUPTime *)time
                            calculator:(FUPCalculator *)calculator;


@end
