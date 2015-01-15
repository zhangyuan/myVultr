//
//  AccountInfo.h
//  myVultr
//
//  Created by zhangyuan on 1/15/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#ifndef myVultr_AccountInfo_h
#define myVultr_AccountInfo_h

@interface AccountInfo : NSObject

@property (nonatomic) NSString* balance;
@property (nonatomic) NSString* pendingCharges;
@property (nonatomic, copy) NSString* lastPaymentDate;
@property (nonatomic, copy) NSString* lastPaymentAmount;

@end


#endif
