//
//  FUPConfig.m
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPConfig.h"

@implementation FUPConfig

- (instancetype)initWithIsEnabled:(BOOL)isEnabled
{
    self = [super init];
    if (self) {
        _isEnabled = isEnabled;
    }
    return self;
}

- (FUPConfig *)disable
{
    return [[FUPConfig alloc] initWithIsEnabled:NO];
}

@end
