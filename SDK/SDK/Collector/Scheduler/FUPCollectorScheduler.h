//
//  FUPCollectorScheduler.h
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPCollector.h"
#import "Async.h"

@interface FUPCollectorScheduler : NSObject

@property (readwrite, nonatomic) BOOL isEnabled;

- (void)addCollectors:(NSArray<id<FUPCollector>> *)collectors
         timeInterval:(NSTimeInterval)timeInterval;

@end
