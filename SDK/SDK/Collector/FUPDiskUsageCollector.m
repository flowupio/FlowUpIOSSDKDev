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
    NSString *documentsPath = [self pathAt:NSDocumentDirectory];
    NSString *libraryPath = [self pathAt:NSLibraryDirectory];
    NSString *userDefaultsFile = [NSString stringWithFormat:@"%@/Preferences/%@.plist",
                                  libraryPath,
                                  [[NSBundle mainBundle] bundleIdentifier]];

    NSUInteger diskUsageInBytes = [self sizeInBytesOf:documentsPath];
    NSUInteger userDefaultsUsageInBytes = [self sizeInBytesOfSingleFile:userDefaultsFile];

    FUPMetric *metric = [[FUPMetric alloc] initWithTimestamp:[self.time nowInMillis]
                                              appVersionName:self.device.appVersionName
                                                   osVersion:self.device.osVersion
                                       isLowPowerModeEnabled:self.device.isLowPowerModeEnabled
                                            diskUsageInBytes:diskUsageInBytes
                                     userDefaultsSizeInBytes:userDefaultsUsageInBytes];

    [self.storage storeMetric:metric];
}

- (NSUInteger)sizeInBytesOf:(NSString *)path
{
    NSUInteger size = 0;

    for (NSString *subpath in [[NSFileManager defaultManager] subpathsAtPath:path]) {
        NSString *completeSubpath = [NSString stringWithFormat:@"%@/%@", path, subpath];
        size += [self sizeInBytesOfSingleFile:completeSubpath];
    }

    return size;
}

- (NSUInteger)sizeInBytesOfSingleFile:(NSString *)fileName
{
    return [[[NSFileManager defaultManager] attributesOfItemAtPath:fileName
                                                             error:nil][NSFileSize]
            unsignedIntegerValue];
}

- (NSString *)pathAt:(NSSearchPathDirectory)pathDirectory
{
    return NSSearchPathForDirectoriesInDomains(pathDirectory, NSUserDomainMask, YES).firstObject;
}

@end
