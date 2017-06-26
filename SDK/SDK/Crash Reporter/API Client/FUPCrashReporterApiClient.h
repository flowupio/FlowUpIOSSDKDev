//
//  FUPCrashReporterApiClient.h
//  SDK
//
//  Created by Sergio Gutiérrez on 26/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPApiClient.h"
#import "FUPDevice.h"

@interface FUPCrashReporterApiClient : FUPApiClient

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithBaseUrl:(NSString *)baseUrl
                         apiKey:(NSString *)apiKey
                           uuid:(NSString *)uuid
               debugModeStorage:(FUPDebugModeStorage *)debugModeStorage
                         device:(FUPDevice *)device;

- (void)sendException:(NSException *)exception;

@end
