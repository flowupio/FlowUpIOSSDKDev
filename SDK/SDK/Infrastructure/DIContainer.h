//
//  DIContainer.h
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReportScheduler.h"
#import "ReportApiClient.h"
#import "Configuration.h"

@interface DIContainer : NSObject

+ (ReportScheduler *)reportSchedulerWithApiKey:(NSString *)apiKey;

@end
