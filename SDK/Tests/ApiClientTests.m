//
//  ApiClientTests.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "ApiClientTests.h"

@implementation ApiClientTests

- (NSString *)fromFileWithName:(NSString *)fileName fileExtension:(NSString *)fileExtension
{
    NSBundle *bundle = [NSBundle bundleForClass:self.classForCoder];
    NSString *path = [bundle pathForResource:fileName ofType:fileExtension];
    return [[NSString stringWithContentsOfFile:path
                                      encoding:NSUTF8StringEncoding
                                         error:nil]
            stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

@end
