//
//  FUPApiClientTests.h
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Nocilla/Nocilla.h>

static NSString *const ApiKey = @"This is my Api Key";
static NSString *const Uuid = @"00ecccb6-415b-11e7-a919-92ebcb67fe33";

@interface FUPApiClientTests : XCTestCase

- (NSDictionary *)dictionaryFromJsonFileWithName:(NSString *)fileName;
- (NSString *)stringFromJsonFileWithName:(NSString *)fileName;

@end
