//
//  ServerRepository.h
//  myVultr
//
//  Created by zhangyuan on 4/25/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#ifndef myVultr_ServerRepository_h
#define myVultr_ServerRepository_h

@interface ServerRepository : NSObject

- (NSArray*) loadAll;
- (void) saveCollection:(NSArray*) collection;
- (void) deleteAll;

@end

#endif
