//
//  NWPortfolioEditItemTableViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 11/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWPortfolioAssetsTableViewController.h"
#import "NWAsset.h"

@interface NWPortfolioAssetsTableViewController ()

@end

@implementation NWPortfolioAssetsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.assets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AssetCell" forIndexPath:indexPath];
    
    NWAsset *asset = (self.assets)[indexPath.row];
    cell.textLabel.text = asset.name;
    
    return cell;
}

@end
