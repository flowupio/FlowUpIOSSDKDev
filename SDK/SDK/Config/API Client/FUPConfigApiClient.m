//
//  FUPConfigApiClient.m
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPConfigApiClient.h"

@implementation FUPConfigApiClient

- (void)getConfigWithCompletion:(void (^)(FUPResult<FUPConfig *, FUPApiClientError *> *))completion {
    [self.manager GET:[self urlStringWithEndpoint:@"config"]
            parameters:nil
              progress:nil
               success:^(NSURLSessionDataTask *task, id responseObject) {
                   NSLog(@"CONFIG: %@", responseObject);
               }
               failure:^(NSURLSessionDataTask *task, NSError *error) {
                   FUPResult *result = [[FUPResult alloc] initWithError:FUPApiClientError.unknown];
                   completion(result);
               }];
}

@end
