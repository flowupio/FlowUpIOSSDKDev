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
    if (values.count == 0) {
        return @0;
    }

    double total = 0;
    for (NSNumber *value in values) {
        total += value.doubleValue;
    }
    return [NSNumber numberWithDouble:(total / values.count)];
}

- (NSNumber *)percentile10Of:(NSArray<NSNumber *> *)values
{
    return [self quantile:0.1 of:values];
}

- (NSNumber *)percentile90Of:(NSArray<NSNumber *> *)values
{
    return [self quantile:0.9 of:values];
}

// Based on metrics implementation
// https://github.com/dropwizard/metrics/blob/9cd8f5b03285515cab6e98d49bb314cb3dd952f3/metrics-core/src/main/java/com/codahale/metrics/UniformSnapshot.java#L51
- (NSNumber *)quantile:(double)quantile of:(NSArray<NSNumber *> *)values
{
    if (values.count == 0) {
        return @0;
    }

    NSArray<NSNumber *> *sortedValues = [values sortedArrayUsingSelector:@selector(compare:)];
    double position = quantile * (sortedValues.count + 1);
    int index = position;

    if (index < 1) {
        return sortedValues[0];
    }

    if (index >= values.count) {
        return sortedValues[values.count - 1];
    }

    // Interpolate percentile value http://onlinestatbook.com/2/introduction/percentiles.html
    double lower = sortedValues[index - 1].doubleValue;
    double upper = sortedValues[index].doubleValue;
    return [NSNumber numberWithDouble: lower + (position - floor(position)) * (upper - lower)];
}

@end
