//
//  FUPDiskUsageCollector.m
//  SDK
//
//  Created by Sergio Gutiérrez on 09/06/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPDiskUsageCollector.h"

@implementation FUPDiskUsageCollector

- (void)collect
{
    NSArray<NSString *> *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);

    if (paths.count <= 0) {
        return;
    }

    NSString *path = paths.lastObject;
    unsigned long long size = 0;
    for (NSString *subpath in [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:nil]) {
        size += [[[NSFileManager defaultManager] attributesOfItemAtPath:[NSString stringWithFormat:@"%@/%@", path, subpath] error:nil] fileSize];
    }

    NSLog(@"Total size: %llu", size);
}

@end
