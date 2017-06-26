//
//  ApiClient.h
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "Configuration.h"
#import "FUPApiClientError.h"
#import "FUPDebugModeStorage.h"

@interface ApiClient : NSObject

@property (readonly, nonatomic, strong) AFHTTPSessionManager *manager;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithBaseUrl:(NSString *)baseUrl
                         apiKey:(NSString *)apiKey
                           uuid:(NSString *)uuid
               debugModeStorage:(FUPDebugModeStorage *)debugModeStorage;

- (NSString *)urlStringWithEndpoint:(NSString *)endpoint;
- (FUPApiClientError *)mapError:(NSError *)error;

@end
