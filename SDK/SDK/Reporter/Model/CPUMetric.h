//
//  CPUMetric.h
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CPUMetric : NSObject

@property (readonly, nonatomic) NSInteger cpuUsage;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCpuUsage:(NSInteger)cpuUsage;

@end
