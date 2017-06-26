//
//  FUPTime.h
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPTimeIntervalUnits.h"

@interface FUPTime : NSObject

@property (readonly, nonatomic) NSTimeInterval now;
@property (readonly, nonatomic) int64_t nowInMillis;

@end
