//
//  FUPConfigApiMapper.m
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPConfigApiMapper.h"

@implementation FUPConfigApiMapper

+ (FUPConfig *)configFromApiResponse:(id)apiResponse
{
    if (apiResponse[@"enabled"] != nil) {
        return [[FUPConfig alloc] initWithIsEnabled:[apiResponse[@"enabled"] boolValue]];
    } else {
        return [[FUPConfig alloc] initWithIsEnabled:YES];
    }
}

@end
