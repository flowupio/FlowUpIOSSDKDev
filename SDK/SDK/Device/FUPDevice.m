//
//  FUPDevice.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPDevice.h"

@interface FUPDevice ()

@property (readonly, nonatomic) FUPUuidGenerator *uuidGenerator;

@end

@implementation FUPDevice

- (instancetype)initWithUuidGenerator:(FUPUuidGenerator *)uuidGenerator
{
    self = [super init];
    if (self) {
        _uuidGenerator = uuidGenerator;
    }
    return self;

}

- (NSString *)appPackage
{
    return [[NSBundle mainBundle] bundleIdentifier];
}

- (NSString *)appVersionName
{
    return [NSString stringWithFormat:@"%@ [%@]",
            [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"],
            [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey]];

}

- (NSString *)osVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

- (NSString *)installationUuid
{
    return self.uuidGenerator.uuid;
}

- (NSString *)deviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);

    return [NSString stringWithCString:systemInfo.machine
                              encoding:NSUTF8StringEncoding];
}

- (NSString *)screenDensity
{
    return [NSString stringWithFormat:@"x%.1f", [[UIScreen mainScreen] scale]];
}

- (NSString *)screenSize
{
    UIScreen *screen = [UIScreen mainScreen];
    return [NSString stringWithFormat:@"%dX%d",
            (int) roundf([screen bounds].size.width),
            (int) roundf([screen bounds].size.height)];
}

- (NSInteger)numberOfCores
{
    return [[NSProcessInfo processInfo] processorCount];
}

- (BOOL)isIsLowPowerModeEnabled
{
    return [[NSProcessInfo processInfo] isLowPowerModeEnabled];
}

@end
