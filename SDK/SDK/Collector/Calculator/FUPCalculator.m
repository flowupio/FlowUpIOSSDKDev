//
//  FUPCalculator.m
//  SDK
//
//  Created by Sergio Gutiérrez on 08/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPCalculator.h"

@implementation FUPCalculator

- (NSNumber *)meanOf:(NSArray<NSNumber *> *)values
{
    double total = 0;
    for (NSNumber *value in values) {
        total += value.doubleValue;
    }
    return [NSNumber numberWithDouble:(total / values.count)];
}

- (NSNumber *)percentile10Of:(NSArray<NSNumber *> *)values
{
    return [self percentile:10 of:values];
}

- (NSNumber *)percentile90Of:(NSArray<NSNumber *> *)values
{
    return [self percentile:90 of:values];
}

- (NSNumber *)percentile:(int)percentile of:(NSArray<NSNumber *> *)values
{
    NSArray<NSNumber *> *sortedValues = [values sortedArrayUsingSelector:@selector(compare:)];
    return sortedValues[(int) ceil(sortedValues.count * (percentile / 100.0))];
}

@end
