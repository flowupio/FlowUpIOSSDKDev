//
//  ApiClient.m
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "ApiClient.h"

@interface ApiClient ()

@property (readonly, nonatomic, copy) NSString *baseUrl;

@end

@implementation ApiClient

- (instancetype)initWithBaseUrl:(NSString *)baseUrl
{
    self = [super init];
    if (self) {
        _manager = [self sessionManager];
        _baseUrl = baseUrl;
    }
    return self;
}

- (NSString *)urlStringWithEndpoint:(NSString *)endpoint
{
    return [NSString stringWithFormat:@"%@/%@", self.baseUrl, endpoint];
}

- (AFHTTPSessionManager *)sessionManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [[AFNetworkActivityLogger sharedLogger] startLogging];
    for (id<AFNetworkActivityLoggerProtocol> logger in [[AFNetworkActivityLogger sharedLogger] loggers]) {
        [logger setLevel:AFLoggerLevelDebug];
    }
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"gzip" forHTTPHeaderField:@"Content-Encoding"];
    return manager;
}

@end
