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

@end

@implementation FUPSafetyNet

- (instancetype)initWithCrashReporterApiClient:(FUPCrashReporterApiClient *)apiClient
{
    self = [super init];
    if (self) {
        _apiClient = apiClient;
    }
    return self;
}

- (void)runBlock:(void (^)(void))block
{
    @try {
        block();
    } @catch (NSException *exception) {
        [self.apiClient sendException:exception];
    }
}

@end
