//
//  FUPCollectorScheduler.h
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPCollector.h"
#import "FUPAsync.h"
#import "FUPSafetyNet.h"
#import "FUPConfigService.h"
#import "FUPQueueStorage.h"

@interface FUPCollectorScheduler : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSafetyNet:(FUPSafetyNet *)safetyNet
                    configService:(FUPConfigService *)configService
                     queueStorage:(FUPQueueStorage *)queueStorage;

- (void)addCollectors:(NSArray<id<FUPCollector>> *)collectors
         timeInterval:(NSTimeInterval)timeInterval;

@end
