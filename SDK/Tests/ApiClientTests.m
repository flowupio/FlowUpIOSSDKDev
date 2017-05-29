//
//  ApiClientTests.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "ApiClientTests.h"

@implementation ApiClientTests

- (void)setUp {
    [super setUp];
    [[LSNocilla sharedInstance] start];
}

- (void)tearDown {
    [super tearDown];
    [[LSNocilla sharedInstance] clearStubs];
    [[LSNocilla sharedInstance] stop];
}

- (NSDictionary *)fromJsonFileWithName:(NSString *)fileName
{
    NSBundle *bundle = [NSBundle bundleForClass:self.classForCoder];
    NSString *path = [bundle pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:nil];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

@end
