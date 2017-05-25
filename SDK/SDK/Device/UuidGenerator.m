//
//  UuidGenerator.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "UuidGenerator.h"

static NSString *const uuidKey = @"FlowUp.UUID";

@implementation UuidGenerator

- (NSString *)uuid
{
    if (![self hasStoredUuid]) {
        [self storeUuid:[[NSUUID UUID] UUIDString]];
    }

    return [[NSUserDefaults standardUserDefaults] stringForKey:uuidKey];
}

- (BOOL)hasStoredUuid
{
    return [[NSUserDefaults standardUserDefaults] stringForKey:uuidKey] != nil;
}

- (void)storeUuid:(NSString *)uuid
{
    [[NSUserDefaults standardUserDefaults] setValue:uuid forKey:uuidKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
