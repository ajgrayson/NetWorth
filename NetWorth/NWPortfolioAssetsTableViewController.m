//
//  NWPortfolioEditItemTableViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 11/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWPortfolioAssetsTableViewController.h"
#import "NWManagePortfolioTabViewController.h"
#import "NWHelper.h"
#import "NWConstants.h"

@interface NWPortfolioAssetsTableViewController ()

@end

@implementation NWPortfolioAssetsTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
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
    
    UINavigationController *nc = (UINavigationController *)[self parentViewController];
    NWManagePortfolioTabViewController *tabView = (NWManagePortfolioTabViewController *)[nc parentViewController];
    self.account = tabView.account;
    self.user = tabView.user;
    
    [self loadAssets];
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

    PFObject *asset = [self.assets objectAtIndex:indexPath.row];
    [cell.textLabel setText:[asset objectForKey:@"name"]];
    [cell.detailTextLabel setText:[asset objectForKey:@"value"]];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddAsset"]) {
        NWAssetDetailsViewController *viewController = segue.destinationViewController;
        
        viewController.delegate = self;
        viewController.user = [self user];
        viewController.account = [self account];
    } else if ([segue.identifier isEqualToString:@"EditAsset"]) {
        NWAssetDetailsViewController *viewController = segue.destinationViewController;
        
        viewController.delegate = self;

        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        PFObject *asset = [self.assets objectAtIndex:indexPath.row];
        
        viewController.asset = asset;
        viewController.user = [self user];
        viewController.account = [self account];
    }
}

- (void)loadAssets
{
    self.assets = [NSMutableArray arrayWithCapacity:0];
    
    PFQuery *postQuery = [PFQuery queryWithClassName:ItemClassName];
    
    // Follow relationship
    [postQuery whereKey:@"author" equalTo:[PFUser currentUser]];
    [postQuery whereKey:@"account" equalTo:[self account]];
    [postQuery whereKey:@"type" equalTo:AssetTypeName];
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [self.assets removeAllObjects];           // Store results
            [self.assets addObjectsFromArray:objects];
            [self.tableView reloadData];   // Reload table
        }
    }];
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

- (void)assetDetailsViewController:(NWAssetDetailsViewController *)controller didSaveAsset:(PFObject *)asset
{
    [self loadAssets];
    
    [[self navigationController] popViewControllerAnimated:YES];
}


@end
