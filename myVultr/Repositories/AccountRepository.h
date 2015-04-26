//
//  AccountRepository.h
//  myVultr
//
//  Created by zhangyuan on 4/25/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#ifndef myVultr_AccountRepository_h
#define myVultr_AccountRepository_h
#import "Repository.h"
#import "Account.h"

@interface AccountRepository : Repository

- (Account*) first;
- (void) save:(Account*) account;
- (void) deleteAll;
@end

#endif
