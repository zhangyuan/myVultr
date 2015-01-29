//
//  Server.h
//  myVultr
//
//  Created by zhangyuan on 1/29/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#ifndef myVultr_Server_h
#define myVultr_Server_h

@interface Server : NSObject

@property (nonatomic, copy) NSString* mainIp;
@property (nonatomic, copy) NSString* os;
@property (nonatomic, copy) NSString* location;
@property (nonatomic, copy) NSString* status;
@end

#endif
