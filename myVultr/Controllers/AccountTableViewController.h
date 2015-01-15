//
//  AccountTableViewController.h
//  
//
//  Created by zhangyuan on 1/15/15.
//
//

#import <UIKit/UIKit.h>

@interface AccountTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UILabel *balanceValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *pendingChargesValueLabel;
@end
