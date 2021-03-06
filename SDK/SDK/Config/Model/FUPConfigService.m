//
//  FUPConfigService.m
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPConfigService.h"

@interface FUPConfigService ()

@property (readonly, nonatomic) FUPConfigApiClient *apiClient;
@property (readonly, nonatomic) FUPConfigStorage *storage;

@end

@implementation FUPConfigService

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

- (BOOL)enabled
{
    return self.storage.config.isEnabled;
}

- (void)updateWithCompletion:(void (^)(BOOL))completion
{
    [self.apiClient getConfigWithCompletion:^(FUPResult<FUPConfig *,FUPApiClientError *> *result) {
        if ([result hasValue]) {
            self.storage.config = result.value;
        }

        if (completion != nil) {
            completion(!result.hasError);
        }
    }];
}

- (FUPConfig *)disable
{
    self.storage.config = [self.storage.config disable];
    return self.storage.config;
}

@end
