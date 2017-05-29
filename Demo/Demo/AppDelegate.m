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
    [FlowUp application:application didFinishLaunchingWithOptions:launchOptions apiKey:@"15207698c544f617e2c11151ada4972e1e7d6e8e"];
    return YES;
}
@end
