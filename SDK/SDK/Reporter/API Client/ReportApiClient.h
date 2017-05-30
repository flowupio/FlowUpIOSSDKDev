//
//  ReportApiClient.h
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reports.h"
#import "FUPResult.h"
#import "FUPApiClientError.h"
#import "ApiClient.h"
#import "Device.h"

@interface ReportApiClient : ApiClient

- (instancetype)init NS_UNAVAILABLE;

- (void)sendReports:(Reports *)reports completion:(void (^)(FUPApiClientError *))completion;

@end
