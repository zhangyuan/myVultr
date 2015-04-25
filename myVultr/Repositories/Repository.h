//
//  Repository.h
//  myVultr
//
//  Created by zhangyuan on 4/25/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#ifndef myVultr_Repository_h
#define myVultr_Repository_h

#import <CoreData/CoreData.h>

@interface Repository : NSObject

- (NSManagedObjectContext *)managedObjectContext;

@end

#endif
