//
//  NWPortfolioLiabilitiesTableViewController.m
//  NetWorth
//
//  Created by Johnathan Grayson on 21/06/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

#import "NWPortfolioLiabilitiesTableViewController.h"
#import "NWManagePortfolioTabViewController.h"
#import "NWHelper.h"
#import "NWConstants.h"
#import "NWItemTableViewCell.h"
#import "NWCategory.h"

@interface NWPortfolioLiabilitiesTableViewController ()

@end

@implementation NWPortfolioLiabilitiesTableViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        // Custom initialization
        self.categories = [NWHelper getLiabilityCategories];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationController *nc = (UINavigationController *)[self parentViewController];
    NWManagePortfolioTabViewController *tabView = (NWManagePortfolioTabViewController *)[nc parentViewController];
    self.account = tabView.account;
    self.user = tabView.user;
    
    if(![[PFUser currentUser].objectId isEqualToString:self.user.objectId])
    {
        self.addLiabilityButton.enabled = NO;
    }
    
    [self loadLiabilities];
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
    return [self.liabilities count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NWItemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LiabilityCell" forIndexPath:indexPath];
    
    PFObject *liability = [self.liabilities objectAtIndex:indexPath.row];
    
    [cell.titleLabel setText:[liability objectForKey:@"name"]];
    
    NSString *val = [liability objectForKey:@"value"];
    NSNumber *nval = [[NSNumber alloc] initWithFloat:[val floatValue]];
    NSString *sval = [NWHelper formatNumberAsMoney:nval];
    
    [cell.valueLabel setText:sval];
    
    int catId = 0;
    if([liability objectForKey:@"category"] != nil) {
        catId = [[liability objectForKey:@"category"] intValue];
    }
    
    NWCategory *cat = [self.categories objectAtIndex:catId];
    [cell.categoryLabel setText:cat.name];
    
    PFObject *user = [liability objectForKey:@"author"];
    if(![[PFUser currentUser].objectId isEqualToString:user.objectId])
    {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddLiability"]) {
        NWLiabilityDetailsViewController *viewController = segue.destinationViewController;
        
        viewController.delegate = self;
        viewController.user = [self user];
        viewController.account = [self account];
    } else if ([segue.identifier isEqualToString:@"EditLiability"]) {
        NWLiabilityDetailsViewController *viewController = segue.destinationViewController;
        
        viewController.delegate = self;
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        
        PFObject *liability = [self.liabilities objectAtIndex:indexPath.row];
        
        viewController.liability = liability;
        viewController.user = [self user];
        viewController.account = [self account];
    }
}

- (void)loadLiabilities
{
    self.liabilities = [NSMutableArray arrayWithCapacity:0];
    
    PFQuery *postQuery = [PFQuery queryWithClassName:ItemClassName];
    
    // Follow relationship
    [postQuery whereKey:@"author" equalTo:self.user];
    [postQuery whereKey:@"account" equalTo:[self account]];
    [postQuery whereKey:@"type" equalTo:LiabilityTypeName];
    
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [self.liabilities removeAllObjects]; // Store results
            [self.liabilities addObjectsFromArray:objects];
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

- (void)liabilityDetailsViewControllerDidCancel:(NWLiabilityDetailsViewController *)controller
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (void)liabilityDetailsViewController:(NWLiabilityDetailsViewController *)controller didSaveLiability:(PFObject *)liability
{
    [self loadLiabilities];
    
    [[self navigationController] popViewControllerAnimated:YES];
}

@end
