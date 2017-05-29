//
//  FUPConfigStorage.h
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPConfig.h"

@interface FUPConfigStorage : NSObject

@property (readwrite, nonatomic) FUPConfig *config;

- (void)clear;

@end
