//
//  FUPMetricsStorageMapper.m
//  SDK
//
//  Created by Sergio Gutiérrez on 08/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPMetricsStorageMapper.h"

@implementation FUPMetricsStorageMapper

- (NSString *)stringFromMetricValues:(NSDictionary *)values
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:values
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:nil];
    return [[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"\"" withString:@"'"];
}

- (FUPMetric *)metricFromStatement:(sqlite3_stmt *)statement
{
    NSString *metricValues = [[NSString stringWithFormat:@"%s", sqlite3_column_text(statement, 6)] stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
    NSDictionary *values = [NSJSONSerialization JSONObjectWithData:[metricValues dataUsingEncoding:NSUTF8StringEncoding]
                                                           options:NSJSONReadingMutableContainers
                                                             error:nil];
    return [[FUPMetric alloc] initWithTimestamp:sqlite3_column_double(statement, 1)
                                           name:[NSString stringWithFormat:@"%s", sqlite3_column_text(statement, 2)]
                                 appVersionName:[NSString stringWithFormat:@"%s", sqlite3_column_text(statement, 3)]
                                      osVersion:[NSString stringWithFormat:@"%s", sqlite3_column_text(statement, 4)]
                          isLowPowerModeEnabled:[[NSNumber numberWithInt:sqlite3_column_int(statement, 5)] boolValue]
                                         values:values];
}

@end
