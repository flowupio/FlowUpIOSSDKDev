//
//  FUPConfigStorage.h
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPConfig.h"
#import "Async.h"
#import "FUPSqlite.h"
#import <sqlite3.h>

@interface FUPConfigStorage : NSObject

@property (readwrite, nonatomic) FUPConfig *config;

- (void)clear;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithSqlite:(FUPSqlite *)sqlite;

@end
