//
//  FUPFakeSafetyNet.m
//  SDK
//
//  Created by Sergio Gutiérrez on 26/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPFakeSafetyNet.h"

@implementation FUPFakeSafetyNet

- (instancetype)init
{
    self = [super initWithCrashReporterApiClient:mock([FUPCrashReporterApiClient class])
                                          device:mock([FUPDevice class])];
    if (self) {}
    return self;
}

- (void)runBlock:(void (^)(void))block
{
    block();
}

@end
