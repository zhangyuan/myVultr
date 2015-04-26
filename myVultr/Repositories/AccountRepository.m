//
//  AccountRepository.m
//  myVultr
//
//  Created by zhangyuan on 4/25/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"
#import "AccountRepository.h"

@implementation AccountRepository

-(Account*) first{
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Account"];
    
    NSArray* entities = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    if (entities.count > 0) {
        NSManagedObject* entity = entities[0];
        Account* account = [[Account alloc] init];
        account.balance = [entity valueForKey:@"balance"];
        account.pendingCharges = [entity valueForKey:@"pendingCharges"];
        account.updatedAt = [entity valueForKey:@"updatedAt"];
        return  account;
    } else {
        return nil;
    }
}

-(void) save:(Account*) account{
    NSManagedObjectContext *context = [self managedObjectContext];

    NSManagedObject *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:context];
    
    [entity setValue: account.apiKey forKey:@"apiKey"];
    [entity setValue: account.balance forKey:@"balance"];
    [entity setValue: account.pendingCharges forKey:@"pendingCharges"];
    [entity setValue: account.updatedAt forKey:@"updatedAt"];
        
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
}

@end