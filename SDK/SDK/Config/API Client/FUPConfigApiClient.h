//
//  FUPConfigApiClient.h
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPApiClient.h"
#import "FUPConfig.h"
#import "FUPResult.h"
#import "FUPConfigApiMapper.h"

@interface FUPConfigApiClient : FUPApiClient

- (instancetype)init NS_UNAVAILABLE;

- (void)getConfigWithCompletion:(void (^)(FUPResult<FUPConfig *, FUPApiClientError *> *))completion;

@end
