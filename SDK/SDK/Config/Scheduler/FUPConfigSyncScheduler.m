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

@property (readonly, nonatomic) FUPConfigService *configService;
@property (readonly, nonatomic) TimeProvider *time;
@property (readwrite, nonatomic) NSTimeInterval lastSyncTimeInterval;

@end

@implementation FUPConfigSyncScheduler

- (instancetype)initWithConfigService:(FUPConfigService *)configService
                                 time:(TimeProvider *)time
{
    self = [super init];
    if (self) {
        _configService = configService;
        _time = time;
    }
    return self;
}

- (void)start
{
    NSLog(@"[FUPConfigSyncScheduler] Start");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ConfigSyncSchedulerFirstReportDelayTimeInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self sync];
        });
    });

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

    [self.configService updateWithCompletion:^(BOOL success) {
        if (success) {
            self.lastSyncTimeInterval = [self.time now];
        }
    }];
}

@end
