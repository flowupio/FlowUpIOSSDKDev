//
//  FUPApiClient.m
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPApiClient.h"

static NSInteger const FUPUnauthorizedStatusCode = 401;
static NSInteger const FUPForbiddenStatusCode = 403;
static NSInteger const FUPPreconditionFailedStatusCode = 412;
static NSInteger const FUPServerErrorStatusCode = 500;

@interface FUPApiClient ()

@property (readonly, nonatomic, copy) NSString *baseUrl;
@property (readonly, nonatomic) FUPDebugModeStorage *debugModeStorage;

@end

@implementation FUPApiClient

- (instancetype)initWithBaseUrl:(NSString *)baseUrl
                         apiKey:(NSString *)apiKey
                           uuid:(NSString *)uuid
               debugModeStorage:(FUPDebugModeStorage *)debugModeStorage
{
    self = [super init];
    if (self) {
        _debugModeStorage = debugModeStorage;
        _manager = [self sessionManagerWithApiKey:apiKey uuid:uuid];
        _baseUrl = baseUrl;
    }
    return self;
}

- (NSString *)urlStringWithEndpoint:(NSString *)endpoint
{
    return [NSString stringWithFormat:@"%@/%@", self.baseUrl, endpoint];
}

- (FUPApiClientError *)mapError:(NSError *)error
{
    NSHTTPURLResponse *response = error.userInfo[AFNetworkingOperationFailingURLResponseErrorKey];
    switch (response.statusCode) {
        case FUPUnauthorizedStatusCode:
        case FUPForbiddenStatusCode:
            return [FUPApiClientError unauthorized];
        case FUPPreconditionFailedStatusCode:
            return [FUPApiClientError clientDisabled];
        case FUPServerErrorStatusCode:
            return [FUPApiClientError serverError];
        default:
            return [FUPApiClientError unknown];
    }
}

- (AFHTTPSessionManager *)sessionManagerWithApiKey:(NSString *)apiKey uuid:(NSString *)uuid
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:[self userAgent] forHTTPHeaderField:@"User-Agent"];
    [manager.requestSerializer setValue:uuid forHTTPHeaderField:@"X-UUID"];
    [manager.requestSerializer setValue:apiKey forHTTPHeaderField:@"X-Api-Key"];
    [manager.requestSerializer setValue:self.debugModeStorage.isDebugModeEnabled ? @"true" : @"false" forHTTPHeaderField:@"X-Debug-Mode"];
    return manager;
}

- (NSString *)userAgent
{
    NSString *userAgent = [NSString stringWithFormat:@"FlowUpIOSSDK/%@", SDKVersion];

    if (self.debugModeStorage.isDebugModeEnabled) {
        userAgent = [userAgent stringByAppendingString:@"-DEBUG"];
    }

    return userAgent;
}

@end
