//
//  FUPCollectorScheduler.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPCollectorScheduler.h"

@interface FUPCollectorScheduler ()

@property (readonly, nonatomic) dispatch_queue_t queue;

@end

@implementation FUPCollectorScheduler

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isEnabled = YES;
        _queue = dispatch_queue_create("Collector Scheduler Queue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)addCollectors:(NSArray<id<FUPCollector>> *)collectors
         timeInterval:(NSTimeInterval)timeInterval
{
    NSLog(@"[CollectorScheduler] Start");
    for (id<FUPCollector> collector in collectors) {
        [NSTimer scheduledTimerWithTimeInterval:timeInterval repeats:YES block:^(NSTimer *timer) {
            if (self.isEnabled) {
                NSLog(@"[CollectorScheduler] Collect");
                async(self.queue, ^{ [collector collect]; });
            } else {
                NSLog(@"[CollectorScheduler] Disabled");
                [timer invalidate];
            }
        }];
    }
}

@end
