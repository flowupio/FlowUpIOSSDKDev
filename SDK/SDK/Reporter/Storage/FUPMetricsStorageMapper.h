//
//  FUPMetricsStorageMapper.h
//  SDK
//
//  Created by Sergio Gutiérrez on 08/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPMetric.h"
#import <sqlite3.h>

@interface FUPMetricsStorageMapper : NSObject

- (NSString *)stringFromMetricValues:(NSDictionary *)values;
- (FUPMetric *)metricFromStatement:(sqlite3_stmt *)statement;

@end
