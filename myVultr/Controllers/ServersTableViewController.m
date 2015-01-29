//
//  ServerTableViewController.m
//  myVultr
//
//  Created by zhangyuan on 1/29/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#import "ServersTableViewController.h"
#import "Vultr.h"
#import "Server.h"

@implementation ServersTableViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    [Vultr servers:[Vultr defaultApiKey] success:^(NSArray *servers) {
        self.servers = servers;
        [self.tableView reloadData];
    } failure:^{
        
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

@end
