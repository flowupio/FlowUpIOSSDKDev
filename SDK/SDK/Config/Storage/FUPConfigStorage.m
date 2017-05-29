//
//  FUPConfigStorage.m
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPConfigStorage.h"

@interface FUPConfigStorage ()

@property (readwrite, nonatomic) FUPConfig *storedConfig;

@end

@implementation FUPConfigStorage

- (FUPConfig *)config
{
    if (self.storedConfig == nil) {
        return [[FUPConfig alloc] initWithIsEnabled:YES];
    } else {
        return self.storedConfig;
    }
}

- (void)setConfig:(FUPConfig *)config
{
    self.storedConfig = config;
}

- (void)clear
{
    self.config = [[FUPConfig alloc] initWithIsEnabled:YES];
}

@end
