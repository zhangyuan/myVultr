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
        return [self initializeAccountManagedObject:entity];
    } else {
        return nil;
    }
}

- (void) deleteAll {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Account"];
    
    NSArray * entities = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    for (id account in entities) {
        [managedObjectContext deleteObject:account];
    }
    
    NSError *saveError = nil;
    [managedObjectContext save: &saveError];
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

-(Account*) initializeAccountManagedObject:(NSManagedObject*) entity {
    Account* account = [[Account alloc] init];
    account.apiKey = [entity valueForKey:@"apiKey"];
    account.balance = [entity valueForKey:@"balance"];
    account.pendingCharges = [entity valueForKey:@"pendingCharges"];
    account.updatedAt = [entity valueForKey:@"updatedAt"];
    return account;
}

@end