//
//  Reports.h
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CPUMetric.h"

@interface Reports : NSObject

@property (readonly, nonatomic, copy) NSString *appPackage;
@property (readonly, nonatomic, copy) NSString *installationUuid;
@property (readonly, nonatomic, copy) NSString *deviceModel;
@property (readonly, nonatomic, copy) NSString *screenDensity;
@property (readonly, nonatomic, copy) NSString *screenSize;
@property (readonly, nonatomic, copy) NSString *numberOfCores;
@property (readonly, nonatomic, copy) CPUMetric *cpu;

@end
