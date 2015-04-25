//
//  AccountTableViewController.h
//  
//
//  Created by zhangyuan on 1/15/15.
//
//

#import <UIKit/UIKit.h>
#import "BalanceView.h"
#import "ServerRepository.h"

@interface AccountTableViewController : UITableViewController  <BalanceViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *balanceValueLabel;
@property (strong, nonatomic) IBOutlet UILabel *pendingChargesValueLabel;
@property (strong, nonatomic) IBOutlet UITableViewCell *overviewCell;
@property (strong, nonatomic) IBOutlet UILabel *updatedAtLabel;
@property (strong, nonatomic) BalanceView* balanceView;
@property (nonatomic, strong) NSArray* servers;
@property (strong, nonatomic) ServerRepository* serverRepository;

- (IBAction)refreshTableView:(id)sender;

@end
