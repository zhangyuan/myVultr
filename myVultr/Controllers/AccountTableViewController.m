//
//  AccountTableViewController.m
//  
//
//  Created by zhangyuan on 1/15/15.
//
//

#import "AccountTableViewController.h"
#import "Vultr.h"
#import "AccountInfo.h"

@implementation AccountTableViewController

BOOL isUpdatingAccountInfo = NO;

-(void) viewDidLoad {
    [super viewDidLoad];
    
    isUpdatingAccountInfo = NO;
    
    [self updateAccountInfo];
}

-(void) updateAccountInfo {
    isUpdatingAccountInfo = YES;
    self.balanceValueLabel.text = @"Loading...";
    self.pendingChargesValueLabel.text = @"Loading...";
    
    NSString* apiKey = [Vultr defaultApiKey];
    
    [Vultr accountInfo:apiKey success:^(AccountInfo *accountInfo) {
        self.balanceValueLabel.text = [NSString stringWithFormat:@"%@", accountInfo.balance];
        self.pendingChargesValueLabel.text = [NSString stringWithFormat:@"%@", accountInfo.pendingCharges];
        isUpdatingAccountInfo = NO;
    } failure:^{
        isUpdatingAccountInfo = NO;
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == self.overviewCell) {
        [self updateAccountInfo];
    }
}

@end
