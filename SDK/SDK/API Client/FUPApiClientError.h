//
//  FUPApiClientError.h
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FUPApiClientErrorCode) {
    FUPApiClientErrorCodeUnauthorized,
    FUPApiClientErrorCodeServerError,
    FUPApiClientErrorCodeClientDisabled,
    FUPApiClientErrorCodeUnknown,
};

@interface FUPApiClientError : NSObject

@property (readonly, nonatomic) FUPApiClientErrorCode code;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)unauthorized;
+ (instancetype)serverError;
+ (instancetype)clientDisabled;
+ (instancetype)unknown;

@end
