//
//  FUPResult.m
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPResult.h"

@implementation FUPResult

- (BOOL)hasValue
{
    return self.value != nil;
}

- (BOOL)hasError
{
    return self.error != nil;
}

- (instancetype)initWithValue:(id)value
{
    self = [super init];
    if (self) {
        _value = value;
        _error = nil;
    }
    return self;
}

- (instancetype)initWithError:(id)error
{
    self = [super init];
    if (self) {
        _value = nil;
        _error = error;
    }
    return self;
}

@end
