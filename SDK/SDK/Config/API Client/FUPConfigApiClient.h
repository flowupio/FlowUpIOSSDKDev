//
//  FUPConfigApiClient.h
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ApiClient.h"
#import "FUPConfig.h"
#import "FUPResult.h"
#import "FUPConfigApiMapper.h"

@interface FUPConfigApiClient : ApiClient

- (instancetype)init NS_UNAVAILABLE;

- (void)getConfigWithCompletion:(void (^)(FUPResult<FUPConfig *, FUPApiClientError *> *))completion;

@end
