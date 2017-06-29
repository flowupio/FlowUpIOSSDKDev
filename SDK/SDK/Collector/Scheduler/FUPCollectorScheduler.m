//
//  FUPCollectorScheduler.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPCollectorScheduler.h"

@interface FUPCollectorScheduler ()

@property (readonly, nonatomic) FUPSafetyNet *safetyNet;
@property (readonly, nonatomic) FUPConfigService *configService;
@property (readonly, nonatomic) dispatch_queue_t queue;

@end

@implementation FUPCollectorScheduler

- (instancetype)initWithSafetyNet:(FUPSafetyNet *)safetyNet
                    configService:(FUPConfigService *)configService
{
    self = [super init];
    if (self) {
        _safetyNet = safetyNet;
        _configService = configService;
        _queue = dispatch_queue_create("Collector Scheduler Queue", DISPATCH_QUEUE_CONCURRENT);
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
                    async(self.queue, ^{ [collector collect]; });
                }
            }];
        }];
    }
}

@end
