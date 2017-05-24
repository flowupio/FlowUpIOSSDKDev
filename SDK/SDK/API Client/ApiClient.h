//
//  ApiClient.h
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface ApiClient : NSObject

@property (readonly, nonatomic, strong) AFHTTPSessionManager *manager;
@property (readonly, nonatomic, copy) NSString *baseUrl;

- (instancetype)initWithManager:(AFHTTPSessionManager *)manager
                        baseUrl:(NSString *)baseUrl;

@end
