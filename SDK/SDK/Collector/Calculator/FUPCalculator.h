//
//  FUPCalculator.h
//  SDK
//
//  Created by Sergio Gutiérrez on 08/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FUPCalculator : NSObject

- (NSNumber *)meanOf:(NSArray<NSNumber *> *)values;
- (NSNumber *)percentile10Of:(NSArray<NSNumber *> *)values;
- (NSNumber *)percentile90Of:(NSArray<NSNumber *> *)values;

@end
