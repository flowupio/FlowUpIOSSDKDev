//
//  FUPDiskUsageCollector.m
//  SDK
//
//  Created by Sergio Gutiérrez on 09/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPDiskUsageCollector.h"

@interface FUPDiskUsageCollector ()

@property (readonly, nonatomic) FUPMetricsStorage *storage;
@property (readonly, nonatomic) FUPDevice *device;
@property (readonly, nonatomic) FUPTime *time;

@end

@implementation FUPDiskUsageCollector

- (instancetype)initWithMetricsStorage:(FUPMetricsStorage *)metricsStorage
                                device:(FUPDevice *)device
                                  time:(FUPTime *)time
{
    self = [super init];
    if (self) {
        _storage = metricsStorage;
        _device = device;
        _time = time;
    }
    return self;
}

- (void)collect
{
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    if (paths.count <= 0) {
        return;
    }

    NSString *path = paths.lastObject;
    NSUInteger size = 0;
    for (NSString *subpath in [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:nil]) {
        NSString *completeSubpath = [NSString stringWithFormat:@"%@/%@", path, subpath];
        size += [[[NSFileManager defaultManager] attributesOfItemAtPath:completeSubpath
                                                                  error:nil]
                 fileSize];
    }

    FUPMetric *metric = [[FUPMetric alloc] initWithTimestamp:[self.time nowInMillis]
                                              appVersionName:self.device.appVersionName
                                                   osVersion:self.device.osVersion
                                       isLowPowerModeEnabled:self.device.isLowPowerModeEnabled
                                                   diskUsage:size];
    [self.storage storeMetric:metric];
}

@end
