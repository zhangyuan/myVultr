//
//  AccountTableViewController.m
//  
//
//  Created by zhangyuan on 1/15/15.
//
//

#import <CoreData/CoreData.h>
#import "AccountTableViewController.h"
#import "Vultr.h"
#import "Account.h"
#import "ServerRepository.h"
#import "ServerDetailsTableViewController.h"

@implementation AccountTableViewController

BOOL isUpdatingAccountInfo = NO;

-(void) viewDidLoad {
    [super viewDidLoad];
    
    self.balanceView = [[[NSBundle mainBundle] loadNibNamed:@"BalanceView" owner:self options:nil] objectAtIndex:0];
    self.balanceView.delegate = self;
    self.tableView.tableHeaderView = self.balanceView;
    
    self.serverRepository = [[ServerRepository alloc] init];
    self.accountRepository = [[AccountRepository alloc] init];
    
    isUpdatingAccountInfo = NO;
    
    [self loadAccountLocally];
    [self loadServersLocally];
    
    [self refreshTableView: self.refreshControl];
}

- (void)onTap:(BalanceView *)view {

}

- (IBAction)refreshTableView:(id)sender {
    [self loadServersRemotely];
    [self loadAccountRemotely];
}

-(void) loadServersRemotely {
    [Vultr servers: self.account.apiKey success:^(NSArray *servers) {
        self.servers = servers;
        
        [self.serverRepository deleteAll];
        [self.serverRepository saveCollection:servers];
        
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    } failure:^{
        [self.refreshControl endRefreshing];
    }];
}

-(void) loadServersLocally {
    self.servers = [self.serverRepository loadAll];
    [self.tableView reloadData];
}

-(void) loadAccountLocally {
    self.account = [self.accountRepository first];
    [self renderBalanceView];
}

-(void) renderBalanceView {
    if (self.account) {
        self.balanceView.balanceValueLabel.text = [NSString stringWithFormat:@"%@", self.account.balance];
        self.balanceView.pendingChargesValueLabel.text = [NSString stringWithFormat:@"%@", self.account.pendingCharges];
        
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc]init];
        [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        self.balanceView.updatedAtLabel.text = [NSString stringWithFormat:@"Updated at %@", [dateformatter stringFromDate:self.account.updatedAt]];
    }
    
}

-(void) loadAccountRemotely {
    if (isUpdatingAccountInfo == YES) {
        return;
    }
    isUpdatingAccountInfo = YES;
    self.balanceView.balanceValueLabel.text = @"Loading...";
    self.balanceView.pendingChargesValueLabel.text = @"Loading...";
    self.balanceView.updatedAtLabel.text = @"";
    
    NSString* apiKey = self.account.apiKey;
    
    [Vultr accountInfo:apiKey success:^(Account *account) {
        [self.accountRepository deleteAll];
        [self.accountRepository save:account];
        [self loadAccountLocally];
        isUpdatingAccountInfo = NO;
        [self.refreshControl endRefreshing];
    } failure:^(NSError* error){
        [self loadAccountLocally];
        isUpdatingAccountInfo = NO;
        self.balanceView.updatedAtLabel.text = @"Fail to update";
        [self.refreshControl endRefreshing];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showServerDetails"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        ServerDetailsTableViewController *destViewController = segue.destinationViewController;
        destViewController.server = [self.servers objectAtIndex:indexPath.row];
    }
    
    UIViewController* controller = segue.destinationViewController;
    controller.hidesBottomBarWhenPushed = YES;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Server* server = [self.servers objectAtIndex:indexPath.row];
    
    static NSString *simpleTableIdentifier = @"ServerTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = server.mainIp;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ - %@ - %@", server.location, server.os, server.status];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.servers count];
}

@end
