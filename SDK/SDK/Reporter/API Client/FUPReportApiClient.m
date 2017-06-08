//
//  FUPReportApiClient.m
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPReportApiClient.h"

@implementation FUPReportApiClient

- (void)sendReports:(FUPReports *)reports
         completion:(void (^)(FUPApiClientError *))completion
{
    [self.manager POST:[self urlStringWithEndpoint:@"report"]
            parameters:[self serializeReports:reports]
              progress:nil
               success:^(NSURLSessionDataTask *task, id responseObject) {
                   completion(nil);
               }
               failure:^(NSURLSessionDataTask *task, NSError *error) {
                   FUPApiClientError *apiClientError = [self mapError:error];
                   completion(apiClientError);
               }];
}

- (NSDictionary *)serializeReports:(FUPReports *)reports
{
    NSMutableDictionary *serializedReports = [[NSMutableDictionary alloc] init];
    [serializedReports addEntriesFromDictionary:@{@"appPackage": reports.appPackage,
                                                  @"installationUUID": reports.installationUuid,
                                                  @"deviceModel": reports.deviceModel,
                                                  @"screenDensity": reports.screenDensity,
                                                  @"screenSize": reports.screenSize,
                                                  @"numberOfCores": [NSNumber numberWithLong:reports.numberOfCores]}];

    NSArray *cpuSerializedReports = [self serializeCpuReports:reports.cpuMetrics];
    if (cpuSerializedReports.count > 0) {
        [serializedReports setValue:cpuSerializedReports forKey:@"cpu"];
    }

    return serializedReports;
}

- (NSArray *)serializeCpuReports:(NSArray<FUPCpuMetric *> *)cpuMetrics
{
    NSMutableArray *cpuSerializedReports = [[NSMutableArray alloc] init];
    for (FUPCpuMetric *cpuMetric in cpuMetrics) {
        [cpuSerializedReports addObject:@{@"consumption": [NSNumber numberWithLong:cpuMetric.cpuUsage],
                                          @"timestamp": [NSNumber numberWithDouble:cpuMetric.timestamp],
                                          @"appVersionName": cpuMetric.appVersionName,
                                          @"iOSVersion": cpuMetric.osVersion,
                                          @"batterySaverOn": [NSNumber numberWithBool:cpuMetric.isLowPowerModeEnabled],
                                          @"isInBackground": @NO}];
    }
    return cpuSerializedReports;
}

@end
