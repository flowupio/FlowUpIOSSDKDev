//
//  FUPConfigSyncScheduler.h
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPConfigService.h"
#import "TimeProvider.h"
#import "Async.h"

#ifdef DEBUG
#   define NSLog(...) NSLog(__VA_ARGS__)
#else
#   define NSLog(...) (void)0
#endif

@interface FUPConfigSyncScheduler : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithConfigService:(FUPConfigService *)configService
                                 time:(TimeProvider *)time;

- (void)start;

@end
