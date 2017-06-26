//
//  FUPCrashReport.m
//  SDK
//
//  Created by Sergio Gutiérrez on 26/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPCrashReport.h"

@implementation FUPCrashReport

- (instancetype)initWithDeviceModel:(NSString *)deviceModel
                         osVersion:(NSString *)osVersion
             isLowPowerModeEnabled:(BOOL)isLowPowerModeEnabled
                           message:(NSString *)message
                        stackTrace:(NSString *)stackTrace
{
    self = [super init];
    if (self) {
        _deviceModel = deviceModel;
        _osVersion = osVersion;
        _isLowPowerModeEnabled = isLowPowerModeEnabled;
        _message = message;
        _stackTrace = stackTrace;
    }
    return self;
}

@end
