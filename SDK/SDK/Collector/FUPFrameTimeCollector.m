//
//  FUPFrameTimeCollector.m
//  SDK
//
//  Created by Sergio Gutiérrez on 08/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPFrameTimeCollector.h"

static NSTimeInterval const NoTimeReported = -1;

@interface FUPFrameTimeCollector ()

@property (readonly, nonatomic) FUPMetricsStorage *storage;
@property (readonly, nonatomic) FUPDevice *device;
@property (readonly, nonatomic) FUPTime *time;
@property (readonly, nonatomic) NSMutableArray<NSNumber *> *values;
@property (readwrite, nonatomic) NSTimeInterval lastReportedTime;

@end

@implementation FUPFrameTimeCollector

- (instancetype)initWithMetricsStorage:(FUPMetricsStorage *)metricsStorage
                                device:(FUPDevice *)device
                                  time:(FUPTime *)time
{
    self = [super init];
    if (self) {
        _storage = metricsStorage;
        _device = device;
        _time = time;
        _values = [[NSMutableArray alloc] init];
        _lastReportedTime = NoTimeReported;
    }
    return self;
}

- (void)collect
{
    [self displayLink].paused = NO;

    if (self.values.count > 0) {
        NSLog(@"Collecting frame time metrics: %lu", (unsigned long)self.values.count);
        [self.values removeAllObjects];
        // TODO Store metric
    }
}

- (void)displayLinkDidUpdate
{
    if (self.lastReportedTime == NoTimeReported) {
        self.lastReportedTime = [self displayLink].timestamp;
        return;
    }

    NSTimeInterval interval = [self displayLink].timestamp - self.lastReportedTime;
    [self.values addObject:[NSNumber numberWithDouble:interval]];

    self.lastReportedTime = [self displayLink].timestamp;
}

- (CADisplayLink *)displayLink
{
    static CADisplayLink *_displayLink;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkDidUpdate)];
        _displayLink.paused = YES;
        [_displayLink addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
    });

    return _displayLink;
}

@end
