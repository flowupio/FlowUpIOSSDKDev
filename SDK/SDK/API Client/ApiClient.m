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

- (instancetype)initWithManager:(AFHTTPSessionManager *)manager
                        baseUrl:(NSString *)baseUrl
{
    self = [super init];
    if (self) {
        _manager = manager;
        _baseUrl = baseUrl;
    }
    return self;
}

- (NSString *)urlStringWithEndpoint:(NSString *)endpoint
{
    return [NSString stringWithFormat:@"%@/%@", self.baseUrl, endpoint];
}

@end
