//
//  FUPApiClientError.m
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPApiClientError.h"

@implementation FUPApiClientError

+ (instancetype)unauthorized
{
    return [[FUPApiClientError alloc] initWithCode:FUPApiClientErrorCodeUnauthorized];
}

+ (instancetype)serverError
{
    return [[FUPApiClientError alloc] initWithCode:FUPApiClientErrorCodeServerError];
}

+ (instancetype)clientDisabled
{
    return [[FUPApiClientError alloc] initWithCode:FUPApiClientErrorCodeClientDisabled];
}

+ (instancetype)unknown
{
    return [[FUPApiClientError alloc] initWithCode:FUPApiClientErrorCodeUnknown];
}

- (instancetype)initWithCode:(FUPApiClientErrorCode)code
{
    self = [super init];
    if (self) {
        _code = code;
    }
    return self;
}

@end
