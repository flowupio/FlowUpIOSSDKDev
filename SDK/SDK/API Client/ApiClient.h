//
//  ApiClient.h
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "AFNetworkActivityLogger.h"
#import "Configuration.h"

@interface ApiClient : NSObject

@property (readonly, nonatomic, strong) AFHTTPSessionManager *manager;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithBaseUrl:(NSString *)baseUrl
                         apiKey:(NSString *)apiKey
                           uuid:(NSString *)uuid;

- (NSString *)urlStringWithEndpoint:(NSString *)endpoint;

@end
