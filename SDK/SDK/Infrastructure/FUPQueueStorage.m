//
//  FUPQueueStorage.m
//  SDK
//
//  Created by Sergio Gutiérrez on 05/07/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import "FUPQueueStorage.h"

@interface FUPQueueStorage()

@property (nonatomic, readwrite) NSMutableDictionary<NSString *, dispatch_queue_t> *queues;

@end

@implementation FUPQueueStorage

- (instancetype)init
{
    self = [super init];
    if (self) {
        _queues = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (dispatch_queue_t)queueWithName:(NSString *)name
{
    return [self queueWithName:name attributes:DISPATCH_QUEUE_SERIAL];
}

- (dispatch_queue_t)concurrentQueueWithName:(NSString *)name
{
    return [self queueWithName:name attributes:DISPATCH_QUEUE_CONCURRENT];
}

- (dispatch_queue_t)queueWithName:(NSString *)name
                       attributes:(dispatch_queue_attr_t)attributes
{
    dispatch_queue_t queue = [self.queues objectForKey:name];
    if (queue == nil) {
        queue = dispatch_queue_create([name UTF8String], attributes);
        [self.queues setObject:queue forKey:name];
    }
    return [self.queues objectForKey:name];
}

@end
