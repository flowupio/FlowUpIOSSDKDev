//
//  FUPConfig.h
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FUPConfig : NSObject

@property (readonly, nonatomic) BOOL isEnabled;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithIsEnabled:(BOOL)isEnabled;

@end
