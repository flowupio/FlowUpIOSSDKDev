//
//  ReportApiClient.m
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "ReportApiClient.h"

@implementation ReportApiClient

- (void)sendReports:(Reports *)reports
{
    [self.manager POST:[self urlStringWithEndpoint:@"report"]
            parameters:[self serializeReports:reports]
              progress:nil
               success:^(NSURLSessionDataTask *task, id responseObject) {
                   NSLog(@"Request success: %@", responseObject);
               }
               failure:^(NSURLSessionDataTask *task, NSError *error) {
                   NSLog(@"Request error: %@", error);
               }];
}

- (NSDictionary *)serializeReports:(Reports *)reports
{
    return @{@"appPackage": @"",
             @"installationUUID": @"",
             @"deviceModel": @"",
             @"screenDensity": @"",
             @"screenSize": @"",
             @"numberOfCores": @1,
             @"cpu": @[@{@"consumption": @10,
                         @"timestamp": @12345,
                         @"appVersionName": @"",
                         @"iOSVersion": @"",
                         @"batterySaverOn": @NO,
                         @"isInBackground": @NO}]};
}

@end
