//
//  CollectorScheduler.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "CollectorScheduler.h"

@interface CollectorScheduler ()

@property (readonly, nonatomic) dispatch_queue_t queue;

@end

@implementation CollectorScheduler

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isEnabled = YES;
        _queue = dispatch_queue_create("Collector Scheduler Queue", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)addCollectors:(NSArray<id<Collector>> *)collectors
         timeInterval:(NSTimeInterval)timeInterval
{
    for (id<Collector> collector in collectors) {
        [NSTimer scheduledTimerWithTimeInterval:timeInterval repeats:YES block:^(NSTimer *timer) {
            if (self.isEnabled) {
                dispatch_async(self.queue, ^{ [collector collect]; });
            } else {
                [timer invalidate];
            }
        }];
    }
}

@end
