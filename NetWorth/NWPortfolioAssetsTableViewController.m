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

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        self.assets = [[NSMutableArray alloc] init];
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
    return 1;
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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddAsset"]) {
        NWAssetDetailsViewController *viewController = segue.destinationViewController;
        
        viewController.delegate = self;
    } else if ([segue.identifier isEqualToString:@"EditAsset"]) {
        NWAssetDetailsViewController *viewController = segue.destinationViewController;
        
        viewController.delegate = self;

        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        NWAsset *asset = [self.assets objectAtIndex:indexPath.row];
        
        viewController.asset = asset;
    }
}

- (IBAction)done:(id)sender
{
    UINavigationController* navigationController = (UINavigationController*)self.parentViewController;
    UITabBarController<NWTabItemProtocol>* tabBarController = (UITabBarController<NWTabItemProtocol>*)navigationController.parentViewController;
    [tabBarController portfolioViewControllerDidDone:self];
}

- (void)assetDetailsViewControllerDidCancel:(NWAssetDetailsViewController *)controller
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)assetDetailsViewController:(NWAssetDetailsViewController *)controller didSaveAsset:(NWAsset *)asset
{
    bool found = NO;
    for (int i = 0; i < self.assets.count; i++) {
        NWAsset *ac = [self.assets objectAtIndex:i];
        if(ac.id == asset.id) {
            ac.name = asset.name;
            found = YES;
            [self.tableView reloadData];
        }
    }
    
    if(!found) {
        [self.assets addObject:asset];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self.assets count] - 1) inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    
    [[self navigationController] popViewControllerAnimated:YES];
}


@end
