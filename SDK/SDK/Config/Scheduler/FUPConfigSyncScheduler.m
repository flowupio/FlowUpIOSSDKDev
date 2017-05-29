//
//  FUPConfigSyncScheduler.m
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPConfigSyncScheduler.h"

static NSTimeInterval const NeverSynced = -1;

@interface FUPConfigSyncScheduler ()

@property (readonly, nonatomic) FUPFlowUpConfig *config;
@property (readonly, nonatomic) TimeProvider *time;
@property (readwrite, nonatomic) NSTimeInterval lastSyncTimeInterval;

@end

@implementation FUPConfigSyncScheduler

- (instancetype)initWithConfig:(FUPFlowUpConfig *)config
                          time:(TimeProvider *)time
{
    self = [super init];
    if (self) {
        _config = config;
        _time = time;
    }
    return self;
}

- (void)start
{
    NSLog(@"[FUPConfigSyncScheduler] Start");
    [NSTimer scheduledTimerWithTimeInterval:ConfigSyncSchedulerSyncingTimeInterval repeats:YES block:^(NSTimer *timer) {
        async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self sync];
        });
    }];
}

- (void)sync
{
    NSLog(@"[FUPConfigSyncScheduler] Sync'ing config");

    if (self.lastSyncTimeInterval != NeverSynced && [self.time now] - self.lastSyncTimeInterval < ConfigSyncSchedulerTimeBetweenSyncsTimeInterval) {
        NSLog(@"[FUPConfigSyncScheduler] Did not pass enought time to sync");
        return;
    }

    [self.config updateWithCompletion:^(BOOL success) {
        if (success) {
            self.lastSyncTimeInterval = [self.time now];
        }
    }];
}

@end
