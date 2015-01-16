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
    self.updatedAtLabel.text = @"";
    
    NSString* apiKey = [Vultr defaultApiKey];
    
    [Vultr accountInfo:apiKey success:^(AccountInfo *accountInfo) {
        self.balanceValueLabel.text = [NSString stringWithFormat:@"%@", accountInfo.balance];
        self.pendingChargesValueLabel.text = [NSString stringWithFormat:@"%@", accountInfo.pendingCharges];
        
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

        self.updatedAtLabel.text = [NSString stringWithFormat:@"Updated at %@", [dateformatter stringFromDate:[NSDate date]]];
        
        isUpdatingAccountInfo = NO;
    } failure:^{
        isUpdatingAccountInfo = NO;
        self.updatedAtLabel.text = @"Fail to update";
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    if (cell == self.overviewCell) {
        [self updateAccountInfo];
    }
}

@end
