//
//  FUPResult.h
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FUPResult<Value, Error> : NSObject

@property (readonly, nonatomic) Value value;
@property (readonly, nonatomic) Error error;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithValue:(Value)value;
- (instancetype)initWithError:(Error)error;
- (BOOL)hasValue;
- (BOOL)hasError;

@end
