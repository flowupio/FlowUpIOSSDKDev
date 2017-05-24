//
//  ReportApiClient.m
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "ReportApiClient.h"

@implementation ReportApiClient

- (void)sendReports: (Reports *) reports
{
    NSDictionary *parameters = @{@"foo": @"bar", @"baz": @[@1, @2, @3]};

    NSURLRequest *request = [self.serializer requestWithMethod:@"POST"
                                                     URLString:@""
                                                    parameters:parameters error:nil];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    [manager POST:@""
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask *task, id responseObject) {

         }
         failure:^(NSURLSessionDataTask *task, NSError *error) {
             
         }];

    [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {

    }];
}

@end
