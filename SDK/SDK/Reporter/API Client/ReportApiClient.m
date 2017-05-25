//
//  ReportApiClient.m
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "ReportApiClient.h"

@interface ReportApiClient ()

@property (readonly, nonatomic) Device *device;

@end

@implementation ReportApiClient

- (instancetype)initWithBaseUrl:(NSString *)baseUrl device:(Device *)device
{
    self = [super initWithBaseUrl:baseUrl];
    if (self) {
        _device = device;
    }
    return self;

}

- (void)sendReports:(Reports *)reports completion:(void (^)(BOOL))completion
{
    [self.manager POST:[self urlStringWithEndpoint:@"report"]
            parameters:[self serializeReports:reports]
              progress:nil
               success:^(NSURLSessionDataTask *task, id responseObject) {
                   completion(YES);
               }
               failure:^(NSURLSessionDataTask *task, NSError *error) {
                   completion(NO);
               }];
}

- (NSDictionary *)serializeReports:(Reports *)reports
{
    NSMutableDictionary *serializedReports = [[NSMutableDictionary alloc] init];
    [serializedReports addEntriesFromDictionary:@{@"appPackage": reports.appPackage,
                                                  @"installationUUID": reports.installationUuid,
                                                  @"deviceModel": reports.deviceModel,
                                                  @"screenDensity": reports.screenDensity,
                                                  @"screenSize": reports.screenSize,
                                                  @"numberOfCores": [NSNumber numberWithInt:reports.numberOfCores]}];

    NSArray *cpuSerializedReports = [self serializeCpuReports:reports.cpuMetrics];
    if (cpuSerializedReports.count > 0) {
        [serializedReports setValue:cpuSerializedReports forKey:@"cpu"];
    }

    return serializedReports;
}

- (NSArray *)serializeCpuReports:(NSArray<CpuMetric *> *)cpuMetrics
{
    NSMutableArray *cpuSerializedReports = [[NSMutableArray alloc] init];
    for (CpuMetric *cpuMetric in cpuMetrics) {
        [cpuSerializedReports addObject:@{@"consumption": [NSNumber numberWithInt:cpuMetric.cpuUsage],
                                          @"timestamp": [NSNumber numberWithDouble:cpuMetric.timestamp],
                                          @"appVersionName": cpuMetric.appVersionName,
                                          @"iOSVersion": cpuMetric.osVersion,
                                          @"batterySaverOn": [NSNumber numberWithBool:cpuMetric.isLowPowerModeEnabled],
                                          @"isInBackground": @NO}];
    }
    return cpuSerializedReports;
}

@end
