//
//  AccountInfo.h
//  myVultr
//
//  Created by zhangyuan on 1/15/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#ifndef myVultr_AccountInfo_h
#define myVultr_AccountInfo_h

@interface Account : NSObject

@property (nonatomic, copy) NSString* apiKey;
@property (nonatomic, copy) NSString* balance;
@property (nonatomic, copy) NSString* pendingCharges;
@property (nonatomic, copy) NSString* lastPaymentDate;
@property (nonatomic, copy) NSString* lastPaymentAmount;
@property (nonatomic) NSDate* updatedAt;

@end


#endif
