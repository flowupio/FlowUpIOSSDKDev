//
//  FUPStatisticalValue.m
//  SDK
//
//  Created by Sergio Gutiérrez on 08/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPStatisticalValue.h"

@implementation FUPStatisticalValue

- (instancetype)initWithMean:(NSNumber *)mean
                percentile10:(NSNumber *)percentile10
                percentile90:(NSNumber *)percentile90
{
    self = [super init];
    if (self) {
        _mean = mean;
        _percentile10 = percentile10;
        _percentile90 = percentile90;
    }
    return self;
}

@end
