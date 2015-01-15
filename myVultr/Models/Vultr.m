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

@end