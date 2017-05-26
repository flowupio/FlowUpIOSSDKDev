//
//  ApiClientTests.h
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface ApiClientTests : XCTestCase

- (NSDictionary *)fromJsonFileWithName:(NSString *)fileName;

@end
