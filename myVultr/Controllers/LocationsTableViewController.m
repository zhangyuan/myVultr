//
//  LocationsTableViewController.m
//  myVultr
//
//  Created by zhangyuan on 1/16/15.
//  Copyright (c) 2015 nextcloudmedia. All rights reserved.
//

#import "LocationsTableViewController.h"
#import "Vultr.h"

@implementation LocationsTableViewController

-(void) viewDidLoad {
    [super viewDidLoad];
    
    [self reloadRegions];
}

-(void) reloadRegions {
    [Vultr regions:nil success:^(NSArray *regions) {
        self.regions = regions;
        
        [self.tableView reloadData];
    } failure:^{
        
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Region* region = [self.regions objectAtIndex:indexPath.row];
    
    static NSString *simpleTableIdentifier = @"LocationTableCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = region.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", region.continent, region.country];

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.regions count];
}

@end
