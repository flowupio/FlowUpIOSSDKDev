//
//  UuidGenerator.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "UuidGenerator.h"

static NSString *const UuidKey = @"FlowUp.UUID";

@implementation UuidGenerator

- (NSString *)uuid
{
    if (![self hasStoredUuid]) {
        [self storeUuid:[[NSUUID UUID] UUIDString]];
    }

    return [[NSUserDefaults standardUserDefaults] stringForKey:UuidKey];
}

- (BOOL)hasStoredUuid
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:UuidKey] != nil;
}

- (void)storeUuid:(NSString *)uuid
{
    [[NSUserDefaults standardUserDefaults] setValue:uuid forKey:UuidKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
