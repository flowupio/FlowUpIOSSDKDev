//
//  FUPQueueStorage.h
//  SDK
//
//  Created by Sergio Gutiérrez on 05/07/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FUPQueueStorage : NSObject

- (dispatch_queue_t)queueWithName:(NSString *)name;
- (dispatch_queue_t)concurrentQueueWithName:(NSString *)name;

@end
