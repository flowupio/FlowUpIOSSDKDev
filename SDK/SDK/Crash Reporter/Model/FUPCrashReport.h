//
//  FUPCrashReport.h
//  SDK
//
//  Created by Sergio Gutiérrez on 26/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FUPCrashReport : NSObject

@property (readonly, nonatomic, copy) NSString *deviceModel;
@property (readonly, nonatomic, copy) NSString *osVersion;
@property (readonly, nonatomic) BOOL isLowPowerModeEnabled;
@property (readonly, nonatomic, copy) NSString *message;
@property (readonly, nonatomic, copy) NSString *stackTrace;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithDeviceModel:(NSString *)deviceModel
                         osVersion:(NSString *)osVersion
             isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
                           message:(NSString *)message
                        stackTrace:(NSString *)stackTrace;

@end
