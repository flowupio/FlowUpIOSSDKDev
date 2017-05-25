//
//  Device.h
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import "UuidGenerator.h"

@interface Device : NSObject

@property (readonly, nonatomic, copy) NSString *appPackage;
@property (readonly, nonatomic, copy) NSString *appVersionName;
@property (readonly, nonatomic, copy) NSString *osVersion;
@property (readonly, nonatomic, copy) NSString *installationUuid;
@property (readonly, nonatomic, copy) NSString *deviceModel;
@property (readonly, nonatomic, copy) NSString *screenDensity;
@property (readonly, nonatomic, copy) NSString *screenSize;
@property (readonly, nonatomic) NSInteger numberOfCores;
@property (readonly, nonatomic) BOOL isLowPowerModeEnabled;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithUuidGenerator:(UuidGenerator *)uuidGenerator;

@end
