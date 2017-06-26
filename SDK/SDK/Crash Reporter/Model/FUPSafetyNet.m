//
//  FUPSafetyNet.m
//  SDK
//
//  Created by Sergio Gutiérrez on 26/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPSafetyNet.h"

@interface FUPSafetyNet ()

@property (readonly, nonatomic) FUPCrashReporterApiClient *apiClient;
@property (readonly, nonatomic) FUPDevice *device;

@end

@implementation FUPSafetyNet

- (instancetype)initWithCrashReporterApiClient:(FUPCrashReporterApiClient *)apiClient
                                        device:(FUPDevice *)device
{
    self = [super init];
    if (self) {
        _apiClient = apiClient;
        _device = device;
    }
    return self;
}

- (void)runBlock:(void (^)(void))block
{
    @try {
        block();
    } @catch (NSException *exception) {
        NSLog(@"[FUPSafetyNet] Reporting error");
        [self.apiClient sendReport:[self mapException:exception] completion:^(FUPApiClientError *error) {
            if (error != nil) {
                NSLog(@"[FUPSafetyNet] There was an error reporting a crash: %@", error.description);
            }
        }];
    }
}

- (FUPCrashReport *)mapException:(NSException *)exception
{
    NSMutableString *stackTrace = [[NSMutableString alloc] init];
    for (NSString *symbol in exception.callStackSymbols) {
        [stackTrace appendString:symbol];
    }
    return [[FUPCrashReport alloc] initWithDeviceModel:self.device.deviceModel
                                             osVersion:self.device.osVersion
                                 isLowPowerModeEnabled:self.device.isLowPowerModeEnabled
                                               message:exception.description
                                            stackTrace:stackTrace];
}

@end
