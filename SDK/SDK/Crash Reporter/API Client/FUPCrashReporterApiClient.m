//
//  FUPCrashReporterApiClient.m
//  SDK
//
//  Created by Sergio Gutiérrez on 26/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPCrashReporterApiClient.h"

@interface FUPCrashReporterApiClient ()

@property (readonly, nonatomic) FUPDevice *device;

@end

@implementation FUPCrashReporterApiClient

- (instancetype)initWithBaseUrl:(NSString *)baseUrl
                         apiKey:(NSString *)apiKey
                           uuid:(NSString *)uuid
               debugModeStorage:(FUPDebugModeStorage *)debugModeStorage
                         device:(FUPDevice *)device
{
    self = [super initWithBaseUrl:baseUrl apiKey:apiKey uuid:uuid debugModeStorage:debugModeStorage];
    if (self) {
        _device = device;
    }
    return self;
}

- (void)sendException:(NSException *)exception
{
    NSMutableString *stackTrace = [[NSMutableString alloc] init];
    for (NSString *symbol in exception.callStackSymbols) {
        [stackTrace appendString:symbol];
    }
    NSDictionary *serializedReport = @{@"deviceModel": self.device.deviceModel,
                                       @"osVersion": self.device.osVersion,
                                       @"batterySaverOn": [NSNumber numberWithBool: self.device.isLowPowerModeEnabled],
                                       @"message": exception.description,
                                       @"stackTrace": stackTrace};

    [self.manager POST:[self urlStringWithEndpoint:@"errorReport"]
            parameters:serializedReport
              progress:nil
               success:^(NSURLSessionDataTask *task, id responseObject) {
                   NSLog(@"Error reported correctly");
               }
               failure:^(NSURLSessionDataTask *task, NSError *error) {
                   NSLog(@"Error while reporting an error: %@", error.description);
               }];
}

@end
