//
//  Device.m
//  SDK
//
//  Created by Sergio Gutiérrez on 25/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "Device.h"

@interface Device ()

@property (readonly, nonatomic) UuidGenerator *uuidGenerator;

@end

@implementation Device

- (instancetype)initWithUuidGenerator:(UuidGenerator *)uuidGenerator
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

@end
