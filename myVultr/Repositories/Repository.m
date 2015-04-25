//
//  Repository.m
//  myVultr
//
//  Created by zhangyuan on 4/25/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIApplication.h>
#import "Repository.h"

@implementation Repository

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end