//
//  FUPJsonMatcher.h
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
@import Nocilla;

@interface FUPJsonMatcher : LSMatcher <LSMatcheable>

- (instancetype)initWithJsonObject:(NSDictionary *)jsonObject;

@end
