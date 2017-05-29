//
//  FUPFlowUpConfig.m
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPFlowUpConfig.h"

@interface FUPFlowUpConfig ()

@property (readonly, nonatomic) FUPConfigApiClient *apiClient;
@property (readonly, nonatomic) FUPConfigStorage *storage;

@end

@implementation FUPFlowUpConfig

- (instancetype)initWithApiClient:(FUPConfigApiClient *)apiClient
                          storage:(FUPConfigStorage *)storage
{
    self = [super init];
    if (self) {
        _apiClient = apiClient;
        _storage = storage;
    }
    return self;
}

- (BOOL)isEnabled
{
    return self.storage.config.isEnabled;
}

- (void)update
{
    [self.apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *result) {
        if ([result hasValue]) {
            self.storage.config = result.value;
        }
    }];
}

- (void)disable
{
    self.storage.config = [self.storage.config disable];
}

@end
