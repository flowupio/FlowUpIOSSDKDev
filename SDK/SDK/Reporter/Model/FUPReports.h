//
//  FUPReports.h
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPCpuMetric.h"

@interface FUPReports : NSObject

@property (readonly, nonatomic, copy) NSString *appPackage;
@property (readonly, nonatomic, copy) NSString *installationUuid;
@property (readonly, nonatomic, copy) NSString *deviceModel;
@property (readonly, nonatomic, copy) NSString *screenDensity;
@property (readonly, nonatomic, copy) NSString *screenSize;
@property (readonly, nonatomic) NSInteger numberOfCores;
@property (readonly, nonatomic, copy) NSArray<FUPCpuMetric *> *cpuMetrics;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithAppPackage:(NSString *)appPackage
                  installationUuid:(NSString *)installationUuid
                       deviceModel:(NSString *)deviceModel
                     screenDensity:(NSString *)screenDensity
                        screenSize:(NSString *)screenSize
                     numberOfCores:(NSInteger)numberOfCores
                        cpuMetrics:(NSArray<FUPCpuMetric *> *)cpuMetrics;

@end