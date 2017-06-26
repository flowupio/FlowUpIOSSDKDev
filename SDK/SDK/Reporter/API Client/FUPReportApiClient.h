//
//  FUPReportApiClient.h
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPReports.h"
#import "FUPResult.h"
#import "FUPApiClientError.h"
#import "FUPApiClient.h"
#import "FUPDevice.h"

@interface FUPReportApiClient : FUPApiClient

- (instancetype)init NS_UNAVAILABLE;

- (void)sendReports:(FUPReports *)reports
         completion:(void (^)(FUPApiClientError *))completion;

@end
