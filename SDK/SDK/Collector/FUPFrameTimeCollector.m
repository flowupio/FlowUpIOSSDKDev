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
@property (readonly, nonatomic) FUPCalculator *calculator;
@property (readonly, nonatomic) NSMutableArray<NSNumber *> *values;
@property (readwrite, nonatomic) NSTimeInterval lastReportedTime;

@end

@implementation FUPFrameTimeCollector

- (instancetype)initWithMetricsStorage:(FUPMetricsStorage *)metricsStorage
                                device:(FUPDevice *)device
                                  time:(FUPTime *)time
                            calculator:(FUPCalculator *)calculator
{
    self = [super init];
    if (self) {
        _storage = metricsStorage;
        _device = device;
        _time = time;
        _calculator = calculator;
        _values = [[NSMutableArray alloc] init];
        _lastReportedTime = NoTimeReported;
    }
    return self;
}

- (void)collect
{
    [self displayLink].paused = NO;

    if (self.values.count > 0) {
        NSNumber *mean = [NSNumber numberWithDouble:NANOS_IN_ONE_SECOND * [self.calculator meanOf:self.values].doubleValue];
        NSNumber *p10 = [NSNumber numberWithDouble:NANOS_IN_ONE_SECOND * [self.calculator percentile10Of:self.values].doubleValue];
        NSNumber *p90 = [NSNumber numberWithDouble:NANOS_IN_ONE_SECOND * [self.calculator percentile90Of:self.values].doubleValue];
        FUPStatisticalValue *frameTime = [[FUPStatisticalValue alloc] initWithMean:mean
                                                                      percentile10:p10
                                                                      percentile90:p90];
        FUPMetric *metric = [[FUPMetric alloc] initWithTimestamp:[self.time nowInMillis]
                                                  appVersionName:self.device.appVersionName
                                                       osVersion:self.device.osVersion
                                           isLowPowerModeEnabled:self.device.isLowPowerModeEnabled
                                                       frameTime:frameTime];
        [self.storage storeMetric:metric];
        [self.values removeAllObjects];
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
