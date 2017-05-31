//
//  FUPSqlite.h
//  SDK
//
//  Created by Sergio Gutiérrez on 31/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface FUPSqlite : NSObject

@property (readonly, nonatomic) sqlite3 *db;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFileName:(NSString *)fileName;

- (BOOL)runStatement:(NSString *)statement;
- (BOOL)runQuery:(NSString *)query block:(BOOL (^)(sqlite3_stmt *))block;

@end
