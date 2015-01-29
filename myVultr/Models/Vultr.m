//
//  Vultr.m
//  myVultr
//
//  Created by zhangyuan on 1/15/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#include "Vultr.h"

@implementation Region

@end


@implementation Vultr

+(NSString*) defaultApiKey {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"vultr" ofType:@"plist"];
    NSMutableDictionary* infoDict = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    
    return [infoDict valueForKey:@"api_key"];
}

+(void) accountInfo:(NSString*) apiKey success:(void (^)(AccountInfo* accountInfo))success failure: (void (^)()) failure {
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        [manager GET:@"https://api.vultr.com/v1/account/info" parameters:@{@"api_key" : apiKey} success:^(AFHTTPRequestOperation *operation, id responseObject) {            
            AccountInfo* accountInfo = [[AccountInfo alloc] init];
            
            accountInfo.balance = [NSString stringWithFormat:@"%@", responseObject[@"balance"]];
            accountInfo.pendingCharges = [NSString stringWithFormat:@"%@", responseObject[@"pending_charges"]];
            accountInfo.lastPaymentDate = responseObject[@"last_payment_date"];
            accountInfo.lastPaymentAmount = [NSString stringWithFormat:@"%@", responseObject[@"last_payment_amount"]];
            
            success(accountInfo);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
        }];
}

+(void) servers:(NSString*) apiKey success:(void (^)(NSArray* servers))success failure: (void (^)()) failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://api.vultr.com/v1/server/list" parameters:@{@"api_key" : apiKey} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        id objects = [responseObject allValues];
        
        NSMutableArray* servers = [NSMutableArray arrayWithCapacity: [objects count]];
        
        for (int i = 0; i < [objects count]; i++) {
            id serverObject = objects[i];
            
            Server* server = [[Server alloc] init];
            server.mainIp = serverObject[@"main_ip"];
            server.os = serverObject[@"os"];
            server.location = serverObject[@"location"];
            server.status = serverObject[@"status"];
            [servers addObject:server];
        }
              
        success(servers);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];

}

+(void) regions:(NSString*) apiKey success:(void (^)(NSArray* regions))success failure: (void (^)()) failure {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"https://api.vultr.com/v1/regions/list" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        id objects = [responseObject allValues];
        
        NSMutableArray* regions = [NSMutableArray arrayWithCapacity: [objects count]];
        
        for (int i = 0; i < [objects count]; i++) {
            id regionObject = objects[i];
            
            Region* region = [[Region alloc] init];
            region.dcid = regionObject[@"DCID"];
            region.name = regionObject[@"name"];
            region.country = regionObject[@"country"];
            region.continent = regionObject[@"continent"];
            region.state = regionObject[@"state"];
            
            [regions addObject:region];
        }
        
        success(regions);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

@end