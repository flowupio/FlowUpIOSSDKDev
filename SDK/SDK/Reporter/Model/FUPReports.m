//
//  FUPReports.m
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPReports.h"

@implementation FUPReports

- (instancetype)initWithAppPackage:(NSString *)appPackage
                  installationUuid:(NSString *)installationUuid
                       deviceModel:(NSString *)deviceModel
                     screenDensity:(NSString *)screenDensity
                        screenSize:(NSString *)screenSize
                     numberOfCores:(NSInteger)numberOfCores
                        cpuMetrics:(NSArray<FUPMetric *> *)cpuMetrics
                         uiMetrics:(NSArray<FUPMetric *> *)uiMetrics
                       diskMetrics:(NSArray<FUPMetric *> *)diskMetrics
                     memoryMetrics:(NSArray<FUPMetric *> *)memoryMetrics
{
    self = [super init];
    if (self) {
        _appPackage = appPackage;
        _installationUuid = installationUuid;
        _deviceModel = deviceModel;
        _screenDensity = screenDensity;
        _screenSize = screenSize;
        _numberOfCores = numberOfCores;
        _cpuMetrics = cpuMetrics;
        _uiMetrics = uiMetrics;
        _diskMetrics = diskMetrics;
        _memoryMetrics = memoryMetrics;
    }
    return self;
}

@end
