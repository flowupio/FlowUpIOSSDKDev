//
//  FUPCalculatorTests.m
//  SDK
//
//  Created by Sergio Gutiérrez on 09/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "FUPCalculator.h"
#import <Nimble/Nimble.h>
@import Nimble.Swift;

@interface FUPCalculatorTests : XCTestCase

@end

@implementation FUPCalculatorTests

- (void)testCalculator_ReturnsZeroMean_OfEmptyArray
{
    NSArray<NSNumber *> *values = @[];

    NSNumber *mean = [[self calculator] meanOf:values];

    expect(mean).to(equal(@0));
}

- (void)testCalculator_ReturnsOnlyValueAsMean_OfUnitaryArray
{
    NSArray<NSNumber *> *values = @[@5];

    NSNumber *mean = [[self calculator] meanOf:values];

    expect(mean).to(equal(@5));
}

- (void)testCalculator_ReturnsMeanValue_OfARegularArray
{
    NSArray<NSNumber *> *values = @[@0, @1, @2, @3, @4, @5, @6, @7, @8, @9, @10];

    NSNumber *mean = [[self calculator] meanOf:values];

    expect(mean).to(equal(@5));
}

- (void)testCalculator_ReturnsZeroPercentile_OfEmptyArray
{
    NSArray<NSNumber *> *values = @[];

    NSNumber *mean = [[self calculator] percentile10Of:values];

    expect(mean).to(equal(@0));
}

- (void)testCalculator_ReturnsOnlyValueAsPercentile_OfUnitaryArray
{
    NSArray<NSNumber *> *values = @[@5];

    NSNumber *mean = [[self calculator] percentile10Of:values];

    expect(mean).to(equal(@5));
}

- (void)testCalculator_ReturnsPercentileValue_OfARegularArray
{
    NSArray<NSNumber *> *values = @[@3, @5, @7, @8, @9, @11, @13, @15];

    NSNumber *mean = [[self calculator] percentile10Of:values];

    expect(mean).to(equal(@3));
}

- (FUPCalculator *)calculator
{
    return [[FUPCalculator alloc] init];
}

@end
