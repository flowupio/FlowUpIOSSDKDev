//
//  FUPStatisticalValue.h
//  SDK
//
//  Created by Sergio Gutiérrez on 08/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FUPStatisticalValue : NSObject

@property (readonly, nonatomic) NSNumber *mean;
@property (readonly, nonatomic) NSNumber *percentile10;
@property (readonly, nonatomic) NSNumber *percentile90;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithMean:(NSNumber *)mean
                percentile10:(NSNumber *)percentile10
                percentile90:(NSNumber *)percentile90;

@end
