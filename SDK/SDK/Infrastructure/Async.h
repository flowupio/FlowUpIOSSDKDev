//
//  Async.h
//  SDK
//
//  Created by Sergio Gutiérrez on 26/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#ifndef Async_h
#define Async_h

NS_INLINE void async(dispatch_queue_t queue, dispatch_block_t block) {
#ifdef RUN_SYNC
    dispatch_async(queue, block);
#else
    dispatch_sync(queue, block);
#endif
}

#endif /* Async_h */
