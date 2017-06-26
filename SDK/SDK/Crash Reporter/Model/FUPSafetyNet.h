//
//  FUPSafetyNet.h
//  SDK
//
//  Created by Sergio Gutiérrez on 26/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPCrashReporterApiClient.h"

@interface FUPSafetyNet : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCrashReporterApiClient:(FUPCrashReporterApiClient *)apiClient;

- (void)runBlock:(void (^)(void))block;

@end
