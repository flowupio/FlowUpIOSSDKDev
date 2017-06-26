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
                   NSLog(@"Error reported correctly");
               }
               failure:^(NSURLSessionDataTask *task, NSError *error) {
                   NSLog(@"Error while reporting an error: %@", error.description);
               }];
}

@end
