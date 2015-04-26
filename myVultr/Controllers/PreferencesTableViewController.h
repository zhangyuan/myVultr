//
//  PreferencesTableViewController.h
//  myVultr
//
//  Created by zhangyuan on 4/26/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountRepository.h"

@interface PreferencesTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableViewCell *apiKeyTableViewCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *signOutTableViewCell;
@property (strong, nonatomic) AccountRepository* accountRepository;
@property (strong, nonatomic) IBOutlet UITableViewCell *versionTableViewCell;
@end
