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

    NSArray *cpuSerializedReports = [self serializeMetrics:reports.cpuMetrics];
    if (cpuSerializedReports.count > 0) {
        [serializedReports setValue:cpuSerializedReports forKey:@"cpu"];
    }

    NSArray *uiSerializedReports = [self serializeMetrics:reports.uiMetrics];
    if (cpuSerializedReports.count > 0) {
        [serializedReports setValue:uiSerializedReports forKey:@"ui"];
    }

    return serializedReports;
}

- (NSArray *)serializeMetrics:(NSArray<FUPMetric *> *)metrics
{
    NSMutableArray *serializedReports = [[NSMutableArray alloc] init];
    for (FUPMetric *metric in metrics) {
        NSMutableDictionary *serializedReport = [[NSMutableDictionary alloc] initWithDictionary:metric.values];
        [serializedReport setValue:[NSNumber numberWithDouble:metric.timestamp] forKey:@"timestamp"];
        [serializedReport setValue:metric.appVersionName forKey:@"appVersionName"];
        [serializedReport setValue:metric.osVersion forKey:@"iOSVersion"];
        [serializedReport setValue:[NSNumber numberWithBool:metric.isLowPowerModeEnabled] forKey:@"batterySaverOn"];
        [serializedReport setValue:@NO forKey:@"isInBackground"];
        [serializedReports addObject:serializedReport];
    }
    return serializedReports;
}

@end
