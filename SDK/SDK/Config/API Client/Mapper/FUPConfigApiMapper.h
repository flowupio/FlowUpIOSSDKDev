//
//  FUPConfigApiMapper.h
//  SDK
//
//  Created by Sergio Gutiérrez on 29/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FUPConfigApiClient.h"

@interface FUPConfigApiMapper : NSObject

+ (FUPConfig *)configFromApiResponse:(id)apiResponse;

@end
