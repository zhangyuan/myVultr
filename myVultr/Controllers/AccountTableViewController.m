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

-(void) viewDidLoad {
    [super viewDidLoad];
    
    NSString* apiKey = [Vultr defaultApiKey];
    
    [Vultr accountInfo:apiKey success:^(AccountInfo *accountInfo) {
        self.balanceValueLabel.text = [NSString stringWithFormat:@"%@", accountInfo.balance];
        self.pendingChargesValueLabel.text = [NSString stringWithFormat:@"%@", accountInfo.pendingCharges];
    } failure:^{
    }];
}

@end
