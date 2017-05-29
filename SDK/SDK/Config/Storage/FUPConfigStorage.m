//
//  FUPConfigStorage.m
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPConfigStorage.h"

@implementation FUPConfigStorage

- (instancetype)init
{
    self = [super init];
    if (self) {
        _config = [[FUPConfig alloc] initWithIsEnabled:YES];
    }
    return self;
}

- (void)clear
{
    self.config = nil;
}

@end
