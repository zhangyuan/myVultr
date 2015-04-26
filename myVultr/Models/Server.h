//
//  Server.h
//  myVultr
//
//  Created by zhangyuan on 1/29/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#ifndef myVultr_Server_h
#define myVultr_Server_h

#import <UIKit/UIKit.h>

@interface Server : NSObject

@property (nonatomic, copy) NSString* subId;
@property (nonatomic, copy) NSString* mainIp;
@property (nonatomic, copy) NSString* os;
@property (nonatomic, copy) NSString* location;
@property (nonatomic, copy) NSString* label;
@property (nonatomic, copy) NSString* powerStatus;
@property (nonatomic, copy) NSString* status;
@property (nonatomic, copy) NSString* ram;
@property (nonatomic, copy) NSString* disk;
@property (nonatomic, copy) NSString* vcpuCount;
@property (nonatomic, copy) NSString* dateCreated;
@property (nonatomic, copy) NSString* currentBandwidthGb;
@property (nonatomic, copy) NSString* allowedBandwidthGb;

-(NSString*) bandwidth;

@end

#endif
