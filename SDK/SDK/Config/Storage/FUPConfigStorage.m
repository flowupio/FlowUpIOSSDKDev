//
//  FUPConfigStorage.m
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPConfigStorage.h"

@implementation FUPConfigStorage

- (void)clear
{
    self.config = [[FUPConfig alloc] initWithIsEnabled:YES];
}

@end
