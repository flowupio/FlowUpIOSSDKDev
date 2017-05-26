//
//  NSDictionary+Matcheable.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "NSDictionary+Matcheable.h"

@implementation NSDictionary (Matcheable)

- (LSMatcher *)matcher
{
    return [[JsonMatcher alloc] initWithJsonObject:self];
}

@end
