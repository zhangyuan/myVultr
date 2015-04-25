//
//  ServerRepository.m
//  myVultr
//
//  Created by zhangyuan on 4/25/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIApplication.h>
#import <CoreData/CoreData.h>
#import "ServerRepository.h"
#import "Server.h"

@implementation ServerRepository

- (NSArray*) loadAll {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Server"];
    
    NSArray* entities = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    NSMutableArray* servers = [NSMutableArray arrayWithCapacity: entities.count];
    
    for (int i = 0; i < entities.count; i++) {
        NSManagedObject* entity = entities[i];
        
        Server* server = [[Server alloc] init];
        server.mainIp = [entity valueForKey:@"mainIp"];
        server.os = [entity valueForKey:@"os"];
        server.location = [entity valueForKey:@"location"];
        server.status = [entity valueForKey:@"status"];
        [servers addObject:server];
    }

    return servers;
}

- (void) saveCollection:(NSArray*) collection {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    for (int i = 0; i < collection.count; i++) {
        Server* server = [collection objectAtIndex:i];
        NSManagedObject *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Server" inManagedObjectContext:context];
        
        [entity setValue:server.mainIp forKey:@"mainIp"];
        [entity setValue:server.os forKey:@"os"];
        [entity setValue:server.status forKey:@"status"];
        [entity setValue:server.location forKey:@"location"];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
}


-(void) deleteAll {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Server"];
    
    NSArray * result = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    for (id server in result) {
        [managedObjectContext deleteObject:server];
    }
}

@end
