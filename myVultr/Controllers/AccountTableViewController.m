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
    
    self.balanceView = [[[NSBundle mainBundle] loadNibNamed:@"BalanceView" owner:self options:nil] objectAtIndex:0];
    
    self.tableView.tableHeaderView = self.balanceView;
    isUpdatingAccountInfo = NO;
    
    [self updateAccountInfo];
}

-(void) updateAccountInfo {
    isUpdatingAccountInfo = YES;
    self.balanceView.balanceValueLabel.text = @"Loading...";
    self.balanceView.pendingChargesValueLabel.text = @"Loading...";
    self.balanceView.updatedAtLabel.text = @"";
    
    NSString* apiKey = [Vultr defaultApiKey];
    
    
    [Vultr accountInfo:apiKey success:^(AccountInfo *accountInfo) {
        self.balanceView.balanceValueLabel.text = [NSString stringWithFormat:@"%@", accountInfo.balance];
        self.balanceView.pendingChargesValueLabel.text = [NSString stringWithFormat:@"%@", accountInfo.pendingCharges];
        
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

        self.balanceView.updatedAtLabel.text = [NSString stringWithFormat:@"Updated at %@", [dateformatter stringFromDate:[NSDate date]]];
        
        isUpdatingAccountInfo = NO;
    } failure:^{
        isUpdatingAccountInfo = NO;
        self.balanceView.updatedAtLabel.text = @"Fail to update";
    }];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
