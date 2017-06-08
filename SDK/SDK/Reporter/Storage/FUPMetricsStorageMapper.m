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

@end
