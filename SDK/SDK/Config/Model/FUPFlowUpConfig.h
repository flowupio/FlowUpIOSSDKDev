//
//  FUPFlowUpConfig.h
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPConfigApiClient.h"
#import "FUPConfigStorage.h"

@interface FUPFlowUpConfig : NSObject

@property (readonly, nonatomic) BOOL enabled;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithApiClient:(FUPConfigApiClient *)apiClient
                          storage:(FUPConfigStorage *)storage;

- (void)update;
- (void)disable;

@end
