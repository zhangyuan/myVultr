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

@implementation AccountTableViewController

BOOL isUpdatingAccountInfo = NO;

-(void) viewDidLoad {
    [super viewDidLoad];
    
    self.balanceView = [[[NSBundle mainBundle] loadNibNamed:@"BalanceView" owner:self options:nil] objectAtIndex:0];
    self.balanceView.delegate = self;
    
    self.tableView.tableHeaderView = self.balanceView;
    
    isUpdatingAccountInfo = NO;
    
    [self refreshTableView: self.refreshControl];
    [self updateAccountInfo];
    [self loadServersLocally];
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
        [self deleteServers];
        [self saveServers:servers];
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
    } failure:^{
        [self.refreshControl endRefreshing];
    }];
}

-(void) loadServersLocally {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Server"];
    
    NSArray* entities = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    NSMutableArray* servers = [NSMutableArray arrayWithCapacity: entities.count];

    for (int i = 0; i < entities.count; i++) {
        NSManagedObject* entity = entities[i];
        
        Server* server = [[Server alloc] init];
        server.mainIp = [entity valueForKey:@"mainIp"];
        server.os = [entity valueForKey:@"os"];
        server.location = [entity valueForKey:@"location"];
        server.status = [entity valueForKey:@"status"];
        [servers addObject:server];
    }
    
    self.servers = servers;
    [self.tableView reloadData];
}

-(void) deleteServers {
    NSManagedObjectContext *managedObjectContext = [self managedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Server"];
    
    NSArray * result = [managedObjectContext executeFetchRequest:fetchRequest error:nil];
    
    for (id server in result) {
        [managedObjectContext deleteObject:server];
    }
}

-(void) saveServers:(NSArray*) servers {
    NSManagedObjectContext *context = [self managedObjectContext];
    
    for (int i = 0; i < servers.count; i++) {
        Server* server = [servers objectAtIndex:i];
        NSManagedObject *entity = [NSEntityDescription insertNewObjectForEntityForName:@"Server" inManagedObjectContext:context];
        
        [entity setValue:server.mainIp forKey:@"mainIp"];
        [entity setValue:server.os forKey:@"os"];
        [entity setValue:server.status forKey:@"status"];
        [entity setValue:server.location forKey:@"location"];
        
        NSError *error = nil;
        if (![context save:&error]) {
            NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
        }
    }
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
