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
    for (int i = 0; i < 10000; i++) {
        [[NSUserDefaults standardUserDefaults] setInteger:i forKey:[NSString stringWithFormat:@"Value #%d", i]];
    }

    [FlowUp application:application didFinishLaunchingWithOptions:launchOptions apiKey:@"NO API KEY YET :(" isDebugModeEnabled:YES];
    return YES;
}
@end
