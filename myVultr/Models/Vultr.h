//
//  Vultr.h
//  myVultr
//
//  Created by zhangyuan on 1/15/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#ifndef myVultr_Vultr_h
#define myVultr_Vultr_h

#import "Account.h"
#import "Server.h"

@interface Vultr : NSObject

+(void) accountInfo:(NSString*) apiKey success:(void (^)(Account* accountInfo))success failure: (void (^)(NSError *error)) failure;
+(void) regions:(NSString*) apiKey success:(void (^)(NSArray* regions))success failure: (void (^)()) failure;
+(void) servers:(NSString*) apiKey success:(void (^)(NSArray* servers))success failure: (void (^)()) failure;
@end

@interface Region : NSObject
@property (nonatomic, copy) NSString* dcid;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* country;
@property (nonatomic, copy) NSString* state;
@property (nonatomic, copy) NSString* continent;

@end

#endif
