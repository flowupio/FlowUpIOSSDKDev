//
//  FUPCollectorScheduler.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPCollectorScheduler.h"

static NSString *const QueueName = @"Collector Scheduler Queue";

@interface FUPCollectorScheduler ()

@property (readonly, nonatomic) FUPSafetyNet *safetyNet;
@property (readonly, nonatomic) FUPConfigService *configService;
@property (readonly, nonatomic) FUPQueueStorage *queueStorage;

@end

@implementation FUPCollectorScheduler

- (instancetype)initWithSafetyNet:(FUPSafetyNet *)safetyNet
                    configService:(FUPConfigService *)configService
                     queueStorage:(FUPQueueStorage *)queueStorage
{
    self = [super init];
    if (self) {
        _safetyNet = safetyNet;
        _configService = configService;
        _queueStorage = queueStorage;
    }
    return self;
}

- (void)addCollectors:(NSArray<id<FUPCollector>> *)collectors
         timeInterval:(NSTimeInterval)timeInterval
{
    NSLog(@"[FUPCollectorScheduler] Start");
    for (id<FUPCollector> collector in collectors) {
        [NSTimer scheduledTimerWithTimeInterval:timeInterval repeats:YES block:^(NSTimer *timer) {
            NSLog(@"[FUPCollectorScheduler] Collect");
            [self.safetyNet runBlock:^{
                if (self.configService.enabled) {
                    async([self.queueStorage concurrentQueueWithName:QueueName], ^{ [collector collect]; });
                }
            }];
        }];
    }
}

@end
