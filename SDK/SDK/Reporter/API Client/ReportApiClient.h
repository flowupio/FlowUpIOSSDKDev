//
//  ReportApiClient.h
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reports.h"
#import "AFNetworking.h"
#import "ApiClient.h"

@interface ReportApiClient : ApiClient

@property (readonly, nonatomic, strong) AFHTTPRequestSerializer *serializer;

- (instancetype)init NS_UNAVAILABLE;
- (void)sendReports:(Reports *)reports;

@end
