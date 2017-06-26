//
//  FUPCrashReporterApiClient.h
//  SDK
//
//  Created by Sergio Gutiérrez on 26/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPApiClient.h"
#import "FUPCrashReport.h"

@interface FUPCrashReporterApiClient : FUPApiClient

- (instancetype)init NS_UNAVAILABLE;

- (void)sendReport:(FUPCrashReport *)report
        completion:(void (^)(FUPApiClientError *))completion;

@end
