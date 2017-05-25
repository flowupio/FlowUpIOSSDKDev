//
//  FlowUp.m
//  SDK
//
//  Created by Sergio Gutiérrez on 24/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FlowUp.h"
#import "ReportScheduler.h"
#import "ReportApiClient.h"
#import "AFNetworking.h"
#import "AFNetworkActivityLogger.h"

static NSString *const FlowUpApiBaseUrl = @"https://api.flowupapp.com";

@interface FlowUp ()

+ (ReportScheduler *)reportScheduler;
+ (ReportApiClient *)reportApiClient;

@end

@implementation FlowUp

static NSString *_apiKey;

+ (void)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions apiKey:(NSString *)apiKey
{
    _apiKey = apiKey;
    [[FlowUp reportScheduler] start];
}

#pragma mark - Properties

+ (ReportScheduler *)reportScheduler
{
    static ReportScheduler *_scheduler;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        UuidGenerator *uuidGenerator = [[UuidGenerator alloc] init];
        Device *device = [[Device alloc] initWithUuidGenerator:uuidGenerator];
        _scheduler = [[ReportScheduler alloc] initWithDevice:device
                                             reportApiClient:[FlowUp reportApiClient]];
    });

    return _scheduler;
}

+ (ReportApiClient *)reportApiClient
{
    static ReportApiClient *_apiClient;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        UuidGenerator *uuidGenerator = [[UuidGenerator alloc] init];
        _apiClient = [[ReportApiClient alloc] initWithBaseUrl:FlowUpApiBaseUrl
                                                       apiKey:_apiKey
                                                         uuid:uuidGenerator.uuid];
    });
    
    return _apiClient;
}

@end
