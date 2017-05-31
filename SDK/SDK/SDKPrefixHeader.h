//
//  SDKPrefixHeader.h
//  SDK
//
//  Created by Sergio Gutiérrez on 30/05/2017.
//  Copyright © 2017 flowup. All rights reserved.
//

#ifndef SDKPrefixHeader_h
#define SDKPrefixHeader_h

#import "NamespacedDependencies.h"

#ifdef DEBUG
#   define NSLog(...) NSLog(__VA_ARGS__)
#else
#   define NSLog(...) (void)0
#endif

#endif /* SDKPrefixHeader_h */
