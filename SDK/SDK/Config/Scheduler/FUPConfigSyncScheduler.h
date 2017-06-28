//
//  FUPConfigSyncScheduler.h
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPConfigService.h"
#import "FUPSafetyNet.h"
#import "FUPTime.h"
#import "FUPAsync.h"

@interface FUPConfigSyncScheduler : NSObject

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithConfigService:(FUPConfigService *)configService
                            safetyNet:(FUPSafetyNet *)safetyNet
                                 time:(FUPTime *)time;

- (void)start;

@end
