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
#import "AccountInfo.h"
#import "ServerRepository.h"

@implementation AccountTableViewController

BOOL isUpdatingAccountInfo = NO;

-(void) viewDidLoad {
    [super viewDidLoad];
    
    self.balanceView = [[[NSBundle mainBundle] loadNibNamed:@"BalanceView" owner:self options:nil] objectAtIndex:0];
    self.balanceView.delegate = self;
    self.tableView.tableHeaderView = self.balanceView;
    
    self.serverRepository = [[ServerRepository alloc] init];
    
    isUpdatingAccountInfo = NO;
    
    [self refreshTableView: self.refreshControl];
    
    [self loadServersLocally];
    
    [self updateAccountInfo];
}

- (void)onTap:(BalanceView *)view {
    [self updateAccountInfo];
}

- (IBAction)refreshTableView:(id)sender {
    [self loadServersRemotely];
}

-(void) loadServersRemotely {
    [Vultr servers:[Vultr defaultApiKey] success:^(NSArray *servers) {
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

-(void) updateAccountInfo {
    if (isUpdatingAccountInfo == YES) {
        return;
    }
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

- (NSManagedObjectContext *)managedObjectContext {
    NSManagedObjectContext *context = nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    
    if ([delegate performSelector:@selector(managedObjectContext)]) {
        context = [delegate managedObjectContext];
    }
    return context;
}

@end
