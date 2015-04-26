//
//  ServerDetailsTableViewController.h
//  myVultr
//
//  Created by zhangyuan on 4/26/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Server.h"

@interface ServerDetailsTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableViewCell *ipTableViewCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *statusTableViewCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *locationTableViewCell;
@property (strong, nonatomic) Server* server;
@property (strong, nonatomic) IBOutlet UITableViewCell *osUITableViewCell;

@end
