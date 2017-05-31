//
//  AppDelegate.m
//  Demo
//
//  Created by Sergio Gutiérrez on 23/05/17.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FlowUp application:application didFinishLaunchingWithOptions:launchOptions apiKey:@"7ba4c8394bba4420a65973df7e5a2df2"];
    return YES;
}
@end
