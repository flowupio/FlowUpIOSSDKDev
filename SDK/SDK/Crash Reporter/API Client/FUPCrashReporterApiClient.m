//
//  FUPCrashReporterApiClient.m
//  SDK
//
//  Created by Sergio Gutiérrez on 26/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPCrashReporterApiClient.h"

@implementation FUPCrashReporterApiClient

- (void)sendReport:(FUPCrashReport *)report
        completion:(void (^)(FUPApiClientError *))completion
{
    NSDictionary *serializedReport = @{@"deviceModel": report.deviceModel,
                                       @"osVersion": report.osVersion,
                                       @"batterySaverOn": [NSNumber numberWithBool: report.isLowPowerModeEnabled],
                                       @"message": report.message,
                                       @"stackTrace": report.stackTrace};

    [self.manager POST:[self urlStringWithEndpoint:@"errorReport"]
            parameters:serializedReport
              progress:nil
               success:^(NSURLSessionDataTask *task, id responseObject) {
                   completion(nil);
               }
               failure:^(NSURLSessionDataTask *task, NSError *error) {
                   completion(FUPApiClientError.unknown);
               }];
}

@end
